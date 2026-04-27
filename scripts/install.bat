@echo off
REM AI Workflow Template 安装脚本 (Windows)
REM 用法: install.bat <目标项目路径> [--with-mempalace]

setlocal enabledelayedexpansion

set "TEMPLATE_DIR=%~dp0"
set "TARGET_DIR=%~1"
set "WITH_MEMPALACE=%~2"

if "%TARGET_DIR%"=="" set "TARGET_DIR=."

echo ========================================
echo   AI Workflow Template Installer
echo ========================================
echo.

REM 检查目标目录
if not exist "%TARGET_DIR%" (
    echo 创建目录: %TARGET_DIR%
    mkdir "%TARGET_DIR%"
)

cd /d "%TARGET_DIR%"
for %%I in (.) do set "TARGET_DIR=%%~fI"
echo 目标项目: %TARGET_DIR%
echo.

REM Step 1: 复制核心模板
echo [1/3] 复制核心模板...
if exist ".claude" (
    echo   .claude 目录已存在，跳过
) else (
    xcopy "%TEMPLATE_DIR%.claude" ".claude" /E /I /Q
    echo   √ .claude/ (skills, agents, hooks, rules^)
)

REM Step 2: 复制 CLAUDE.md 模板
echo [2/3] 检查 CLAUDE.md...
if exist "CLAUDE.md" (
    echo   CLAUDE.md 已存在，跳过
) else (
    (
        echo # CLAUDE.md
        echo.
        echo 本项目使用 AI Workflow Template。
        echo.
        echo ## 项目概述
        echo.
        echo [在此描述你的项目]
        echo.
        echo ## 工作流指导
        echo.
        echo - 使用 `/skill ^<name^>` 调用可用技能
        echo - 使用 `/help` 查看帮助
        echo.
        echo ## 构建命令
        echo.
        echo [在此添加项目的构建和运行命令]
    ) > CLAUDE.md
    echo   √ CLAUDE.md (模板^)
)

REM Step 3: 可选安装 MemPalace
echo [3/3] 扩展模块...
if "%WITH_MEMPALACE%"=="--with-mempalace" (
    set "EXTENSION_DIR=%TEMPLATE_DIR%..\mempalace-extension"

    if exist "!EXTENSION_DIR!" (
        copy "!EXTENSION_DIR!\.mcp.json" "." >nul
        copy "!EXTENSION_DIR!\settings.local.json" ".claude\" >nul
        copy "!EXTENSION_DIR!\mempalace-config.yaml" ".claude\" >nul

        echo   √ .mcp.json
        echo   √ .claude/settings.local.json
        echo   √ .claude/mempalace-config.yaml

        echo   MemPalace 扩展已安装
    ) else (
        echo   MemPalace 扩展目录不存在，跳过
    )
) else (
    echo   跳过 MemPalace 扩展 (使用 --with-mempalace 安装^)
)

echo.
echo ========================================
echo   安装完成！
echo ========================================
echo.
echo 下一步:
echo   1. 编辑 CLAUDE.md 填写项目信息
echo   2. cd %TARGET_DIR% ^&^& claude
if "%WITH_MEMPALACE%"=="--with-mempalace" (
    echo   3. 需要手动配置 MemPalace 路径
)

endlocal
