FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 安装Python依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用文件
COPY app.py .
COPY static/ ./static/

# 创建必要的目录
RUN mkdir -p output

# 暴露端口
EXPOSE 8000

# 设置环境变量
ENV TEMPLATE_DIR=/app/templates
ENV OUTPUT_DIR=/app/output

# 启动应用
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
