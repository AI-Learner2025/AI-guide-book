# Codex 必装 Skills：安装与使用指南

本文介绍 Codex Skills 的基本概念、安装方式、推荐安装组合，以及如何在日常开发中正确调用 Skills。

这篇文章和 Claude Code Skills 教程不同：Claude Code 使用的是 Claude 生态的 Skill 机制，而 Codex 使用 OpenAI Codex 的 Skills 与 Plugins 体系。两者概念相似，但目录位置、调用方式和插件生态并不完全一样。

## 一、Codex Skills 是什么

Codex Skills 是一组可复用的任务工作流。

一个 Skill 通常是一个文件夹，里面至少包含：

```text
SKILL.md
```

`SKILL.md` 会告诉 Codex：

- 这个 Skill 适合什么任务
- 什么时候应该自动触发
- 用户如何手动调用
- 执行任务时要遵循哪些步骤
- 是否需要读取参考资料、模板、脚本或素材

简单理解：

- **Skill**：写工作方法。
- **Plugin**：把一个或多个 Skills、工具、MCP、应用连接打包成可安装能力。
- **AGENTS.md**：写项目长期规则。
- **MCP / App Connector**：连接外部数据或工具。

如果只是想沉淀一个个人或项目工作流，先写 Skill。  
如果要分发给团队、绑定外部工具、打包多个能力，再做 Plugin。

## 二、Codex 如何使用 Skills

Codex 有两种使用 Skill 的方式。

### 1. 显式调用

在提示词里直接点名 Skill。

常见形式：

```text
$skill-name
```

或者在 Codex CLI / IDE 中输入 `/skills`，从列表里选择。

在 Codex app 中，也可以通过输入框里的技能和插件选择入口，直接选择要使用的 Skill。

### 2. 自动触发

如果你的任务和某个 Skill 的 `description` 匹配，Codex 可以自动加载它。

例如一个 Skill 的描述是：

```yaml
description: Review GitHub pull request comments and implement actionable fixes.
```

当你说：

```text
帮我处理这个 PR 里的 review comments。
```

Codex 就可能自动选择对应 Skill。

所以写 Skill 时，`description` 非常重要。它应该简短、明确，并且把触发场景放在前面。

## 三、Codex 必装 Skills 推荐

严格来说，没有一个所有人都必须安装的固定清单。真正值得装的，是你高频重复使用的工作流。

下面是比较推荐的组合。

### 1. Skill Creator

用途：创建自己的 Codex Skill。

推荐指数：必备。

适合场景：

- 把常用提示词沉淀成 Skill。
- 把项目发布流程沉淀成 Skill。
- 把代码审查规则沉淀成 Skill。
- 把团队规范沉淀成 Skill。

调用方式：

```text
$skill-creator
```

建议第一次写 Skill 时不要手写，从 `$skill-creator` 开始。它会询问 Skill 的用途、触发条件、是否需要脚本，然后帮你生成基础结构。

### 2. Skill Installer

用途：安装 curated skills 或从其他仓库下载 Skills。

推荐指数：必备。

调用方式：

```text
$skill-installer
```

例如安装某个 curated skill：

```text
$skill-installer linear
```

适合场景：

- 想快速安装别人已经整理好的 Skill。
- 想从 GitHub 仓库安装 Skill。
- 想先试用，再决定是否改成自己的版本。

### 3. OpenAI Docs

用途：查询 OpenAI / Codex / API 官方文档。

推荐指数：高。

适合场景：

- 写 OpenAI API 代码。
- 查 Codex 配置、插件、MCP、Hooks、Skills 用法。
- 选择模型。
- 迁移模型或升级提示词。
- 确认某个 OpenAI 产品能力是否已经支持。

这类 Skill 的价值在于：它会优先查官方文档，而不是只靠模型记忆回答。

### 4. GitHub

用途：处理 GitHub 仓库、Issue、PR、review comments 和 CI。

推荐指数：高。

适合场景：

- 总结 PR。
- 处理 review comments。
- 修 GitHub Actions 失败。
- 根据 Issue 实现功能。
- 提交、推送、创建 PR。

如果你经常让 Codex 参与 GitHub 项目开发，GitHub 插件和相关 Skills 很值得安装。

### 5. Browser / Chrome

用途：让 Codex 打开浏览器测试网页、检查 UI、操作本地服务或登录态网页。

推荐指数：前端开发必备。

