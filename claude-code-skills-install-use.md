# Claude Code 必装 Skills：安装与使用指南

本文介绍 Claude Code 中的 Skills 是什么、应该优先安装哪些类型，以及如何通过插件市场、官方 Skill 仓库和手动文件夹方式安装与使用。

这篇文章和前面的 Codex 模型接入教程不同：这里不讲第三方模型，也不讲账号地区，而是专注于 Claude Code 的工作流增强。

## 一、Skills 是什么

Skills 可以理解成 Claude Code 的「可复用工作方法包」。

一个 Skill 通常是一个文件夹，里面至少包含一个 `SKILL.md` 文件。这个文件会告诉 Claude：

- 这个 Skill 适合什么任务
- 什么时候应该自动使用
- 用户如何手动调用
- 执行任务时应该遵循哪些步骤
- 是否需要读取模板、示例、脚本或参考资料

相比把所有规则都写进 `CLAUDE.md`，Skills 的好处是：

- 只有相关任务触发时才加载完整内容，减少上下文浪费。
- 可以按任务拆分，例如代码审查、调试、发布、文档生成。
- 可以在个人、项目、插件三个层级复用。
- 可以被用户手动调用，也可以由 Claude 自动判断是否使用。

## 二、先认识 Claude Code 自带 Skills

Claude Code 已经内置了一些常用 Skills，通常不需要额外安装。

常见内置 Skills 包括：

- `/code-review`：做代码审查，适合提交前检查风险。
- `/debug`：定位 bug，适合报错、失败测试、异常行为。
- `/batch`：批量处理多个相似任务。
- `/loop`：让 Claude 按循环方式持续执行、检查和修正。
- `/claude-api`：处理 Claude API 相关开发任务。
- `/run`：尝试启动并操作应用，确认改动是否真的可运行。
- `/verify`：构建并运行应用，验证改动是否符合预期。
- `/run-skill-generator`：为当前项目生成专用运行/验证 Skill。

如果你刚开始用 Claude Code，建议先熟悉这些自带 Skills，再考虑安装外部 Skills。

## 三、哪些 Skills 值得优先安装

所谓「必装」不是指一次性装很多，而是优先补齐高频工作流。

### 1. 代码智能类

如果你长期写代码，建议优先安装对应语言的 LSP / code intelligence 插件。

这类插件能让 Claude Code 更好地理解项目结构，例如跳转定义、查找引用、看到类型错误。

常见选择：

- TypeScript / JavaScript：`typescript-lsp`
- Python：`pyright-lsp`
- Go：`gopls-lsp`
- Rust：`rust-analyzer-lsp`
- Java：`jdtls-lsp`
- C / C++：`clangd-lsp`

注意：这类插件通常还要求本机安装对应语言服务器。例如 Python 需要 `pyright-langserver`，Go 需要 `gopls`。

### 2. Git 和提交工作流类

适合经常让 Claude 帮你：

- 总结 diff
- 生成 commit message
- 拆分提交
- 检查提交前风险
- 整理 PR 描述

这类 Skill 建议设置成用户手动调用，避免 Claude 在不合适的时候自动提交或发布。

### 3. 文档处理类

如果你经常处理 Word、PDF、PPT、Excel，可以安装 Anthropic 的 document skills。

适合场景：

- 从 PDF 提取结构化信息
- 生成或修改 Word 文档
- 生成演示文稿
- 分析表格
- 按模板整理报告

### 4. 项目运行与验证类

每个复杂项目都建议运行一次 `/run-skill-generator`。

它会让 Claude Code 学会这个项目怎么安装依赖、怎么启动、怎么验证。生成后，后续 `/run` 和 `/verify` 会更稳定，不需要每次重新猜命令。

### 5. 团队规范类

如果一个项目有固定规则，可以把规则做成项目级 Skill：

- API 设计规范
- 前端组件规范
- 测试规范
- 发布流程
- 错误处理规范
- 日志与监控规范

这类 Skill 适合放在项目目录的 `.claude/skills/` 下，和代码一起提交，让团队成员共享。

## 四、安装方式一：通过官方插件市场安装

Claude Code 的插件可以包含 Skills、agents、hooks、MCP servers、LSP servers 等能力。

