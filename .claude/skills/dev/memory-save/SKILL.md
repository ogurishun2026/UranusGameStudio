---
name: memory-save
description: "保存重要信息到 MemPalace 记忆宫殿，包括决策、方案、经验等"
argument-hint: "[要保存的内容描述]"
user-invocable: true
allowed-tools: mcp__mempalace__*
---

## 用途

将重要信息持久化到 MemPalace 记忆宫殿，确保：
- 跨会话保持项目上下文
- 决策记录可追溯
- 经验教训可复用
- 团队知识可共享

## 使用场景

- 完成重要技术决策后记录
- 解决复杂问题后总结方案
- 项目里程碑达成时记录
- 学习到新知识时存档

## 执行流程

### Phase 1: 分析保存内容

根据内容类型确定存储位置：

| 内容类型 | Wing | Room | 示例 |
|---------|------|------|------|
| 架构设计、技术规范 | project | architecture | "认证系统采用 JWT" |
| 技术决策 | project | decisions | "选择 PostgreSQL 而非 MySQL" |
| 会话记录、会议纪要 | session | {日期或主题} | "2026-04-28 架构评审会" |
| 代码模式、解决方案 | code | {技术栈或领域} | "React 状态管理最佳实践" |
| 问题修复记录 | code | bugfix | "修复内存泄漏问题" |
| 学习笔记 | learning | {主题} | "Kubernetes 入门" |
| 团队成员信息 | people | {团队名} | "后端团队职责分工" |

### Phase 2: 检查重复

在保存前检查是否已存在相似内容：

```
调用 mempalace_check_duplicate:
  content: 要保存的内容
  threshold: 0.9
```

如果存在重复（相似度 > 0.9）：
- 提示用户是否要更新现有记录
- 或添加为新版本

### Phase 3: 保存到 MemPalace

```
调用 mempalace_add_drawer:
  wing: 确定的 wing
  room: 确定的 room
  content: 格式化后的内容
  source_file: 来源文件或会话ID
```

### Phase 4: 提取知识图谱

如果内容包含实体关系，同时添加到知识图谱：

```
调用 mempalace_kg_add:
  subject: 主体
  predicate: 关系
  object: 对象
  valid_from: 生效日期
```

常见关系类型：
- `chose` — 技术选型决策
- `depends_on` — 依赖关系
- `caused` — 因果关系
- `belongs_to` — 归属关系
- `started_at` / `ended_at` — 时间状态

### Phase 5: 确认保存

输出保存结果：

```markdown
## 记忆已保存

**存储位置**: {wing}/{room}
**Drawer ID**: {drawer_id}

**内容摘要**:
{保存内容的前100字}...

**关联事实**:
- {subject} → {predicate} → {object}

保存时间: {timestamp}
```

## 内容格式建议

保存的内容应包含以下结构：

```markdown
## {标题}

### 背景
{为什么需要记录这个}

### 内容
{具体内容}

### 影响范围
{这个决策/方案影响哪些模块或团队}

### 相关资源
{链接、文档、代码位置等}
```

## 示例

### 示例 1：保存技术决策
```
/memory-save 我们决定使用 Redis 作为缓存层，原因是：
1. 支持多种数据结构
2. 社区活跃，文档完善
3. 团队已有使用经验
```

### 示例 2：保存问题解决方案
```
/memory-save 解决了支付回调偶发失败的问题，原因是数据库连接超时。
解决方案：增加连接池大小，设置合理的超时时间。
```

### 示例 3：保存会议纪要
```
/memory-save 今天的项目会确定了下周的发布计划，包括用户模块重构和性能优化两个任务
```

## 注意事项

- 保存前检查重复，避免冗余
- 内容要有足够上下文，避免"孤岛记忆"
- 及时更新已过时的记忆（使用 mempalace_kg_invalidate）
- 敏感信息不要保存到记忆宫殿
