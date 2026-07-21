# Codex 安装教程：先连接梯子，再下载官方客户端

> 更新日期：2026-07-21

Codex 可以在 ChatGPT 桌面应用、终端和 IDE 中使用。当前桌面端已经整合进新的 ChatGPT 桌面应用，所以下载时不要到第三方网站寻找所谓“Codex 安装包”。

## 一、安装前先做这件事

### 先连接稳定的梯子

开始下载前，先连接稳定、合法合规的 VPN/代理，也就是大家常说的“梯子”。然后再打开官方页面：

```text
https://chatgpt.com/download/
```

建议先确认这几个页面能够正常打开：

- ChatGPT 下载页
- ChatGPT 登录页
- GitHub（如果要安装 CLI）

只代理浏览器有时不够，桌面应用的下载、登录和更新可能仍然走系统网络。遇到下载失败或登录页打不开时，优先检查系统级 VPN/代理是否生效，不要急着换第三方安装包。

## 二、普通用户：安装桌面版 Codex

### 1. 下载官方应用

连接梯子后打开：

- [ChatGPT 官方下载页](https://chatgpt.com/download/)
- [Codex 官方介绍](https://openai.com/codex/)

根据电脑系统选择 macOS 或 Windows 版本。现在的 ChatGPT 桌面应用内置 ChatGPT、Work 和 Codex，安装后从应用左上角切换到 Codex 即可。

### 2. 安装

#### macOS

1. 下载 `.dmg` 文件。
2. 双击打开，将 ChatGPT 拖入“应用程序”。
3. 启动 ChatGPT，按提示登录。
4. 在左上角选择 `Codex`。

官方 macOS 要求为 macOS 14，支持 Apple Silicon（M1 或更新芯片）和 Intel 处理器。详见[官方系统要求](https://help.openai.com/en/articles/9395554-what-are-the-system-requirements-for-the-chatgpt-macos-app)。

#### Windows

1. 下载 Windows 安装程序。
2. 双击安装，按系统提示完成安装。
3. 启动 ChatGPT 并登录同一个 ChatGPT 账号。
4. 在应用内打开 `Codex`。

如果电脑里已经安装旧版 Codex App，直接更新即可。官方说明旧 Codex App 更新后会迁移到新的 ChatGPT 桌面应用，已有 Codex 对话和项目应当保留。

### 3. 第一次使用

1. 在 Codex 中添加一个本地项目文件夹或 Git 仓库。
2. 选择项目后，让 Codex 先阅读项目结构。
3. 先用一个低风险任务测试，例如：

```text
请先阅读这个项目，不要修改文件，告诉我项目结构、启动命令和主要风险。
```

4. 确认 Codex 能正常读取项目后，再开始修改代码。

## 三、开发者：安装 Codex CLI

如果你习惯在终端里工作，可以安装官方开源 CLI。

先确认梯子已连接，然后打开终端执行：

```bash
npm install -g @openai/codex
codex
```

首次运行时按提示使用 ChatGPT 账号登录。也可以直接从官方仓库查看最新安装说明：

- [OpenAI Codex GitHub](https://github.com/openai/codex)
- [Codex CLI Getting Started](https://help.openai.com/en/articles/11096431)

检查是否安装成功：

```bash
codex --version
```

升级 CLI：

```bash
codex --upgrade
```

进入项目目录后运行：

```bash
cd your-project
codex
```

## 四、想在编辑器里使用

Codex 也可以通过 IDE 扩展接入编辑器。官方文档提供了 [Codex IDE extension](https://learn.chatgpt.com/docs/codex/ide) 入口。安装扩展后，用同一个 ChatGPT 账号登录，再打开项目即可。

## 五、网络问题排查

| 现象 | 优先检查 |
| --- | --- |
| 官网打不开 | 梯子是否已连接，节点是否稳定 |
| 下载速度很慢 | 换节点，优先测试日本、新加坡、香港或美国线路 |
| App 能打开但无法登录 | 改用系统级 VPN/代理，检查系统时间 |
| CLI 安装超时 | 确认终端也能访问 npm 和 GitHub |
| npm 找不到包 | 执行 `npm cache verify`，再重试官方命令 |
| 版本太旧 | 桌面端检查更新，CLI 执行 `codex --upgrade` |

不要使用来路不明的 DMG、EXE、ZIP 或修改版 CLI。Codex 会接触本地项目和终端，第三方安装包可能带来账号、代码和密钥风险。

## 六、桌面端和 CLI 怎么选

| 需求 | 推荐 |
| --- | --- |
| 第一次使用 Codex | ChatGPT 桌面应用里的 Codex |
| 多个项目、多 Agent 并行工作 | 桌面应用 |
| 习惯终端和脚本自动化 | Codex CLI |
| 在编辑器内边写边改 | Codex IDE extension |
| 手机查看桌面任务 | 使用 ChatGPT 移动端 Remote；不能把 Codex 当作普通手机 App 直接安装 |

最短路径：

```text
连接梯子
→ 打开 https://chatgpt.com/download/
→ 安装 ChatGPT 桌面应用
→ 登录
→ 选择 Codex
→ 添加项目并开始工作
```

## 官方资料

- [ChatGPT 官方下载页](https://chatgpt.com/download/)
- [Get started with Codex](https://openai.com/codex/get-started/)
- [Codex 官方介绍](https://openai.com/codex/)
- [Codex App 与 Windows 支持说明](https://openai.com/index/introducing-the-codex-app/)
- [OpenAI Codex GitHub](https://github.com/openai/codex)
- [Codex CLI Getting Started](https://help.openai.com/en/articles/11096431)