进入 Claude Code 后，输入：

```text
/plugin
```

然后在界面中：

1. 进入 Discover 或 Browse 页面。
2. 选择官方 marketplace。
3. 搜索需要的插件。
4. 查看插件会安装哪些 Skills、commands、agents 或 MCP。
5. 选择安装范围。
6. 安装后按提示执行 `/reload-plugins` 或重启 Claude Code。

也可以直接用命令安装：

```text
/plugin install github@claude-plugins-official
```

如果提示找不到官方 marketplace，可以先更新：

```text
/plugin marketplace update claude-plugins-official
```

如果还没有添加官方 marketplace，可以添加：

```text
/plugin marketplace add anthropics/claude-plugins-official
```

## 五、安装方式二：安装 Anthropic 官方 Agent Skills 示例

Anthropic 维护了一个公开的 Skills 仓库：

```text
https://github.com/anthropics/skills
```

可以先把它作为 Claude Code marketplace 添加：

```text
/plugin marketplace add anthropics/skills
```

然后安装官方示例技能包：

```text
/plugin install document-skills@anthropic-agent-skills
```

或者：

```text
/plugin install example-skills@anthropic-agent-skills
```

安装完成后，可以直接在对话里说明要使用哪个 Skill，例如：

```text
Use the PDF skill to extract the form fields from ./contract.pdf
```

也可以输入 `/` 查看当前可用命令和 Skills。

## 六、安装方式三：手动安装个人 Skill

个人 Skill 适合自己跨项目复用。

目录位置：

```text
~/.claude/skills/<skill-name>/SKILL.md
```

例如创建一个总结当前 Git 改动的 Skill：

```bash
mkdir -p ~/.claude/skills/summarize-changes
```

然后创建文件：

```text
~/.claude/skills/summarize-changes/SKILL.md
```

内容示例：

```markdown
---
description: Summarize uncommitted git changes and flag risky edits. Use when the user asks what changed, wants a commit message, or asks for a quick review.
---

## Current changes

!`git diff HEAD`

## Instructions

Summarize the changes in two or three bullet points.
Then list any risks, missing tests, hardcoded values, or suspicious edits.
If there are no uncommitted changes, say so clearly.
```

使用方式：

```text
/summarize-changes
```

也可以直接问：

```text
What did I change?
```

Claude 会根据 `description` 判断是否自动使用这个 Skill。

## 七、安装方式四：手动安装项目 Skill

项目 Skill 适合只在当前仓库生效，并且可以和团队共享。

目录位置：

```text
.claude/skills/<skill-name>/SKILL.md
```

例如项目发布流程：

```text
.claude/skills/release-checklist/SKILL.md
```

示例：

```markdown
---
description: Run this project's release checklist before publishing a new version.
disable-model-invocation: true
---

Release checklist:

1. Read CHANGELOG.md.
2. Run tests.
3. Build the package.
4. Confirm version number.
5. Summarize release risks.

Do not publish automatically. Ask the user before any external release action.
```

这里加了：

```yaml
disable-model-invocation: true
```

意思是只允许用户手动调用，不让 Claude 自动触发。发布、部署、提交、发消息这类有外部影响的流程，建议都这样设置。

使用：

```text
/release-checklist
```

## 八、Skill 的基本结构

一个典型 Skill 目录如下：

```text
my-skill/
├── SKILL.md
├── reference.md
├── examples.md
└── scripts/
    └── helper.py
```

其中：

- `SKILL.md` 是必需入口。
- `reference.md` 放详细规范或 API 文档。
- `examples.md` 放输入输出示例。
- `scripts/` 放可以执行的辅助脚本。

建议让 `SKILL.md` 保持简洁，把长文档拆到独立文件里。Claude 只有需要时才读取额外文件，这样更省上下文。

## 九、常用 frontmatter 配置

`SKILL.md` 顶部可以写 YAML frontmatter：

```yaml
---
name: release-checklist
description: Run this project's release checklist before publishing.
disable-model-invocation: true
argument-hint: "[version]"
allowed-tools: Read Grep Bash
---
```

常见字段：

