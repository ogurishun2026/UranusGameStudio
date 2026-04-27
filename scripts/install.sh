#!/bin/bash
# AI Workflow Template 安装脚本
# 用法: ./install.sh <目标项目路径> [--with-mempalace]

set -e

TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="${1:-.}"
WITH_MEMPALACE="${2:-}"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  AI Workflow Template Installer${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# 检查目标目录
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}创建目录: $TARGET_DIR${NC}"
    mkdir -p "$TARGET_DIR"
fi

cd "$TARGET_DIR"
TARGET_DIR="$(pwd)"
echo -e "目标项目: ${YELLOW}$TARGET_DIR${NC}"
echo ""

# Step 1: 复制核心模板
echo -e "${GREEN}[1/3] 复制核心模板...${NC}"
if [ -d ".claude" ]; then
    echo -e "${YELLOW}  .claude 目录已存在，跳过${NC}"
else
    cp -r "$TEMPLATE_DIR/.claude" "$TARGET_DIR/"
    echo -e "  ✓ .claude/ (skills, agents, hooks, rules)"
fi

# Step 2: 复制 CLAUDE.md 模板（如果不存在）
echo -e "${GREEN}[2/3] 检查 CLAUDE.md...${NC}"
if [ -f "CLAUDE.md" ]; then
    echo -e "${YELLOW}  CLAUDE.md 已存在，跳过${NC}"
else
    cat > CLAUDE.md << 'EOF'
# CLAUDE.md

本项目使用 AI Workflow Template。

## 项目概述

[在此描述你的项目]

## 工作流指导

- 使用 `/skill <name>` 调用可用技能
- 使用 `/help` 查看帮助

## 构建命令

[在此添加项目的构建和运行命令]
EOF
    echo -e "  ✓ CLAUDE.md (模板)"
fi

# Step 3: 可选安装 MemPalace
echo -e "${GREEN}[3/3] 扩展模块...${NC}"
if [ "$WITH_MEMPALACE" == "--with-mempalace" ]; then
    EXTENSION_DIR="$TEMPLATE_DIR/../mempalace-extension"

    if [ -d "$EXTENSION_DIR" ]; then
        # 复制 .mcp.json
        cp "$EXTENSION_DIR/.mcp.json" "$TARGET_DIR/"

        # 复制 settings.local.json
        cp "$EXTENSION_DIR/settings.local.json" "$TARGET_DIR/.claude/"

        # 复制 mempalace-config.yaml
        cp "$EXTENSION_DIR/mempalace-config.yaml" "$TARGET_DIR/.claude/"

        echo -e "  ✓ .mcp.json"
        echo -e "  ✓ .claude/settings.local.json"
        echo -e "  ✓ .claude/mempalace-config.yaml"

        # 替换占位符
        MEMPALACE_PATH="C:/Users/MSI-NB/Desktop/AI前沿实验场/ai-harness/harness-workspace/mempalace-github-code"
        PROJECT_PATH="$(echo $TARGET_DIR | sed 's/\//\\\\/g')"

        if [ -f "$TARGET_DIR/.mcp.json" ]; then
            sed -i "s|{{MEMPALACE_PATH}}|$MEMPALACE_PATH|g" "$TARGET_DIR/.mcp.json"
            sed -i "s|{{MEMPALACE_PATH}}|$MEMPALACE_PATH|g" "$TARGET_DIR/.claude/settings.local.json"
            sed -i "s|{{PROJECT_PATH}}|$PROJECT_PATH|g" "$TARGET_DIR/.claude/mempalace-config.yaml"
        fi

        echo -e "  ${GREEN}MemPalace 扩展已安装${NC}"
    else
        echo -e "  ${YELLOW}MemPalace 扩展目录不存在，跳过${NC}"
    fi
else
    echo -e "  跳过 MemPalace 扩展 (使用 --with-mempalace 安装)"
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  安装完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "下一步:"
echo "  1. 编辑 CLAUDE.md 填写项目信息"
echo "  2. cd $TARGET_DIR && claude"
if [ "$WITH_MEMPALACE" == "--with-mempalace" ]; then
    echo "  3. 初始化 MemPalace: mempalace init $TARGET_DIR/.mempalace/palace --yes"
fi
