# Pikachu 靶场搭建指南

Pikachu 是一个用于 Web 安全测试学习的开源靶场，包含了常见的 Web 安全漏洞。本指南将介绍如何使用 Docker 快速搭建 Pikachu 环境。

## 1. 环境准备

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

### 1.2 拉取镜像

有两种方式获取 Pikachu 的 Docker 镜像：

直接拉取现成镜像（推荐）：
```bash
docker pull area39/pikachu
```

## 2. 部署运行

### 2.1 启动容器

使用现成镜像启动：
```bash
docker run --name pikachu -d -p 8083:80 -p 23306:3306 area39/pikachu
```

参数说明：

> `-d`: 后台运行容器
>
> `-p 8083:80`: 将容器的 80 端口映射到主机的 8081 端口
>
> `area39/pikachu`: 镜像名称

### 2.2 访问靶场

打开浏览器，访问：
```
http://localhost:8083
```

初始化数据库：

![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F23%2F16-02-21-b652f1a3257c616b8b0eb346f17a9da9-20250423160219616-093b05.png)

![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F23%2F16-03-08-e0513e6b00f3b2a98acd8eba252c99d4-20250423160306740-7249c2.png)

## 3. 使用建议

学习顺序

> 建议按照靶场目录顺序学习
>
> 先理解漏洞原理，再进行实践
>
> 从简单到困难逐步深入

调试技巧

> 使用浏览器开发者工具
>
> 查看网络请求和响应
>
> 分析 JavaScript 代码
>
> 使用抓包工具辅助分析

注意事项

> 仅在本地环境使用
>
> 不要部署在生产环境
>
> 练习完及时关闭容器

## 4. 安全提示

> 仅用于学习和测试目的
>
> 不要在生产环境中部署
>
> 练习完成后及时关闭容器
>
> 定期更新 Docker 和镜像
>
> 注意防范误操作风险 