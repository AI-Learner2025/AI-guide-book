# Codex 安装教程：先连接梯子，再下载

> 更新日期：2026-07-21

Codex 已经集成到新版 ChatGPT 桌面应用中，支持 macOS 和 Windows。请从官方页面下载，不要安装第三方修改版。

## 一、安装桌面版

### 1. 先连接梯子

下载和登录前，先连接稳定、合法合规的系统级 VPN/代理。仅使用浏览器代理，可能导致应用无法登录或更新。

### 2. 下载

打开官方下载页：

- [下载 ChatGPT 桌面应用](https://chatgpt.com/download/)

根据电脑系统选择 macOS 或 Windows 版本。

### 3. 安装

**macOS：**打开下载的 `.dmg` 文件，将 ChatGPT 拖入“应用程序”。

**Windows：**双击下载的安装程序，按提示完成安装。

### 4. 登录 Codex

打开 ChatGPT，登录账号，然后从应用左上角进入 `Codex`。

### 5. 添加项目

选择一个本地文件夹或 Git 仓库，输入：

```text
请先阅读这个项目，不要修改文件，告诉我项目结构和启动方法。
```

确认 Codex 能正常读取项目后，就可以让它开发功能、修改代码或运行测试。

## 二、安装 Codex CLI

习惯使用终端的用户，可以安装官方 CLI：

```bash
npm install -g @openai/codex
codex --version
codex
```

首次运行 `codex` 时，按照提示登录 ChatGPT 账号。进入项目目录后再次运行 `codex` 即可开始工作。

官方仓库：[github.com/openai/codex](https://github.com/openai/codex)

## 三、遇到问题

- 官网或登录页打不开：检查梯子是否连接，尝试切换稳定节点。
- 应用能打开但无法登录：使用系统级 VPN/代理后重启应用。
- CLI 安装超时：确认终端能够访问 npm 和 GitHub，然后重新执行安装命令。

最短安装流程：

```text
连接梯子 → 打开官方下载页 → 安装 → 登录 → 进入 Codex → 添加项目
```

## 官方资料

- [Codex 官方介绍](https://openai.com/codex/)
- [Codex 快速开始](https://openai.com/codex/get-started/)
- [ChatGPT 官方下载页](https://chatgpt.com/download/)
