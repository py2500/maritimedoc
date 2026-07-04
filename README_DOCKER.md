# 海事文档生成系统 - Docker 快速部署

## 本地测试

### 1. 准备环境
```bash
# 运行准备脚本
./prepare-deploy.sh
```

### 2. 本地测试运行
```bash
# 使用 docker-compose
docker-compose up -d

# 或使用 docker
docker build -t maritime-doc-generator .
docker run -d \
  --name maritime-doc-generator \
  -p 8000:8000 \
  -v $(pwd)/templates:/app/templates:ro \
  -v $(pwd)/output:/app/output \
  maritime-doc-generator
```

### 3. 访问应用
打开浏览器访问: `http://localhost:8000`

## 推送到 GitHub

```bash
# 初始化 Git（首次）
git init
git add .
git commit -m "Add Docker support"
git branch -M main

# 添加远程仓库
git remote add origin https://github.com/你的用户名/maritime-doc-generator.git

# 推送
git push -u origin main
```

## NAS 部署

### SSH 方式部署

```bash
# SSH 连接到 NAS
ssh 用户名@NAS_IP

# 进入 docker 目录
cd /volume1/docker

# 克隆仓库
git clone https://github.com/你的用户名/maritime-doc-generator.git
cd maritime-doc-generator

# 上传模板文件（如果在本地已准备好）
# 或手动上传到 templates/ 目录

# 启动服务
docker-compose up -d
```

### 端口配置

- 应用端口: 8000
- 数据持久化:
  - `output/` - 生成的文档
  - `data/` - 数据库文件
  - `templates/` - 模板文件（只读）

## 注意事项

1. **模板文件**: 必须将模板文件放在 `templates/` 目录中
2. **潮水表**: 确保 `2026年湛江港潮水表.xlsx` 和 `2026年硇洲岛潮水表.xlsx` 存在
3. **数据备份**: 定期备份 `output/` 和 `data/` 目录
4. **端口访问**: 确保防火墙允许 8000 端口访问

## 故障排查

```bash
# 查看日志
docker-compose logs -f

# 重启服务
docker-compose restart

# 进入容器
docker exec -it maritime-doc-generator bash
```

详细部署说明请参考 [DEPLOYMENT.md](DEPLOYMENT.md)
