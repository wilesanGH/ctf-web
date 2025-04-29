# Burp Suite 安装与配置

## 一、Burp Suite 简介

Burp Suite 是一款广泛应用于 Web 安全测试的集成式渗透测试工具，主要用于拦截、修改和重放 HTTP/HTTPS 请求，常用于漏洞挖掘、CTF 比赛等场景。

## 二、Burp Suite 下载

1. **官网下载**
https://portswigger.net/burp/communitydownload
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-23-05-a039021645bf95eec98ac7116fb91635-20250429102303894-3fa091.png)
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-23-28-bd4d6a430a7a1eaa9a77b93b6264447d-20250429102326703-dc8fe1.png)

## 三、Burp Suite 安装

### 1. Windows 系统

1. 下载 Burp Suite 安装包（.exe 文件）。
2. 双击运行安装包，按照提示完成安装。
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-27-04-0652cd1cc54960095b8358dc5c9c9aac-20250429102702786-82dc8f.png)
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-27-26-d7910a0a9c885d1b1bbc808d6e444e8b-20250429102724473-de5820.png)
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-27-42-fbf471da24feb1d8f13ad5a73c4abf80-20250429102741065-9becc9.png)
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-29-39-59eb5b55d8fb2a709fcb401d8ec8c0c4-20250429102938022-cd559e.png)
3. 安装完成后，桌面会生成 Burp Suite 图标，双击即可启动。
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-30-20-e135afc3f6403a61c16dc5ccd1cd5a05-20250429103018189-ef6df5.png)
### 2. MacOS 系统

1. 下载 Burp Suite 安装包（.dmg 文件）。
2. 双击打开 dmg 文件，将 Burp Suite 拖入 Applications 文件夹。
3. 在 Launchpad 或应用程序中找到 Burp Suite，双击启动。

> **注意：**  
> 部分杀毒软件可能会误报，建议添加信任或临时关闭杀毒软件。

## 四、Burp Suite 配置

### 1. 使用内置浏览器

Burp Suite 现在内置了基于 Chromium 的浏览器，无需额外配置代理：

1. 启动 Burp Suite
2. 点击顶部菜单栏的 "Open Browser" 按钮
3. 内置浏览器会自动配置好代理设置，可以直接开始使用

### 2. 安装 Burp Suite 证书（必需步骤）

即使使用内置浏览器，也需要安装证书才能正常拦截HTTPS流量：

1. 启动 Burp Suite，确保 Proxy -> Intercept 为 off
2. 使用内置浏览器访问 `http://burp` 或 `http://127.0.0.1:8080`
3. 点击"CA Certificate"下载证书（一般为 `cacert.der`）
![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-34-06-f8e57c09486773bf1e1776254a855f21-20250429103404606-fea445.png)
4. 在浏览器设置中导入证书：
   - 点击浏览器右上角的三个点，选择"设置"
   - 在左侧菜单中点击"隐私设置和安全性"
   ![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-35-49-a31d3ae9269975cbd0bf1090503f4260-20250429103547320-714a5e.png)
   - 点击"安全"
   ![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-36-22-6ba3d5528849a9a7e61b4ba421f91ceb-20250429103620300-ebfa70.png)
   - 点击"管理证书"
   ![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-36-49-f03ee0edea5e641d779e541f6e353016-20250429103647857-ae757d.png)
   - 在"受信任的根证书颁发机构"标签页中，点击"导入"
   ![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-39-19-c714a464078e8c1f8184c1e671e0e37a-20250429103917287-a5c25e.png)
   - 选择下载的 `cacert.der` 文件
   ![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-41-34-880a030140d376985c8d38cbcebf4866-20250429104132761-25b47c.png)
   - 在证书导入向导中，选择"将所有证书放入下列存储"，然后选择"受信任的根证书颁发机构"
   ![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-42-09-aa3e50b9f20cc897efc6e473d63e7070-20250429104207893-4e8281.png)
   - 点击"完成"完成导入
   ![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-42-34-c1984d514de2628bda839c1530416c8b-20250429104232935-b03467.png)
   ![](https://picgo-bucket-1253899661.cos.ap-shanghai.myqcloud.com/2025%2F04%2F29%2F10-43-05-16f546a2891d2375e5dedf3541056d79-20250429104303952-ebadb5.png)
5. 导入证书后，重启内置浏览器

> **注意：**  
> 安装证书后建议重启浏览器。

## 五、常见问题

> **无法拦截请求？**  
> 检查 Burp Suite 是否正常运行，Proxy -> Intercept 是否开启。
>
> **HTTPS 网站提示证书不受信任？**  
> 检查是否正确导入并信任 Burp Suite 证书。
>
> **端口被占用？**  
> 可在 Burp Suite -> Proxy -> Options 中修改监听端口。

