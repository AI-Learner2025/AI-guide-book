# 通过 CC Switch 将 DeepSeek 等模型接入 Codex

本文介绍如何使用 **CC Switch** 将 DeepSeek、Qwen、Kimi、GLM 等第三方模型接入 Codex。适合想降低调用成本、尝试不同模型能力，或在多个模型服务商之间快速切换的用户。

> 说明：用户提到的 `ccswith` 通常指的是 **CC Switch**。它是一个跨平台的 AI 编程工具配置管理器，可用于管理 Codex、Claude Code、Gemini CLI 等工具的模型提供商配置。

## 一、基本原理

Codex 默认面向 OpenAI 的接口和模型工作，而很多第三方模型服务商虽然兼容 OpenAI 风格接口，但接口协议并不完全一致。

以 DeepSeek 为例：

- DeepSeek 官方 API 主要提供 Chat Completions 风格接口。
- Codex 新版本通常要求 Responses API 风格接口。
- 如果只把 Codex 的 `base_url` 改成 `https://api.deepseek.com`，可能会遇到 `404 Not Found` 或模型检测失败。

CC Switch 的作用是：在本机启动一个配置与路由层，让 Codex 请求先进入 CC Switch，再由 CC Switch 转发到 DeepSeek 等第三方模型服务。

简化链路如下：

```text
Codex -> CC Switch 本地路由/代理 -> DeepSeek / Qwen / Kimi / GLM 等模型服务
```

## 二、准备工作

开始之前，请准备好：

- 已安装 Codex。
- 已安装 CC Switch。
- 已获取第三方模型服务商的 API Key，例如 DeepSeek API Key。
- 本机网络可以访问对应模型服务商的 API。

CC Switch 官方仓库：

```text
https://github.com/farion1231/cc-switch
```

macOS 用户通常可以使用 Homebrew 安装：

```bash
brew install --cask cc-switch
```

Windows 和 Linux 用户可以从 GitHub Releases 下载对应安装包。

## 三、在 CC Switch 中添加 DeepSeek 提供商

1. 启动 CC Switch。
2. 在应用类型中选择 `Codex`。
3. 找到 Providers 或供应商配置区域。
4. 点击添加 Provider。
5. 如果 CC Switch 当前版本内置了 DeepSeek 预设，优先选择 DeepSeek 预设。
6. 填入 DeepSeek API Key。
7. 选择模型。
8. 保存配置。

模型名称以服务商和 CC Switch 当前版本为准。常见情况包括：

- DeepSeek 官方模型：`deepseek-chat`、`deepseek-reasoner`
- 第三方中转或套餐模型：可能会出现 `deepseek-v4-pro`、`deepseek-v4-flash` 等别名
- 其他服务商：Qwen、Kimi、GLM、Doubao、MiniMax 等模型名称以各自平台为准

建议第一次配置时先选择速度快、成本低的模型做连通性测试，确认可用后再切换到更强的模型。

## 四、开启 Codex 本地路由

添加 Provider 后，还需要在 CC Switch 中开启面向 Codex 的本地路由或路由映射。

一般流程是：

1. 进入 CC Switch 设置。
2. 找到 Local Routing、路由设置或类似选项。
3. 开启路由服务。
4. 选择 Codex 作为接管对象。
5. 确认当前启用的 Provider 是 DeepSeek 或其他目标模型。
6. 重新启动 Codex，让配置生效。

如果 CC Switch 显示本地路由地址，例如：

```text
http://127.0.0.1:4000
```

说明 Codex 的请求会先打到这个本地地址，再由 CC Switch 转发给真实模型服务。

## 五、测试是否接入成功

重新打开 Codex 后，可以用一个简单请求测试：

```text
请告诉我你当前使用的模型提供商，并写一个 Python hello world。
```

如果请求能正常返回，并且 CC Switch 面板中能看到调用记录，说明接入基本成功。

也可以在 CC Switch 中切换不同 Provider，再回到 Codex 发送同样的问题，观察响应速度、质量和调用记录是否变化。

## 六、常见问题

### 1. 检测模型时报 404

这通常不是 API Key 错误，而是协议不匹配。

Codex 可能要求 Responses API，而 DeepSeek 官方 API 是 Chat Completions 风格。解决思路是不要让 Codex 直接请求 `https://api.deepseek.com`，而是使用 CC Switch 的本地路由或兼容桥接能力。

### 2. 直接修改 Codex 配置后仍然失败

不要只改 `base_url`。如果协议层不兼容，地址改对也可能失败。

优先使用 CC Switch 的 Codex 专用配置和本地路由，让工具负责写入正确的配置。

### 3. 使用 ChatGPT 登录态的 Codex 无法切换模型

如果你使用的是依赖 ChatGPT 登录态的 Codex，它可能只允许使用官方支持的模型，无法自由切换到第三方模型。

这种情况下，需要使用支持 API Key / 自定义 Provider 的 Codex 运行方式，并通过 CC Switch 管理第三方模型配置。

### 4. API Key 填了但请求失败

可以按下面顺序排查：

- API Key 是否复制完整。
- API Key 是否仍有效。
- 服务商账户是否有余额。
- CC Switch 当前启用的 Provider 是否正确。
- Local Routing 是否处于运行状态。
- Codex 是否已经重启并读取了新配置。

### 5. 切换模型后 Codex 没变化

先关闭 Codex，再在 CC Switch 中切换 Provider，最后重新打开 Codex。

如果仍无变化，可以检查 Codex 的配置文件是否被其他工具覆盖，或在 CC Switch 中重新保存一次 Codex 配置。

## 七、安全建议

- 不要把 API Key 写进公开仓库。
- 不要把 API Key 发到聊天记录或截图中。
- 如果 API Key 泄露，立即在服务商后台删除并重新生成。
- 第三方模型的代码能力、工具调用能力和稳定性可能不同，重要项目建议先在小任务中验证。

## 八、参考链接

- CC Switch GitHub：https://github.com/farion1231/cc-switch
- CC Switch Releases：https://github.com/farion1231/cc-switch/releases
- DeepSeek 平台：https://platform.deepseek.com
- Codex DeepSeek 配置参考：https://www.runoob.com/codex/codex-deepseek-setup.html
- Codex 与 DeepSeek 协议不匹配问题讨论：https://github.com/farion1231/cc-switch/issues/2553
