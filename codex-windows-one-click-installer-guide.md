# Windows 一键安装 Codex：下载脚本并完成安装

> 更新日期：2026-08-13

本项目提供一个 Windows 安装辅助脚本，用于一次性安装或更新：

- Codex CLI
- ChatGPT Windows App，其中包含 Codex 工作流
- 可选的 Git、Node.js、Python 和 GitHub CLI

脚本是社区维护的辅助工具，不是 OpenAI 官方工具。它不会重新打包 Codex，默认从 OpenAI、Microsoft Store 和 winget 获取安装内容，并会在安装 MSIX 前检查数字签名。

## 一、下载脚本

先连接稳定、合法合规的系统级 VPN/代理，再打开 GitHub 仓库：

https://github.com/AI-Learner2025/AI-guide-book/tree/main/installers/codex-windows

需要下载这两个文件，并放在同一个文件夹：

- [Install-Codex.ps1](https://github.com/AI-Learner2025/AI-guide-book/raw/main/installers/codex-windows/Install-Codex.ps1)
- [双击安装.cmd](https://github.com/AI-Learner2025/AI-guide-book/raw/main/installers/codex-windows/%E5%8F%8C%E5%87%BB%E5%AE%89%E8%A3%85.cmd)

也可以在文件列表页点击文件，再点击下载按钮。

不要只下载 `.ps1` 文件后双击运行。`.cmd` 文件会自动调用 PowerShell，并传递必要的执行参数。

## 二、最快安装方式

1. 将两个文件下载到同一个目录。
2. 双击 `双击安装.cmd`。
3. 等待安装完成。
4. 重新打开 PowerShell 或 Windows Terminal。
5. 执行：

```powershell
codex --version
```

如果能显示版本号，说明 Codex CLI 已安装成功。然后打开 ChatGPT Windows App，登录账号并进入 Codex。

## 三、PowerShell 安装方式

如果不想双击文件，可以在脚本所在目录打开 PowerShell，执行：

```powershell
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File .\Install-Codex.ps1
```

这个 `ExecutionPolicy Bypass` 只对当前安装进程生效，不会永久修改系统执行策略。

## 四、安装选项

### 只安装 Codex CLI

```powershell
.\Install-Codex.ps1 -CLIOnly
```

### 只安装 ChatGPT Windows App

```powershell
.\Install-Codex.ps1 -AppOnly
```

### 安装 CLI、桌面 App 和开发工具

```powershell
.\Install-Codex.ps1 -WithDevTools
```

这会通过 winget 安装：

```text
Git
Node.js LTS
Python 3.12
GitHub CLI
```

### 更新已有安装

```powershell
.\Install-Codex.ps1 -Update
```

### 强制重新安装

```powershell
.\Install-Codex.ps1 -Force
```

### 使用本地 MSIX

如果 Microsoft Store 不可用，可以准备对应架构的官方 MSIX，然后执行：

```powershell
.\Install-Codex.ps1 -AppOnly -MsixPath .\ChatGPT-x64.msix
```

脚本会先检查 MSIX 的 Authenticode 数字签名，签名无效时会拒绝安装。

## 五、安装内容和下载来源

默认情况下，脚本会处理两部分：

1. 通过 OpenAI 官方安装脚本安装 Codex CLI。
2. 优先通过 Microsoft Store 的 winget 源安装 ChatGPT Windows App；失败后再下载 OpenAI 官方签名的 x64 或 Arm64 MSIX。

脚本使用的官方地址：

- CLI 安装脚本：https://chatgpt.com/codex/install.ps1
- Windows x64 MSIX：https://persistent.oaistatic.com/codex-app-prod/ChatGPT-x64.msix
- Windows Arm64 MSIX：https://persistent.oaistatic.com/codex-app-prod/ChatGPT-arm64.msix
- Microsoft Store 产品 ID：`9PLM9XGG6VKS`

脚本不会默认安装 Node.js、Python 等工具，只有使用 `-WithDevTools` 时才会安装。

## 六、安装完成后的第一次使用

重新打开 PowerShell，进入项目目录：

```powershell
cd C:\path\to\your-project
codex
```

第一次运行时按提示登录 ChatGPT 账号。登录后可以先输入：

```text
请先阅读这个项目，不要修改文件，告诉我项目结构、启动方法和主要风险。
```

确认 Codex 能正常读取项目后，再让它修改代码或运行测试。

## 七、日志和常见问题

### 安装后找不到 `codex`

关闭当前终端，重新打开 PowerShell 或 Windows Terminal，再执行：

```powershell
codex --version
```

### 双击后窗口一闪而过

在脚本目录空白处右键，选择“在终端中打开”，再执行：

```powershell
.\Install-Codex.ps1
```

### Microsoft Store 不可用

脚本会自动尝试 OpenAI 官方签名 MSIX。也可以手动下载对应架构的 MSIX，再使用 `-MsixPath` 安装。

### 下载失败或登录超时

检查系统级 VPN/代理是否连接，并确认可以访问：

```text
chatgpt.com
persistent.oaistatic.com
github.com
```

### 查看详细日志

日志默认保存在：

```text
%TEMP%\codex-install.log
```

## 八、安全检查

- 只从本仓库下载脚本。
- 不要把脚本内容替换成陌生人发来的版本。
- 不要关闭 MSIX 签名校验。
- 不要在脚本或公开截图中放入账号密码、API Key 或 Token。
- 企业电脑如果禁止 winget 或 MSIX 安装，请联系管理员。

脚本文件：

- [Install-Codex.ps1](./installers/codex-windows/Install-Codex.ps1)
- [双击安装.cmd](./installers/codex-windows/双击安装.cmd)

文件 SHA-256：

```text
Install-Codex.ps1
7aacbe31091dc98e4df673b29b516fa298199eade74b2ca451476bed260c2ddf

双击安装.cmd
d43b1369530fe5a74a0b6f6948863b615401ab4dd2973e9f2c867c8a8741a8da
```
