# bWAPP 靶场搭建指南

bWAPP (buggy Web Application) 是一个包含超过 100 个漏洞的 Web 应用程序，专门用于 Web 安全测试学习。本指南将介绍如何使用 Docker 快速搭建 bWAPP 环境。

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

bWAPP 提供了社区维护的 Docker 镜像，直接拉取即可：

```bash
docker pull raesene/bwapp
```

## 2. 部署运行

### 2.1 启动容器

启动 bWAPP：
```bash
docker run -d -p 8085:80 raesene/bwapp
```

参数说明：

> `-d`: 后台运行容器
>
> `-p 8085:80`: 将容器的 80 端口映射到主机的 8085 端口
>
> `raesene/bwapp`: 镜像名称

查看容器运行状态：
```bash
docker ps
```

### 2.2 初始化配置

访问安装页面：

打开浏览器，访问：`http://localhost:8085/install.php`

![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F24%2F10-47-00-0ff50e82c19372acb096f41a13ceae36-20250424104658139-4edbaf.png)

点击 "here" 链接开始安装

![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F24%2F10-49-09-b4b2eaa160102768455cbd35c9187ed8-20250424104907706-f597df.png)

等待数据库初始化完成

访问登录页面：

> 访问：`http://localhost:8085`
>
> 使用默认账号登录：
>
> 用户名：`bee`
>
> 密码：`bug`

![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F24%2F10-50-11-c021397c34609fb329ac47f07466316f-20250424105009584-89d0d8.png)

选择安全级别：

登录后可以选择安全级别：

> low：低安全级别，适合入门学习
>
> medium：中等安全级别，增加了一些防护
>
> high：高安全级别，有较完善的防护措施

## 3. 使用建议

学习顺序

> 从低安全级别开始
>
> 按漏洞类型逐个学习
>
> 理解每个漏洞的原理
>
> 尝试不同的攻击方法

调试工具

> 浏览器开发者工具
>
> Burp Suite
>
> OWASP ZAP
>
> SQLMap

记录笔记

> 记录漏洞复现步骤
>
> 保存有效的 Payload
>
> 总结防护方法



## 4. 常见问题

数据库连接失败
> 检查容器运行状态
>
> 重新执行安装步骤
>
> 查看容器日志

页面访问错误
> 确认端口映射是否正确
>
> 检查防火墙设置
>
> 尝试重启容器

功能无法使用
> 确认是否完成初始化
>
> 检查 PHP 配置
>
> 查看错误日志

## 5. 安全提示

使用建议
> 仅用于学习测试
>
> 不要部署到生产环境
>
> 及时关闭不使用的容器

网络安全
> 使用本地环境测试
>
> 避免暴露到公网
>
> 定期更新系统和 Docker

数据安全
> 不要使用真实密码
>
> 不要存储敏感信息
>
> 做好数据备份 