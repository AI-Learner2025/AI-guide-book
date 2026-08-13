[CmdletBinding()]
param(
    [switch]$Update,
    [switch]$Force,
    [switch]$CLIOnly,
    [switch]$AppOnly,
    [switch]$WithDevTools,
    [switch]$SkipDependencies,
    [string]$MsixPath
)

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
$script:LogPath = Join-Path $env:TEMP "codex-install.log"
$script:TranscriptStarted = $false

$CliInstallerUrl = "https://chatgpt.com/codex/install.ps1"
$StoreProductId = "9PLM9XGG6VKS"
$MsixUrls = @{
    "x64"   = "https://persistent.oaistatic.com/codex-app-prod/ChatGPT-x64.msix"
    "arm64" = "https://persistent.oaistatic.com/codex-app-prod/ChatGPT-arm64.msix"
}

function Write-Status {
    param(
        [Parameter(Mandatory = $true)][string]$Message,
        [ValidateSet("Info", "Success", "Warning", "Error")][string]$Level = "Info"
    )

    $color = switch ($Level) {
        "Success" { "Green" }
        "Warning" { "Yellow" }
        "Error"   { "Red" }
        default   { "Cyan" }
    }
    $prefix = switch ($Level) {
        "Success" { "[完成]" }
        "Warning" { "[提示]" }
        "Error"   { "[错误]" }
        default   { "[信息]" }
    }

    Write-Host "$prefix $Message" -ForegroundColor $color
}

function Start-InstallerLog {
    try {
        Start-Transcript -Path $script:LogPath -Append | Out-Null
        $script:TranscriptStarted = $true
    }
    catch {
        Write-Status "无法启动详细日志：$($_.Exception.Message)" "Warning"
    }
}

