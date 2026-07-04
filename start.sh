#!/bin/bash

echo "================================"
echo "  海事文档生成系统"
echo "================================"
echo ""

# 检查Python版本
if ! command -v python3 &> /dev/null; then
    echo "错误: 未找到 Python3，请先安装 Python 3.7 或以上版本"
    exit 1
fi

echo "Python版本: $(python3 --version)"
echo ""

# 检查依赖包
echo "检查依赖包..."
python3 -c "import fastapi" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "正在安装依赖包..."
    pip3 install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo "错误: 依赖包安装失败"
        exit 1
    fi
fi

echo "依赖包检查完成"
echo ""

# 检查模板目录
if [ ! -d "/Users/air/Desktop/海事申请和进出港保障方案模版" ]; then
    echo "警告: 模板目录不存在"
    echo "请确保模板目录位于: /Users/air/Desktop/海事申请和进出港保障方案模版"
    exit 1
fi

echo "模板目录检查完成"
echo ""

# 创建输出目录
mkdir -p output

# 启动应用
echo "正在启动海事文档生成系统..."
echo ""
echo "================================"
echo "系统启动成功！"
echo "================================"
echo "请在浏览器中访问: http://localhost:8000"
echo "按 Ctrl+C 停止系统"
echo "================================"
echo ""

python3 app.py