适合场景：

- 打开 `localhost` 检查页面。
- 用截图验证布局。
- 点击按钮测试交互。
- 检查前端是否出现空白页。
- 使用用户 Chrome 登录态处理网页任务。

建议：

- 本地网页测试优先用 Browser。
- 需要用户已有登录态时用 Chrome。
- 重要表单、权限变更、发消息、付款等操作仍然需要人工确认。

### 6. Documents / Spreadsheets / Presentations

用途：处理 Word、Excel、PPT、CSV、PDF 等办公文件。

推荐指数：办公和报告场景必备。

适合场景：

- 生成 `.docx` 文档。
- 分析 `.xlsx` 或 `.csv` 数据。
- 生成 PPTX。
- 修改表格公式和格式。
- 输出可交付报告。

这类 Skill 通常会配合专门的渲染和校验流程，不只是生成文本。

### 7. Imagegen

用途：生成或编辑位图图片。

推荐指数：内容创作、教程、封面图场景推荐。

适合场景：

- 生成教程配图。
- 做文章封面。
- 生成 UI mockup。
- 做图标、插画、纹理或游戏素材。

如果你的项目后面要补截图或示意图，可以把真实截图和 AI 生成图分开使用：真实截图用于操作步骤，AI 图用于封面和概念解释。

### 8. Game Studio / Three.js / Phaser

用途：开发浏览器游戏、3D 场景和交互原型。

推荐指数：游戏和互动项目必备。

适合场景：

- Phaser 2D 游戏。
- Three.js / React Three Fiber 3D 项目。
- 游戏 UI、HUD、菜单、动效。
- 玩法测试和截图验证。
- 精灵图、GLB、贴图等资产处理。

如果不是游戏项目，可以先不装，避免技能列表过长。

### 9. Gmail / Google Drive / Slack 等连接器类 Skills

用途：连接外部工作空间数据。

推荐指数：按需安装。

适合场景：

- 总结 Gmail 邮件。
- 查找 Google Drive 文档。
- 总结 Slack 频道。
- 草拟回复。
- 跨工具整理任务。

这类能力需要授权外部账号。安装前要确认数据权限和使用范围。

## 四、安装方式一：通过 Codex 插件目录安装

Codex 的插件是安装分发单位。很多 Skills 会通过插件提供。

在 Codex app 中：

1. 打开 Plugins。
2. 浏览 OpenAI curated、Shared with you 或 Created by you。
3. 点击插件详情。
4. 查看它包含哪些 Skills、Apps、MCP servers。
5. 点击 Add to Codex。
6. 如果需要外部账号授权，按提示连接。
7. 新开一个线程，开始使用插件或 Skill。

在 Codex CLI 中：

```text
codex
/plugins
```

进入插件目录后，可以搜索、安装、卸载或启用/禁用插件。

安装后使用：

```text
@github 帮我总结这个 PR 的 review comments
```

或者：

```text
$skill-name 执行这个工作流
```

## 五、安装方式二：用 Skill Installer 安装

如果只是给本地 Codex 添加一个 Skill，可以使用：

```text
$skill-installer
```

例如：

```text
$skill-installer linear
```

也可以让它从其他仓库下载 Skills。

这种方式适合：

- 个人本地使用。
- 先试用别人的 Skill。
- 快速扩展某个单一工作流。

如果你要给团队长期分发，建议后续改成 Plugin。

## 六、安装方式三：创建个人 Skill

个人 Skill 适合跨项目复用。

官方推荐位置：

```text
~/.agents/skills/<skill-name>/SKILL.md
```

示例：

```text
~/.agents/skills/summarize-changes/SKILL.md
```

内容示例：

```markdown
---
name: summarize-changes
description: Summarize current git changes and identify risks before commit.
---

When this skill is used:

1. Run `git status --short`.
2. Review `git diff`.
3. Summarize user-facing changes.
4. List risks, missing tests, or suspicious edits.
5. Suggest a concise commit message.

Do not commit unless the user asks for it.
```

使用方式：

```text
$summarize-changes
```

## 七、安装方式四：创建项目 Skill

项目 Skill 适合和仓库一起提交，让团队共享。

官方推荐位置：

```text
.agents/skills/<skill-name>/SKILL.md
```

例如：

```text
.agents/skills/project-release/SKILL.md
```

示例：

