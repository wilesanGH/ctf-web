# Postman 安装与使用教程

## 一、Postman 简介

Postman 是一款强大的 API 接口调试与开发工具，广泛应用于前后端联调、接口测试、自动化测试等场景。支持 Windows、MacOS、Linux 多平台。

---

## 二、Postman 下载与安装

### 1. Windows 系统

> 1. 访问 [Postman 官网](https://www.postman.com/downloads/) 下载 Windows 版本安装包。
> 1.1. 访问[校内网下载](http://gofile.me/6BUax/caPOEz3gI)下载postman-win64-setup.exe
> 2. 双击下载的 `.exe` 安装包，按照提示完成安装。
> 3. 安装完成后，桌面会生成 Postman 图标，双击即可启动。
>

### 2. MacOS 系统

> 1. 访问 [Postman 官网](https://www.postman.com/downloads/) 下载 Mac 版本安装包（`.dmg` 文件）。
> 2. 双击打开 `.dmg` 文件，将 Postman 拖入 Applications 文件夹。
> 3. 在 Launchpad 或应用程序中找到 Postman，双击启动。
>

### 3. Linux 系统

> 1. 访问 [Postman 官网](https://www.postman.com/downloads/) 下载 Linux 版本（`.tar.gz`）。
> 2. 解压后进入目录，运行 `./Postman` 启动即可。
>

---

## 三、Postman 基本使用

### 1. 创建并发送请求

> 1. 打开 Postman，点击左上角 "New" -> "HTTP Request"。
> 2. 在地址栏输入接口 URL，例如 `http://10.16.2.3:8081/Less-1`。
> 3. 选择请求方法（GET、POST、PUT、DELETE 等）。
> 4. 如需传递参数，可在 Params、Body、Headers 等区域填写。
> 5. 点击 "Send" 发送请求，右侧会显示响应结果。
>

![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F13-59-51-2d8152add36124effa1cebdf28e4f431-20250429135949008-23d7ea.png)

### 2. 保存请求

点击 "Save" 按钮，可将当前请求保存到 Collection（集合）中，方便后续复用和管理。

### 3. 导入/导出接口文档

支持导入 Swagger/OpenAPI、cURL、Postman Collection 等多种格式。

点击左上角 "Import"，选择文件或粘贴内容即可导入。

---

## 四、常见问题

**无法访问接口？**

> 检查接口地址、端口、网络连通性。
>
> 检查是否需要 VPN 或代理。

**接口需要登录认证？**

> 在 Headers 或 Authorization 区域填写 Token、Cookie 等认证信息。

**响应乱码？**

> 检查响应头的 Content-Type，必要时切换编码格式。

---

## 五、更多高级用法

> 支持环境变量、全局变量设置，便于多环境切换。
>
> 支持自动化测试脚本（Pre-request Script、Tests）。
>
> 支持团队协作、接口文档自动生成等功能。

---

> **注意：**  
>
> Postman 也有网页版（[https://web.postman.co/](https://web.postman.co/)），无需安装客户端即可使用，但部分高级功能需登录账号。
>
> **重要提示：** Postman网页版无法访问内网资源（如`http://10.16.2.3:8081`），如需访问内网接口，请使用Postman桌面客户端。