function Stop-InstallerLog {
    if ($script:TranscriptStarted) {
        try {
            Stop-Transcript | Out-Null
        }
        catch {
            # 安装结果不应因日志关闭失败而改变。
        }
    }
}

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-Command {
    param([Parameter(Mandatory = $true)][string]$Name)
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Invoke-Download {
    param(
        [Parameter(Mandatory = $true)][string]$Uri,
        [Parameter(Mandatory = $true)][string]$Destination
    )

    [Net.ServicePointManager]::SecurityProtocol =
        [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    $lastError = $null
    for ($attempt = 1; $attempt -le 3; $attempt++) {
        try {
            Write-Status "正在下载：$Uri（第 $attempt 次尝试）"
            Invoke-WebRequest -Uri $Uri -OutFile $Destination -UseBasicParsing
            if (-not (Test-Path -LiteralPath $Destination) -or
                (Get-Item -LiteralPath $Destination).Length -eq 0) {
                throw "下载结果为空。"
            }
            return
        }
        catch {
            $lastError = $_
            if ($attempt -lt 3) {
                Start-Sleep -Seconds (2 * $attempt)
            }
        }
    }

    throw "下载失败：$($lastError.Exception.Message)"
}

function Refresh-ProcessPath {
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"
}

function Get-CodexCommand {
    Refresh-ProcessPath
    $command = Get-Command "codex" -ErrorAction SilentlyContinue
    if ($null -ne $command) {
        return $command.Source
    }

    $standalonePath = Join-Path $env:LOCALAPPDATA "Programs\OpenAI\Codex\bin\codex.exe"
    if (Test-Path -LiteralPath $standalonePath) {
        return $standalonePath
    }
    return $null
}

function Get-CodexCliVersion {
    $command = Get-CodexCommand
    if ($null -eq $command) {
        return $null
    }

    try {
        $version = & $command --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            return ($version | Out-String).Trim()
        }
    }
    catch {
        return $null
    }
    return $null
}

function Install-CodexCli {
    $currentVersion = Get-CodexCliVersion
    if ($currentVersion -and -not $Update -and -not $Force) {
        Write-Status "Codex CLI 已安装（$currentVersion），跳过。使用 -Update 可更新。" "Success"
        return
    }

    if ($currentVersion) {
        Write-Status "准备更新 Codex CLI，当前版本：$currentVersion"
    }
    else {
        Write-Status "准备安装 Codex CLI。"
    }

    $installerFile = Join-Path ([IO.Path]::GetTempPath()) ("codex-official-installer-{0}.ps1" -f [Guid]::NewGuid())
    try {
        Invoke-Download -Uri $CliInstallerUrl -Destination $installerFile
        $env:CODEX_NON_INTERACTIVE = "1"
        $powerShellCommand = if ($PSVersionTable.PSEdition -eq "Core") {
            Get-Command "pwsh.exe" -ErrorAction Stop
        }
        else {
            Get-Command "powershell.exe" -ErrorAction Stop
        }
        & $powerShellCommand.Source -NoLogo -NoProfile -ExecutionPolicy Bypass -File $installerFile
        $installerExitCode = $LASTEXITCODE
        if ($installerExitCode -ne 0) {
            throw "官方安装脚本退出码为 $installerExitCode。"
        }
    }
    finally {
        Remove-Item -LiteralPath $installerFile -Force -ErrorAction SilentlyContinue
        Remove-Item Env:CODEX_NON_INTERACTIVE -ErrorAction SilentlyContinue
    }

    $installedVersion = Get-CodexCliVersion
    if (-not $installedVersion) {
        throw "CLI 安装脚本已结束，但未能运行 codex --version。请重新打开终端后检查 PATH。"
    }
    Write-Status "Codex CLI 安装成功：$installedVersion" "Success"
}

function Get-CodexAppPackage {
    $packages = Get-AppxPackage -ErrorAction SilentlyContinue
    return $packages |
        Where-Object {
            $_.PackageFamilyName -like "*_2p2nqsd0c76g0" -or
            $_.Name -like "*OpenAI*ChatGPT*" -or
            $_.Name -like "*OpenAI*Codex*"
        } |
        Sort-Object Version -Descending |
        Select-Object -First 1
}

function Get-WindowsArchitecture {
    $architecture = $env:PROCESSOR_ARCHITEW6432
    if ([string]::IsNullOrWhiteSpace($architecture)) {
        $architecture = $env:PROCESSOR_ARCHITECTURE
    }

    if ($architecture -match "ARM64") {
        return "arm64"
    }
    if ($architecture -match "AMD64") {
        return "x64"
    }
    throw "不支持的 Windows 架构：$architecture。官方桌面 App 仅提供 x64 和 Arm64 包。"
}

function Test-MsixSignature {
    param([Parameter(Mandatory = $true)][string]$Path)

    $signature = Get-AuthenticodeSignature -FilePath $Path
    if ($signature.Status -ne [System.Management.Automation.SignatureStatus]::Valid) {
        throw "MSIX 数字签名无效，状态：$($signature.Status)。已拒绝安装。"
    }

    $hash = (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash
    Write-Status "MSIX 签名有效；SHA256：$hash"
}

function Install-CodexAppFromMsix {
    param([string]$SourcePath)

    $downloadedFile = $null
    if ([string]::IsNullOrWhiteSpace($SourcePath)) {
        $architecture = Get-WindowsArchitecture
        $downloadedFile = Join-Path ([IO.Path]::GetTempPath()) ("ChatGPT-{0}-{1}.msix" -f $architecture, [Guid]::NewGuid())
        Invoke-Download -Uri $MsixUrls[$architecture] -Destination $downloadedFile
        $SourcePath = $downloadedFile
    }
    else {
        $SourcePath = (Resolve-Path -LiteralPath $SourcePath).Path
        Write-Status "使用本地 MSIX：$SourcePath"
    }

    try {
        Test-MsixSignature -Path $SourcePath
        Add-AppxPackage -Path $SourcePath -ForceApplicationShutdown
    }
    finally {
        if ($downloadedFile) {
            Remove-Item -LiteralPath $downloadedFile -Force -ErrorAction SilentlyContinue
        }
    }
}

function Invoke-WingetAppInstall {
    if (-not (Test-Command "winget")) {
        return $false
    }

    if ($Update) {
        Write-Status "正在通过 Microsoft Store 更新桌面 App。"
        $wingetOutput = & winget upgrade --id $StoreProductId -s msstore -e --accept-source-agreements --accept-package-agreements --disable-interactivity 2>&1
    }
    else {
        Write-Status "正在通过 Microsoft Store 安装桌面 App。"
        $wingetOutput = & winget install --id $StoreProductId -s msstore -e --accept-source-agreements --accept-package-agreements --disable-interactivity 2>&1
    }
    $wingetExitCode = $LASTEXITCODE
    foreach ($line in $wingetOutput) {
        Write-Host $line
    }
    return ($wingetExitCode -eq 0)
}

function Install-CodexApp {
    $currentPackage = Get-CodexAppPackage
    if ($currentPackage -and -not $Update -and -not $Force -and [string]::IsNullOrWhiteSpace($MsixPath)) {
        Write-Status "桌面 App 已安装（$($currentPackage.Version)），跳过。使用 -Update 可更新。" "Success"
        return
    }

    if (-not [string]::IsNullOrWhiteSpace($MsixPath)) {
        Install-CodexAppFromMsix -SourcePath $MsixPath
    }
    else {
        $wingetSucceeded = Invoke-WingetAppInstall
        if (-not $wingetSucceeded) {
            Write-Status "Microsoft Store 安装不可用，改用 OpenAI 官方签名 MSIX。" "Warning"
            Install-CodexAppFromMsix
        }
    }

    $installedPackage = Get-CodexAppPackage
    if (-not $installedPackage) {
        throw "桌面 App 安装命令已结束，但未检测到对应的 Appx 包。"
    }
    Write-Status "桌面 App 安装成功：$($installedPackage.Name) $($installedPackage.Version)" "Success"
}

function Ensure-WingetPackage {
    param(
        [Parameter(Mandatory = $true)][string]$Id,
        [Parameter(Mandatory = $true)][string]$DisplayName
    )

    & winget list --id $Id -e --disable-interactivity | Out-Null
    if ($LASTEXITCODE -eq 0 -and -not $Force) {
        Write-Status "$DisplayName 已安装，跳过。" "Success"
        return
    }

    Write-Status "正在安装/更新可选工具：$DisplayName"
    if ($Update) {
        & winget upgrade --id $Id -e --accept-source-agreements --accept-package-agreements --disable-interactivity
        if ($LASTEXITCODE -eq 0) {
            return
        }
    }

    & winget install --id $Id -e --accept-source-agreements --accept-package-agreements --disable-interactivity
    if ($LASTEXITCODE -ne 0) {
        throw "$DisplayName 安装失败，winget 退出码：$LASTEXITCODE。"
    }
}

function Install-OptionalDevTools {
    if (-not $WithDevTools -or $SkipDependencies) {
        return
    }
    if (-not (Test-Command "winget")) {
        throw "安装可选开发工具需要 winget。请先安装 Microsoft App Installer，或去掉 -WithDevTools。"
    }

    $packages = @(
        @{ Id = "Git.Git"; DisplayName = "Git" },
        @{ Id = "OpenJS.NodeJS.LTS"; DisplayName = "Node.js LTS" },
        @{ Id = "Python.Python.3.12"; DisplayName = "Python 3.12" },
        @{ Id = "GitHub.cli"; DisplayName = "GitHub CLI" }
    )
    foreach ($package in $packages) {
        Ensure-WingetPackage -Id $package.Id -DisplayName $package.DisplayName
    }
    Refresh-ProcessPath
}

function Assert-Arguments {
    if ($CLIOnly -and $AppOnly) {
        throw "-CLIOnly 与 -AppOnly 不能同时使用。"
    }
    if ($WithDevTools -and $SkipDependencies) {
        throw "-WithDevTools 与 -SkipDependencies 不能同时使用。"
    }
    if ($CLIOnly -and -not [string]::IsNullOrWhiteSpace($MsixPath)) {
        throw "-CLIOnly 不能与 -MsixPath 同时使用。"
    }
    if ($env:OS -ne "Windows_NT") {
        throw "此脚本只支持 Windows。"
    }
}

function Main {
    Assert-Arguments
    Start-InstallerLog

    Write-Host ""
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host " Codex 一键安装工具（Windows，非 OpenAI 官方工具）" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Status "日志文件：$script:LogPath"

    if (Test-IsAdministrator) {
        Write-Status "当前 PowerShell 已以管理员身份运行。"
    }
    else {
        Write-Status "当前为普通用户模式；CLI 和当前用户 App 通常无需管理员权限。" "Warning"
    }

    Install-OptionalDevTools

    if (-not $AppOnly) {
        Install-CodexCli
    }
    if (-not $CLIOnly) {
        Install-CodexApp
    }

    Write-Host ""
    Write-Status "全部指定任务已完成。" "Success"
    if (-not $AppOnly) {
        Write-Status "可运行 codex --version 验证 CLI；若当前窗口找不到命令，请新开终端。"
    }
}

try {
    Main
    exit 0
}
catch {
    Write-Host ""
    Write-Status $_.Exception.Message "Error"
    Write-Status "安装未完成。详情请查看：$script:LogPath" "Warning"
    exit 1
}
finally {
    Stop-InstallerLog
}
