#!/bin/bash

echo "================================"
echo "  准备 Docker 部署"
echo "================================"
echo ""

# 检查是否在项目根目录
if [ ! -f "app.py" ]; then
    echo "错误: 请在项目根目录运行此脚本"
    exit 1
fi

# 创建必要的目录
echo "创建必要的目录..."
mkdir -p templates
mkdir -p output
mkdir -p data

# 检查原始模板目录
ORIGINAL_TEMPLATE_DIR="/Users/air/Desktop/海事申请和进出港保障方案模版"

if [ -d "$ORIGINAL_TEMPLATE_DIR" ]; then
    echo "正在复制模板文件..."
    cp -r "$ORIGINAL_TEMPLATE_DIR"/* templates/
    echo "✓ 模板文件复制完成"
else
    echo "警告: 原始模板目录不存在: $ORIGINAL_TEMPLATE_DIR"
    echo "请手动将模板文件复制到 templates/ 目录"
fi

# 检查潮水表文件
echo ""
echo "检查潮水表文件..."
if [ ! -f "templates/2026年湛江港潮水表.xlsx" ] || [ ! -f "templates/2026年硇洲岛潮水表.xlsx" ]; then
    echo "警告: 缺少潮水表文件"
    echo "请确保以下文件存在于 templates/ 目录："
    echo "  - 2026年湛江港潮水表.xlsx"
    echo "  - 2026年硇洲岛潮水表.xlsx"
else
    echo "✓ 潮水表文件检查通过"
fi

echo ""
echo "================================"
echo "  准备完成！"
echo "================================"
echo ""
echo "下一步操作："
echo "1. 将项目推送到 GitHub"
echo "2. 在 NAS 上执行部署"
echo "3. 详见 DEPLOYMENT.md"
echo ""
