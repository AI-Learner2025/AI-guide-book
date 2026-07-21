# Codex 安装教程：官方与社区下载入口

> 更新日期：2026-07-21

Codex 可以通过桌面应用、命令行和 IDE 使用。新手推荐安装官方桌面应用，开发者可以再安装 Codex CLI。

## 一、下载前先连接梯子

先连接稳定、合法合规的系统级 VPN/代理，否则可能出现官网打不开、安装包下载失败或登录超时。

https://hyperaicc.com/

连接后再打开 Codex 和 ChatGPT 的官方下载页面。

## 二、官方桌面应用

### macOS 和 Windows

官方下载：

- [ChatGPT 桌面应用下载页](https://chatgpt.com/download/)
- [Codex 官方介绍](https://openai.com/codex/)

下载页会根据系统提供 macOS 或 Windows 安装包。Codex 已集成到新版 ChatGPT 桌面应用中。

安装步骤：

1. 打开下载页，选择对应系统。
2. macOS 打开 `.dmg`，将 ChatGPT 拖入“应用程序”。
3. Windows 双击安装程序，按提示完成安装。
4. 登录 ChatGPT 账号。
5. 从应用左上角进入 `Codex`。
6. 添加一个本地文件夹或 Git 仓库。

第一次使用可以输入：

```text
请先阅读这个项目，不要修改文件，告诉我项目结构、启动方法和主要功能。
```

## 三、Codex CLI 官方安装方式

### 方式 1：一键安装脚本

macOS 或 Linux：

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

Windows PowerShell：

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://chatgpt.com/codex/install.ps1 | iex"
```

安装完成后执行：

```bash
codex --version
codex
```

### 方式 2：npm

适合已经安装 Node.js 和 npm 的用户：

```bash
npm install -g @openai/codex
```

官方 npm 页面：

- [npm：@openai/codex](https://www.npmjs.com/package/@openai/codex)

注意包名必须是 `@openai/codex`，不要安装名称相似的第三方包。

### 方式 3：Homebrew

适合 macOS 或已经安装 Homebrew/Linuxbrew 的用户：

```bash
brew install --cask codex
```

包页面：

- [Homebrew Codex](https://formulae.brew.sh/cask/codex)

### 方式 4：GitHub Releases 二进制包

不想安装 Node.js，可以直接下载官方编译包：

- [Codex GitHub 最新版本](https://github.com/openai/codex/releases/latest)
- [Codex 官方仓库](https://github.com/openai/codex)

常用文件名：

| 系统 | 下载文件 |
| --- | --- |
| macOS Apple Silicon | `codex-aarch64-apple-darwin.tar.gz` |
| macOS Intel | `codex-x86_64-apple-darwin.tar.gz` |
| Windows x64 | `codex-x86_64-pc-windows-msvc.exe.zip` |
| Windows ARM64 | `codex-aarch64-pc-windows-msvc.exe.zip` |
| Linux x64 | `codex-x86_64-unknown-linux-musl.tar.gz` |
| Linux ARM64 | `codex-aarch64-unknown-linux-musl.tar.gz` |

下载并解压后，将程序放到系统 `PATH` 目录，终端执行 `codex --version` 验证安装。

## 四、社区安装渠道

下面的包由社区或操作系统软件仓库维护，适合熟悉包管理器的用户。安装前请核对它们最终下载的文件是否来自 `github.com/openai/codex`。

### Windows WinGet

```powershell
winget install -e --id OpenAI.Codex
```

- [WinGet Codex 包页面](https://winstall.app/apps/OpenAI.Codex)

### Windows Chocolatey

```powershell
choco install codex
```

- [Chocolatey Codex 包页面](https://community.chocolatey.org/packages/codex)

### Arch Linux

Arch Linux 官方软件仓库提供 `openai-codex`：

```bash
sudo pacman -S openai-codex
```

- [Arch Linux openai-codex](https://archlinux.org/packages/extra/x86_64/openai-codex/)
- [AUR openai-codex-bin](https://aur.archlinux.org/packages/openai-codex-bin)

### 非官方 Linux 桌面版

OpenAI 没有在 Linux 上提供与 macOS/Windows 相同的官方桌面安装包。需要桌面界面的用户可以研究下面的社区项目：

- [ilysenko/codex-desktop-linux](https://github.com/ilysenko/codex-desktop-linux)

该项目不是 OpenAI 官方产品，主要通过源码构建 `.deb`、`.rpm`、Arch 包或 AppImage。它目前没有可直接下载的 GitHub Release，新手建议使用官方 Codex CLI。

## 五、手机端入口

手机上安装的是官方 ChatGPT App，可以查看和继续部分 Codex 远程任务，但不能代替电脑上的本地开发环境。

- [iPhone / iPad：ChatGPT App Store](https://apps.apple.com/app/openai-chatgpt/id6448311069)
- [Android：ChatGPT Google Play](https://play.google.com/store/apps/details?id=com.openai.chatgpt)

## 六、安装后开始使用

进入项目目录：

```bash
cd your-project
codex
```

首次运行选择使用 ChatGPT 账号登录。然后输入：

```text
请阅读当前项目，告诉我如何启动，不要修改文件。
```

如果能够正常读取项目，说明安装和登录已经完成。

## 七、下载失败怎么办

- 官网打不开：检查梯子是否已连接，切换稳定节点。
- 桌面应用无法登录：使用系统级 VPN/代理并重启应用。
- npm 安装超时：确认终端也能访问 npm 和 GitHub。
- 社区包版本较旧：改用官方脚本、npm 或 GitHub Releases。
- 系统提示文件不安全：检查下载域名和数字签名，不要强行运行来源不明的包。

优先级建议：

```text
官方桌面下载页
→ 官方一键安装脚本
→ npm / Homebrew
→ GitHub Releases
→ 社区包管理器
→ 非官方桌面项目
```

## 官方资料

- [ChatGPT 官方下载页](https://chatgpt.com/download/)
- [Codex 官方介绍](https://openai.com/codex/)
- [Codex 快速开始](https://openai.com/codex/get-started/)
- [Codex CLI 官方文档](https://learn.chatgpt.com/docs/codex/cli)
- [OpenAI Codex GitHub](https://github.com/openai/codex)