```markdown
---
name: project-release
description: Run this repository's release checklist before publishing a version.
---

Follow this release checklist:

1. Read README.md and CHANGELOG.md.
2. Check the version number.
3. Run tests.
4. Run build.
5. Summarize release notes.
6. Ask the user before publishing or creating external releases.
```

这种 Skill 的好处是：

- 新成员进入仓库后也能使用。
- 项目规则不用反复复制到提示词里。
- 发布、测试、代码审查等流程更一致。

## 八、Skill 的目录结构

一个稍完整的 Codex Skill 可以这样组织：

```text
my-skill/
├── SKILL.md
├── references/
│   └── style-guide.md
├── scripts/
│   └── check.sh
└── assets/
    └── template.md
```

建议：

- `SKILL.md` 保持简洁，写触发条件和核心步骤。
- 长规范放进 `references/`。
- 确定性检查放进 `scripts/`。
- 模板、图片、示例放进 `assets/`。

Codex 会先看到 Skill 名称、描述和路径。只有真正需要使用时，才读取完整 `SKILL.md` 和相关文件。

## 九、如何禁用某个 Skill

如果某个 Skill 暂时不想使用，可以在 `~/.codex/config.toml` 中禁用。

示例：

```toml
[[skills.config]]
path = "/path/to/skill/SKILL.md"
enabled = false
```

修改后重启 Codex。

如果是插件，可以在插件目录里禁用，或在配置里关闭插件：

```toml
[plugins."gmail@openai-curated"]
enabled = false
```

## 十、如何判断一个 Skill 值不值得装

可以用下面几个问题判断：

- 这个任务我是否每周都会重复做？
- 这个任务是否有固定步骤？
- 这个任务是否需要固定检查清单？
- 这个任务是否容易因为遗漏步骤出错？
- 这个任务是否需要参考模板、规范或脚本？
- 这个任务是否适合团队共享？

如果大多数答案是「是」，就值得做成 Skill。

如果只是一次性要求，直接写在提示词里就够了。

## 十一、推荐入门组合

初学者可以按这个顺序配置：

1. 先熟悉系统自带的 `$skill-creator` 和 `$skill-installer`。
2. 安装 GitHub 插件，用于 Issue、PR、CI 和发布流程。
3. 前端项目安装 Browser 或 Chrome 相关能力，用于页面验证。
4. 文档项目安装 Documents、Spreadsheets、Presentations。
5. OpenAI API 项目使用 OpenAI Docs Skill。
6. 为常用仓库写一个 `.agents/skills/project-rules/`。
7. 为提交前检查写一个个人 `~/.agents/skills/summarize-changes/`。

这样既能覆盖高频场景，又不会让技能列表过度膨胀。

## 十二、截图建议

后续制作图文版时，建议补充这些截图：

- `images/codex-skills/plugin-directory.png`：Codex app 的 Plugins 页面
- `images/codex-skills/plugin-details.png`：插件详情页，展示 Skills / Apps / MCP
- `images/codex-skills/skill-selector.png`：输入框中选择 Skill 或 Plugin
- `images/codex-skills/cli-plugins.png`：CLI 中输入 `/plugins`
- `images/codex-skills/cli-skills.png`：CLI 中输入 `/skills`
- `images/codex-skills/local-skill-folder.png`：`.agents/skills/` 文件结构
- `images/codex-skills/config-disable-skill.png`：`~/.codex/config.toml` 禁用 Skill 示例

截图时注意遮挡账号、私有仓库名、API Key、邮件地址和公司内部信息。

## 十三、安全建议

安装 Skill 或 Plugin 前，建议像审查代码一样审查它：

- 看清楚它会读取哪些文件。
- 看清楚它会运行哪些脚本。
- 看清楚它是否连接外部服务。
- 看清楚它是否会提交代码、创建 PR、发送消息或修改权限。
- 不要安装来源不明、权限过大的插件。
- 发布、部署、付款、账号权限变更等动作，要保留人工确认。

Skills 能提高效率，但不要把敏感操作完全交给自动化。

## 参考资料

- Codex Agent Skills 官方文档：https://developers.openai.com/codex/skills
- Codex Plugins 官方文档：https://developers.openai.com/codex/plugins
- Codex Customization 官方文档：https://developers.openai.com/codex/concepts/customization
- OpenAI Skills 示例仓库：https://github.com/openai/skills
- Agent Skills 标准：https://agentskills.io/specification
