# WebGoat 靶场搭建指南

WebGoat 是 OWASP 组织开发的一个故意不安全的 Web 应用程序，用于 Web 安全测试学习。本指南将介绍如何使用 Docker 快速搭建 WebGoat 环境。

## 1. 环境准备

### 1.1 安装 Docker

访问 [Docker 官网](https://www.docker.com/products/docker-desktop/) 下载 Docker Desktop

根据系统提示完成安装

启动 Docker Desktop

打开终端，验证安装：
```bash
docker --version
```

### 1.2 拉取镜像

WebGoat 提供了官方的 Docker 镜像，直接拉取即可：

```bash
docker pull webgoat/webgoat
```

## 2. 部署运行

### 2.1 启动容器

启动 WebGoat：
```bash
docker run -d -p 8084:8080 -p 8089:9090 webgoat/webgoat
```

参数说明：

`-d`: 后台运行容器

`-p 8080:8080`: WebGoat 应用端口

`-p 9090:9090`: WebWolf 应用端口

`webgoat/webgoat`: 镜像名称

查看容器运行状态：
```bash
docker ps
```

### 2.2 访问靶场

WebGoat 访问：

> 打开浏览器，访问：`http://localhost:8084/WebGoat`
>
> 首次访问需要注册账号
>
> 建议使用英文用户名，避免编码问题

![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F23%2F16-23-06-39c4f1ad6698e641baf85ffa1a41c591-20250423162304646-b1ca24.png)

WebWolf 访问：

> 打开浏览器，访问：`http://localhost:8089/WebWolf`
>
> 使用与 WebGoat 相同的账号登录

![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F23%2F16-22-12-916f4f0ece06f77b7fa213552daceb42-20250423162210265-dcc98d.png)



## 3. 常见问题

无法访问页面

> 检查容器运行状态
>
> 确认端口映射是否正确
>
> 验证防火墙设置

注册登录问题

> 使用英文用户名和密码
>
> 密码长度至少 8 位
>
> 避免特殊字符

实验重置

> 使用页面的重置按钮
>
> 重启容器清除数据
>
> 重新创建用户

## 4. 安全提示

环境安全

> 仅在本地测试环境使用
>
> 不要在生产环境部署
>
> 及时关闭不使用的容器

个人安全

> 使用专门的学习账号
>
> 不要使用真实密码
>
> 注意数据安全

系统安全

> 定期更新 Docker
>
> 及时更新 WebGoat 镜像
>
> 监控系统资源使用 