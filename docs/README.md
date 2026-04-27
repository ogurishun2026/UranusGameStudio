# AI Workflow Template

基于 CCGS (Claude Code Game Studios) 的 AI 辅助开发工作流模板。

## 快速开始

### 基础安装（不含扩展）

```bash
# Linux/macOS
./install.sh /path/to/your/project

# Windows
install.bat C:\path\to\your\project
```

### 完整安装（含 MemPalace 记忆层）

```bash
# Linux/macOS
./install.sh /path/to/your/project --with-mempalace

# Windows
install.bat C:\path\to\your\project --with-mempalace
```

## 包含内容

### 核心模板 (.claude/)

| 目录 | 数量 | 说明 |
|------|------|------|
| skills/ | 72 | 工作流技能（code-review, brainstorm, bug-triage 等） |
| agents/ | 49 | 角色定义（tech-lead, qa-lead, devops 等） |
| hooks/ | 12 | 自动化钩子（validate-commit, session-start 等） |
| rules/ | 11 | 规则配置 |

### 扩展模块 (mempalace-extension/)

| 文件 | 说明 |
|------|------|
| .mcp.json | MCP Server 配置 |
| settings.local.json | MemPalace 权限配置 |
| mempalace-config.yaml | 翼室结构配置 |

## 目录结构

```
your-project/
├── .claude/
│   ├── skills/          # 技能库
│   ├── agents/          # 角色定义
│   ├── hooks/           # 自动化钩子
│   ├── rules/           # 规则配置
│   ├── settings.json    # 核心配置
│   └── settings.local.json  # 扩展配置（可选）
├── .mcp.json            # MCP 配置（可选）
├── CLAUDE.md            # 项目说明
└── ...
```

## 游戏专用模块替换指南

模板包含游戏开发专用的 skills/agents，非游戏项目可替换：

### 可删除的游戏专用 Skills
- `team-*` 系列（team-combat, team-level, team-narrative 等）
- `art-*` 系列（art-bible, asset-audit 等）
- 引擎相关（setup-engine, prototype 等）

### 可删除的游戏专用 Agents
- `*-specialist.md` 系列（unity-*, ue-*, godot-*）
- 游戏设计角色（game-designer, level-designer, narrative-director 等）

### 通用 Skills 保留
- code-review, brainstorm, bug-triage
- security-audit, tech-debt, sprint-plan
- design-review, milestone-review, retrospective

## 自定义扩展

创建你自己的扩展包：

```
my-extension/
├── .mcp.json            # MCP Server 配置
├── settings.local.json  # 覆盖 settings.json
└── custom-skills/       # 自定义技能
```

在 install.sh 中添加复制逻辑即可。

## 版本信息

- 基础版本: CCGS v1.0
- 扩展: MemPalace 记忆层
- 更新日期: 2026-04-27
