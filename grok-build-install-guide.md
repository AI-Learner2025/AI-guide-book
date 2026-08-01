# Grok Build 安装教程：macOS、Windows 和 Linux

> 更新日期：2026-08-01  
> Grok Build 是 xAI 推出的终端编程 Agent，启动命令是 `grok`。

## 一、安装前准备

准备以下内容：

- 一个可以登录 Grok 的账号，或一个 xAI API Key。
- macOS、Linux、WSL，或者 Windows PowerShell。
- 一个稳定的网络环境。
- Git，方便后续打开和管理代码仓库。

如果官网、安装脚本或登录页面打不开，先连接稳定、合法合规的系统级 VPN/代理：

https://hyperaicc.com/

官方入口：

- [Grok Build 官网](https://x.ai/cli)
- [Grok Build 官方文档](https://docs.x.ai/build/overview)
- [Grok Build GitHub](https://github.com/xai-org/grok-build)

## 二、macOS 安装

打开“终端”，执行官方安装命令：

```bash
curl -fsSL https://x.ai/cli/install.sh | bash
```

安装完成后关闭并重新打开终端，然后检查版本：

```bash
grok --version
```

如果能显示版本号，说明安装成功。

## 三、Linux 和 WSL 安装

Ubuntu、Debian、Fedora、Arch Linux 和 Windows WSL 都可以使用同一条命令：

```bash
curl -fsSL https://x.ai/cli/install.sh | bash
```

安装后执行：

```bash
grok --version
```

在 WSL 中使用时，需要在 Ubuntu 或其他 WSL 发行版的终端里执行命令，不要在 Windows CMD 中执行 Bash 命令。

## 四、Windows 安装

### PowerShell 安装

打开 PowerShell，执行：

```powershell
irm https://x.ai/cli/install.ps1 | iex
```

安装完成后重新打开 PowerShell，检查版本：

```powershell
grok --version
```

### Git Bash 安装

已经安装 Git for Windows 的用户，也可以打开 Git Bash 执行：

```bash
curl -fsSL https://x.ai/cli/install.sh | bash
```

普通 Windows 用户优先使用 PowerShell，使用 WSL 的开发者则在 WSL 终端中执行 Linux 安装命令。

## 五、第一次启动和登录

先进入一个代码项目：

```bash
cd your-project
grok
```

第一次启动时，Grok Build 会引导你通过浏览器或设备码完成登录。登录成功后，可以先输入：

```text
请阅读当前项目，不要修改文件，告诉我项目结构、启动方法和主要功能。
```

确认 Grok Build 能正常读取项目后，再让它修改代码。

## 六、使用 API Key 登录

远程服务器、CI 或无法打开浏览器的环境，可以使用 xAI API Key。

macOS、Linux 或 WSL：

```bash
export XAI_API_KEY="xai-你的密钥"
grok
```

Windows PowerShell：

```powershell
$env:XAI_API_KEY="xai-你的密钥"
grok
```

不要把 API Key 写入代码、README、Git 提交或公开截图。

## 七、更新 Grok Build

执行：

```bash
grok update
```

更新后检查版本：

```bash
grok --version
```

版本更新记录可以查看：

- [Grok Build Changelog](https://x.ai/build/changelog)

## 八、从源码安装

Grok Build 已经开源。需要研究源码、修改程序或使用本地模型的开发者，可以自行构建：

```bash
git clone https://github.com/xai-org/grok-build.git
cd grok-build
cargo install dotslash
cargo build -p xai-grok-pager-bin --release
```

源码构建需要 Rust 工具链和 DotSlash。普通用户直接使用官方安装脚本更简单。

源码和构建说明：

- [xai-org/grok-build](https://github.com/xai-org/grok-build)

## 九、常见问题

### 提示 `grok: command not found`

先关闭并重新打开终端。如果仍然找不到命令，检查安装脚本是否成功，以及安装目录是否已经加入 `PATH`。

### 安装脚本下载失败

确认系统级 VPN/代理已经连接，并测试下面的地址是否能够打开：

```text
https://x.ai/cli/install.sh
https://x.ai/cli/install.ps1
```

### 登录页面打不开

保持系统级 VPN/代理连接，重新运行 `grok login`，按终端显示的设备码登录。

### 在项目里无法使用 Git

先检查 Git：

```bash
git --version
```

如果没有安装 Git，先从 [Git 官网](https://git-scm.com/downloads) 安装。

## 十、最短安装流程

macOS、Linux、WSL：

```bash
curl -fsSL https://x.ai/cli/install.sh | bash
grok --version
cd your-project
grok
```

Windows PowerShell：

```powershell
irm https://x.ai/cli/install.ps1 | iex
grok --version
cd your-project
grok
```

## 资料来源

- [Grok Build 官方文档](https://docs.x.ai/build/overview)
- [Introducing Grok Build](https://x.ai/news/grok-build-cli)
- [Grok Build 开源说明](https://x.ai/news/grok-build-open-source)
- [Grok Build GitHub](https://github.com/xai-org/grok-build)
- [Grok Build Changelog](https://x.ai/build/changelog)
