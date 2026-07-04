# Docker 部署指南

## 前置准备

### 1. 准备模板文件
将模板文件复制到项目目录的 `templates` 文件夹中：

```bash
mkdir -p templates
cp -r "/Users/air/Desktop/海事申请和进出港保障方案模版/"* templates/
```

### 2. 修改 app.py 中的模板路径
将 `app.py` 中的模板目录路径修改为支持环境变量的方式：

```python
# 将这一行（第19行）：
TEMPLATE_DIR = Path("/Users/air/Desktop/海事申请和进出港保障方案模版")

# 修改为：
TEMPLATE_DIR = Path(os.getenv("TEMPLATE_DIR", "/app/templates"))
```

同时需要在文件顶部添加：
```python
import os
```

## 部署步骤

### 方式一：使用 Docker Compose（推荐）

1. **构建并启动容器**
```bash
docker-compose up -d --build
```

2. **查看日志**
```bash
docker-compose logs -f
```

3. **停止服务**
```bash
docker-compose down
```

### 方式二：使用 Docker 命令

1. **构建镜像**
```bash
docker build -t maritime-doc-generator:latest .
```

2. **运行容器**
```bash
docker run -d \
  --name maritime-doc-generator \
  -p 8000:8000 \
  -v $(pwd)/templates:/app/templates:ro \
  -v $(pwd)/output:/app/output \
  -v $(pwd)/data:/app/data \
  -e TEMPLATE_DIR=/app/templates \
  --restart unless-stopped \
  maritime-doc-generator:latest
```

3. **查看日志**
```bash
docker logs -f maritime-doc-generator
```

4. **停止容器**
```bash
docker stop maritime-doc-generator
docker rm maritime-doc-generator
```

## GitHub 部署到 NAS

### 1. 推送到 GitHub

```bash
cd /Users/air/Desktop/maritime-doc-generator

# 初始化 Git（如果还没有）
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit for Docker deployment"

# 添加远程仓库
git remote add origin https://github.com/yourusername/maritime-doc-generator.git

# 推送
git push -u origin main
```

### 2. 在 NAS 上部署

#### 对于 Synology NAS：
1. 安装 Docker 套件
2. 打开 Docker，进入注册表
3. 可以选择：
   - 直接从 GitHub 克隆并构建
   - 或使用 SSH 连接到 NAS，执行以下命令：

```bash
# SSH 连接到 NAS
ssh yourusername@nas-ip

# 进入 docker 目录
cd /volume1/docker

# 克隆仓库
git clone https://github.com/yourusername/maritime-doc-generator.git
cd maritime-doc-generator

# 准备模板文件（需要手动上传或通过 rsync）
# 将模板文件放到 templates 目录

# 启动服务
docker-compose up -d
```

#### 对于支持 Portainer 的 NAS：
1. 安装 Portainer
2. 在 Portainer 中创建 Stack
3. 粘贴 docker-compose.yml 内容
4. 部署

### 3. 配置 NAS 端口转发

在 NAS 路由器或防火墙中配置端口转发：
- 外部端口: 80 或自定义端口
- 内部端口: 8000
- 内部IP: NAS 的 IP 地址

## 访问应用

部署完成后，通过以下地址访问：

- 局域网内: `http://NAS_IP:8000`
- 通过域名: `http://your-domain.com`（如果配置了端口转发）

## 数据备份

重要数据位于：
- `output/` - 生成的文档
- `data/` - 数据库文件

建议定期备份这些目录。

## 故障排查

1. **查看容器日志**
```bash
docker logs maritime-doc-generator
```

2. **进入容器调试**
```bash
docker exec -it maritime-doc-generator bash
```

3. **检查模板文件**
```bash
ls -la templates/
```

4. **重启容器**
```bash
docker-compose restart
```

## 注意事项

1. 模板文件必须放在 `templates/` 目录中
2. 确保 NAS 有足够的存储空间
3. 定期备份 `output` 和 `data` 目录
4. 根据网络环境调整端口映射