| 字段 | 作用 |
| --- | --- |
| `name` | 展示名称。通常命令名仍由文件夹名决定。 |
| `description` | 描述 Skill 的用途，Claude 会靠它判断是否自动使用。 |
| `when_to_use` | 补充触发场景。 |
| `disable-model-invocation` | 禁止 Claude 自动调用，只允许用户手动调用。 |
| `user-invocable` | 是否允许用户手动调用。 |
| `argument-hint` | 在命令补全时提示参数格式。 |
| `arguments` | 定义位置参数名称。 |
| `allowed-tools` | 限制 Skill 可预先使用的工具。 |
| `paths` | 限制只在匹配特定文件路径时触发。 |

## 十、如何使用已安装的 Skill

使用 Skill 有两种方式。

### 方式一：手动调用

输入 `/`，找到对应 Skill：

```text
/skill-name
```

带参数调用：

```text
/release-checklist 1.2.0
```

### 方式二：自然语言触发

如果 Skill 的 `description` 写得足够清楚，Claude 会自动判断是否加载。

例如你有一个总结 diff 的 Skill，可以直接问：

```text
帮我总结一下当前改动，并指出风险。
```

Claude 可能自动加载相关 Skill。

## 十一、安装后如何确认生效

可以按下面顺序检查：

1. 在 Claude Code 中输入 `/`，看列表里是否出现对应 Skill。
2. 如果是插件安装，运行：

```text
/plugin list
```

3. 如果刚安装插件但没有出现，运行：

```text
/reload-plugins
```

4. 如果是手动新增 `~/.claude/skills/`，通常会自动检测；如果目录是本次会话启动后才创建的，重启 Claude Code 更稳。
5. 直接输入 `/skill-name` 测试。

## 十二、截图建议

后续制作图文版时，建议补充这些截图：

- `images/claude-code-skills/plugin-menu.png`：Claude Code 中输入 `/plugin` 后的界面
- `images/claude-code-skills/discover-marketplace.png`：插件市场 Discover 页面
- `images/claude-code-skills/plugin-details.png`：插件详情页，展示将安装的 Skills / Agents / MCP
- `images/claude-code-skills/install-scope.png`：选择 User / Project / Local 安装范围
- `images/claude-code-skills/skill-autocomplete.png`：输入 `/` 后看到 Skill 自动补全
- `images/claude-code-skills/manual-skill-folder.png`：本地 `~/.claude/skills/` 或 `.claude/skills/` 文件结构

截图时注意不要暴露项目路径、私有仓库名、API Key、公司内部规范或敏感文件名。

## 十三、安全建议

Skills 和插件可能包含脚本、工具权限和外部服务配置。安装前要像审查代码一样审查 Skill。

建议：

- 优先安装官方 marketplace 或可信来源的插件。
- 安装前查看插件详情，确认它会添加哪些 Skills、agents、hooks、MCP 或 LSP。
- 不要安装来路不明、要求过多权限的 Skill。
- 对会执行命令的 Skill，先读 `SKILL.md` 和 `scripts/` 目录。
- 对提交、部署、发消息、改权限等高影响动作，使用 `disable-model-invocation: true`。
- 团队项目的 `.claude/skills/` 应该进入代码审查流程。

## 十四、推荐入门组合

如果你不知道先装什么，可以按这个顺序来：

1. 先熟悉内置 `/code-review`、`/debug`、`/run`、`/verify`。
2. 给主力语言安装对应 LSP 插件，例如 TypeScript、Python、Go 或 Rust。
3. 对复杂项目运行一次 `/run-skill-generator`。
4. 安装 `document-skills`，用于 PDF、Word、PPT、Excel 等文档任务。
5. 写一个个人 `summarize-changes` Skill，用来总结 diff。
6. 给当前项目写一个 `.claude/skills/project-rules/`，沉淀项目规范。

这样既不会装太多，也能明显提升 Claude Code 的可控性和稳定性。

## 参考资料

- Claude Code Skills 官方文档：https://code.claude.com/docs/en/skills
- Claude Code 插件市场文档：https://code.claude.com/docs/en/discover-plugins
- Anthropic 官方 Skills 仓库：https://github.com/anthropics/skills
- Anthropic Agent Skills 设计文章：https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills
