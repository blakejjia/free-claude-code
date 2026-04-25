# 使用官方 Python 3.14 镜像作为基础
FROM python:3.14-slim

# 设置工作目录
WORKDIR /app

# 安装 uv (极速 Python 包管理器)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# 复制依赖文件
COPY pyproject.toml uv.lock ./

# 使用 uv 安装依赖 (不安装开发依赖，减少镜像体积)
RUN uv sync --frozen --no-dev --no-install-project

# 复制项目代码
COPY . .

# 暴露端口 (FastAPI 默认端口或你指定的 3000)
EXPOSE 3000

# 启动命令
# 注意：uv run 会自动激活虚拟环境并运行
CMD ["uv", "run", "uvicorn", "server:app", "--host", "0.0.0.0", "--port", "3000"]
