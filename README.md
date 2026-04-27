# UranusGameStudio

AI 辅助开发工作流模板，基于 CCGS 构建，支持企业级多项目部署。

**仓库地址**: https://github.com/ogurishun2026/UranusGameStudio

## 目录结构

```
UranusGameStudio/
├── .claude/
│   ├── skills/              # 技能库（按功能域分类）
│   │   ├── dev/             # 开发 (21)
│   │   ├── pm/              # 项目管理 (17)
│   │   ├── qa/              # 测试质量 (10)
│   │   ├── release/         # 发布运维 (6)
│   │   └── game/            # 游戏专用 (19)
│   ├── agents/              # 角色定义（按功能域分类）
│   │   ├── dev/             # 开发 (10)
│   │   ├── pm/              # 项目管理 (3)
│   │   ├── qa/              # 测试质量 (4)
│   │   ├── release/         # 发布运维 (4)
│   │   └── game/            # 游戏专用 (28)
│   ├── hooks/               # 自动化钩子 (12)
│   ├── rules/               # 规则配置 (11)
│   └── settings.json        # 核心配置
│
├── extensions/              # 扩展模块
│   └── mempalace/           # MemPalace 记忆层
│       ├── .mcp.json
│       ├── settings.local.json
│       └── mempalace-config.yaml
│
├── scripts/                 # 安装脚本
│   ├── install.sh
│   └── install.bat
│
└── docs/                    # 文档
    └── README.md
```

## 快速开始

### 1. 安装到新项目

```bash
# 克隆仓库
git clone https://github.com/ogurishun2026/UranusGameStudio.git

# 运行安装脚本
cd UranusGameStudio
./scripts/install.sh /path/to/your/project --with-mempalace
```

### 2. 非游戏项目精简

删除游戏专用模块：

```bash
rm -rf /path/to/project/.claude/skills/game/
rm -rf /path/to/project/.claude/agents/game/
```

## 技能域说明

| 域 | Skills 示例 | Agents 示例 |
|----|-------------|-------------|
| **dev** | code-review, brainstorm, **memory-query**, **memory-save**, security-audit | lead-programmer, devops-engineer |
| **pm** | sprint-plan, estimate, milestone-review, retrospective | producer, analytics-engineer |
| **qa** | qa-plan, smoke-check, regression-suite, test-setup | qa-lead, qa-tester |
| **release** | release-checklist, hotfix, patch-notes | release-manager, localization-lead |
| **game** | art-bible, team-combat, prototype | game-designer, unity-specialist |

## 记忆层 Skills

### memory-query
查询项目记忆，检索历史决策、解决方案、会话记录。

```bash
/memory-query 认证系统架构
/memory-query 之前怎么处理数据库连接池问题
```

### memory-save
保存重要信息到 MemPalace，支持跨会话持久化。

```bash
/memory-save 我们决定使用 Redis 作为缓存层
/memory-save 解决了支付回调偶发失败的问题
```

## 扩展模块

### MemPalace 记忆层

提供持久化记忆能力，支持：
- 语义搜索
- 知识图谱
- Agent 日记

安装时使用 `--with-mempalace` 参数启用。

## 版本

- v1.1.0 - 新增 memory-query、memory-save Skills，MemPalace 集成
- v1.0.0 - 初始版本，基于 CCGS 构建
- 技能数：74
- 角色数：49
- 钩子数：12
- 规则数：11
