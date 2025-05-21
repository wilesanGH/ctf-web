# DVWA 环境搭建指南

DVWA (Damn Vulnerable Web Application) 是一个用于安全测试和教学的故意存在漏洞的 PHP/MySQL Web 应用程序。本指南将介绍多种安装方式。

## 1. Docker 方式安装（推荐）

### 1.1 安装 Docker

> 访问 [Docker 官网](https://www.docker.com/products/docker-desktop/) 下载 Docker Desktop
>
> 根据系统提示完成安装
>
> 启动 Docker Desktop
>
> 打开终端，验证安装：

```bash
docker --version
```

### 1.2 部署 DVWA

1. 拉取官方镜像：
   ```bash
   docker pull vulnerables/web-dvwa
   ```

2. 运行容器：
   ```bash
   docker run -dt --name dvwa -p 8082:80 vulnerables/web-dvwa
   ```

3. 访问 DVWA：
   > 打开浏览器，访问 `http://localhost:8082`
   >
   > 默认登录凭据：
   >
   > 用户名：`admin`
   >
   > 密码：`password`

## 2. 初始化设置

1. 访问 DVWA：
   
   > 打开浏览器访问对应地址
   >
   > 使用默认凭据登录
   
2. 初始化数据库：
   
   > 点击页面底部的 "Setup / Reset DB"
   >
   > 点击 "Create / Reset Database" 按钮
   
3. 安全级别设置：
   
   > 登录后，点击 "DVWA Security"
   >
   > 选择难度级别（Low/Medium/High/Impossible）

## 3. 常见问题

1. 数据库连接失败：
   
   > 检查数据库服务是否启动
   >
   > 验证数据库凭据是否正确
   >
   > 确认数据库用户权限
   
2. 文件权限问题：
   
   > 确保 Web 服务器对 DVWA 目录有正确的读写权限
   >
   > 检查 `hackable/uploads/` 和 `/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt` 的权限
   
3. reCAPTCHA 问题：
   > 如需使用 reCAPTCHA，需要在 `config.inc.php` 中配置有效的 API 密钥

## 4. 安全提示

> DVWA 仅用于学习和测试目的
>
> 不要在生产环境中部署
>
> 建议在隔离的虚拟机或容器中运行
>
> 完成练习后及时关闭环境 