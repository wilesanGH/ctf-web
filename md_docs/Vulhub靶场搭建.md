# Vulhub 靶场搭建指南

Vulhub 是一个基于 Docker 和 docker-compose 的漏洞环境集合，包含了大量真实漏洞环境，可用于漏洞复现和学习。

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

### 1.2 安装 Docker Compose

> Docker Desktop for Windows/Mac 已经包含了 docker-compose
>
> Linux 用户需要额外安装：
>
> ```bash
> sudo apt install docker-compose  # Ubuntu/Debian
> sudo yum install docker-compose  # CentOS
> ```

### 1.3 获取 Vulhub

克隆官方仓库：

```bash
git clone https://github.com/vulhub/vulhub.git
```

## 2. 使用方法

### 2.1 基本操作

进入漏洞目录：
```bash
cd vulhub/flask/ssti
```

编译并启动环境：
```bash
docker-compose up -d
```

停止并删除环境：
```bash
docker-compose down
```

### 2.2 常用命令

查看运行状态：
```bash
docker-compose ps
```

查看容器日志：
```bash
docker-compose logs
```

重新构建环境：
```bash
docker-compose build
```

## 3. 漏洞环境列表

| 目录名 | 漏洞/场景说明 |
|--------|--------------|
| activemq | Apache ActiveMQ 多个反序列化漏洞（如 CVE-2015-5254、CVE-2016-3088、CVE-2022-41678、CVE-2023-46604），RCE 练习 |
| adminer | Adminer 数据库管理工具任意文件上传与命令执行漏洞（CVE-2021-21311、CVE-2021-43008） |
| airflow | Apache Airflow 未授权访问、XXE 与任务执行漏洞（CVE-2020-11978/11981/17526） |
| aj-report | 亚信 AJReport 报表系统 RCE 漏洞（CNVD-2024-15077） |
| apache-druid | Apache Druid PhantomJS XXE／SSRF 漏洞（CVE-2021-25646） |
| apereo-cas | Apereo CAS 身份认证绕过与 RCE 环境（4.1-rce） |
| apisix | Apache APISIX 配置注入与 Dashboard RCE 漏洞（CVE-2020-13945/2021-45232） |
| appweb | Appweb 路径遍历与远程命令执行漏洞复现（CVE-2018-8715） |
| aria2 | aria2 RPC 服务未鉴权导致 RCE 漏洞环境 |
| bash | GNU Bash "Shellshock" 漏洞（CVE-2014-6271）复现环境 |
| cacti | Cacti 配置注入与 SQL 注入漏洞复现 |
| celery | Celery 未授权任务执行漏洞，可执行任意代码 |
| cgi | 通用 CGI 脚本注入及 Shellshock 场景 |
| cmsms | CMS Made Simple 任意文件上传与 RCE 漏洞 |
| coldfusion | Adobe ColdFusion 代码执行漏洞环境（多个 CVE，如 CF11、2018.0.15、8.0.1） |
| confluence | Atlassian Confluence OGNL 注入漏洞（CVE-2021-26084）复现 |
| couchdb | CouchDB 未授权访问与 SSRF 漏洞 |
| craftcms | Craft CMS 任意文件上传／SSRF 漏洞复现 |
| cups-browsed | CUPS 打印服务远程命令执行漏洞；未授权操作场景 |
| discuz | Discuz! X 任意文件下载、SQL 注入等常见漏洞环境 |
| django | Django 多版本 SSRF、模板注入与 RCE 漏洞 |
| dns | BIND DNS 配置／缓存投毒等漏洞场景 |
| docker | Docker daemon 特权泄露与逃逸场景复现 |
| drupal | Drupal SQL 注入、远程代码执行等多种 CVE 环境 |
| dubbo | Apache Dubbo 反序列化漏洞热点（2.7.3）环境 |
| ecshop | ECShop 目录遍历与 RCE 漏洞环境（2.7.3/3.6.0/4.0.6） |
| elasticsearch | Elasticsearch 任意文件读取、RCE 与 SSRF 漏洞（1.x–7.x 多版本） |
| electron | Electron 应用打包与权限绕过场景环境 |
| elfinder | elFinder 任意文件上传／命令执行漏洞复现 |
| fastjson | Fastjson 反序列化漏洞环境（1.2.24/1.2.45），Java RCE 演示 |
| ffmpeg | FFmpeg 处理库漏洞（2.8.4/3.2.4 及 php 版本），RCE 演示 |
| flask | Flask 代码注入／模板注入漏洞演示（1.1.1） |
| flink | Apache Flink RCE 与作业提交未授权场景 |
| geoserver | GeoServer XXE 与 RCE 漏洞环境（2.17.2–2.23.2） |
| ghostscript | Ghostscript 命令执行与 PDF 漏洞复现（9.x 多版本） |
| git | Git hooks 与 SSH 密钥注入场景演示（2.12.2/2.29.1） |
| gitea | Gitea 未授权访问与组件漏洞演示 |
| gitlab | GitLab 任意文件读取、RCE 漏洞（8.13.1/13.10.1） |
| gitlist | GitList 目录遍历与配置注入场景 |
| glassfish | GlassFish 管理界面未授权命令执行场景（4.1/5.1） |
| goahead | GoAhead Web 服务器 CVE-2014-6271 等漏洞演示 |
| gogs | Gogs 任意文件上传／敏感信息泄露演示 |
| grafana | Grafana 仪表板 SSRF 与 RCE 漏洞（8.2.6/8.5.4） |
| h2database | H2 Database 控制台未授权访问与 RCE 场景演示 |
| hadoop | Hadoop NameNode/Datanode 未授权命令执行演示 |
| hertzbeat | HertzBeat 监控平台漏洞复现 |
| httpd | Apache HTTPD Heartbleed、配置信息泄露等多版本演示 |
| hugegraph | HugeGraph 未授权访问与 RCE 漏洞示例（1.2.0/1.3.0） |
| imagemagick | ImageMagick "Ghostscript" 漏洞（6.x–7.x 多版本） |
| influxdb | InfluxDB 未授权读写与 RCE 漏洞（1.6.6/1.7.9） |
| ingress-nginx | Kubernetes Ingress-NGINX 配置绕过／信息泄露演示（1.9.5） |
| jackson | Jackson 库反序列化漏洞演示场景 |
| jboss | JBoss 管理控制台未授权访问与 RCE 演示（4.x/6.1.0） |
| jenkins | Jenkins 初始化脚本与插件漏洞演示（2.138/2.441/2.46.1） |
| jetty | Jetty RCE 与路径遍历场景（9.4.37/9.4.40） |
| jimureport | JIMUReport 报表系统 RCE 漏洞演示（1.6.0） |
| jira | Atlassian Jira 配置注入／RCE 场景（8.1.0） |
| jmeter | Apache JMeter SSRF 与脚本注入示例 |
| joomla | Joomla 任意文件上传与 RCE 漏洞（3.4.5/3.7.0/4.2.7） |
| jumpserver | JumpServer 平台未授权命令执行与 SSRF 漏洞演示（3.6.3/3.6.4） |
| jupyter | Jupyter Notebook 远程代码执行漏洞复现（5.2.2） |
| kafka | Apache Kafka 未授权写入与命令执行场景 |
| kibana | Kibana SSRF 与 RCE 漏洞（5.6.12/6.5.4/7.6.2） |
| kkfileview | KKFileView 文件预览漏洞演示 |
| langflow | LangFlow 可视化工具 RCE 漏洞复现 |
| laravel | Laravel 任意文件写入与代码执行场景（8.4.2） |
| librsvg | librsvg 图像处理库远程代码执行漏洞示例 |
| libssh | libssh 认证绕过漏洞（0.7.4/0.8.1）场景 |
| liferay-portal | Liferay Portal RCE 与信息泄露演示（7.2.0-ga1） |
| log4j | Apache Log4j "Log4Shell" 反序列化漏洞（2.8.1） |
| magento | Magento RCE 漏洞示例（2.2.7） |
| metabase | Metabase SQL 注入与 RCE 场景（0.40.4/0.46.6） |
| metersphere | Metersphere 未授权接口与命令执行演示（1.15.4/1.16.3） |
| mini_httpd | mini_httpd 低版本漏洞复现 |
| minio | MinIO 信息泄露与 RCE 场景复现 |
| mojarra | Mojarra JSF 模板注入与 RCE 演示（2.1.28） |
| mongo-express | mongo-express 未授权管理接口与命令执行漏洞 |
| mysql | MySQL 5.x 目录遍历与信息泄露场景 |
| nacos | Nacos 控制台未授权操作与 RCE 漏洞演示 |
| neo4j | Neo4j 未授权读写与 RCE 漏洞（3.4.18） |
| next.js | Next.js SSR 漏洞与配置绕过场景（15.2.2） |
| nexus | Sonatype Nexus 远程代码执行与配置注入演示 |
| nginx | Nginx Heartbleed 与配置注入／信息泄露场景 |
| node | Node.js 包注入与依赖漏洞演示（8.5.0/9.0.0） |
| ntopng | ntopng Web 界面 RCE 与 SSRF 演示 |
| ofbiz | Apache OFBiz RCE 与任意文件读取漏洞（17.x/18.x 系列） |
| openfire | Openfire 未授权管理员访问与 RCE（4.7.4） |
| opensmtpd | OpenSMTPD 远程命令执行漏洞（6.6.1p1） |
| openssh | OpenSSH 漏洞复现与配置注入演示（7.7） |
| openssl | OpenSSL 心脏出血、信息泄露与 RCE 演示（1.0.1c/1.1.1m） |
| opentsdb | OpenTSDB 未授权读写与 RCE 漏洞示例 |
| pdfjs | PDF.js XSS 与本地文件读取漏洞演示（4.1.392） |
| pgadmin | pgAdmin 未授权访问与命令执行场景（6.16/7.6） |
| php | 多版本 PHP FPM/Apache 漏洞（5.x–8.x-backdoor 等） |
| phpmyadmin | phpMyAdmin 任意文件上传／RCE 漏洞演示（2.8.0.4/4.4.15.6/4.8.1） |
| phpunit | PHPUnit 远程代码执行漏洞（5.6.2）示例 |
| polkit | polkit 本地权限提升/命令执行漏洞（0.105 系列） |
| postgres | PostgreSQL 配置绕过与 RCE 场景（9.6.7/10.7） |
| rails | Ruby on Rails SSRF 与代码执行（5.0.7/5.2.2） |
| redis | Redis 未授权命令执行与 RCE 演示（2.8/4.0.14/5.0.7） |
| rocketchat | Rocket.Chat 未授权接口与 RCE 场景（3.12.1） |
| rocketmq | Apache RocketMQ 未授权管理与 RCE 演示（5.1.0） |
| rsync | rsync 未授权文件写入与 RCE 演示（2.6.9/3.1.2） |
| ruby | Ruby 解释器漏洞与 Gem 注入场景（2.4.1） |
| saltstack | SaltStack 未授权执行漏洞（2019.2.3/3002） |
| samba | Samba 未授权文件共享与命令执行场景（4.6.3） |
| scrapy | Scrapy 远程配置注入与命令执行演示 |
| shiro | Apache Shiro 反序列化漏洞演示（1.0.0/1.2.4/1.5.1） |
| showdoc | ShowDoc 文档系统 RCE 漏洞（2.8.2/3.2.4） |
| skywalking | Apache SkyWalking OAP/Web 服务未授权与 RCE 演示（8.3.0） |
| solr | Apache Solr SSRF 与 RCE 漏洞（7.x–8.x 多版本） |
| spark | Apache Spark RCE 与作业提交未授权场景（2.3.1） |
| spring | Spring 各组件反序列化／Spring4Shell／配置注入（多模块多版本） |
| struts2 | Apache Struts2 OGNL 注入与文件上传漏洞（2.3.x–2.5.x showcase） |
| superset | Apache Superset SQL 注入与 RCE 场景 |
| supervisor | Supervisor 远程命令执行与配置注入演示 |
| teamcity | JetBrains TeamCity 未授权接口与 RCE 演示 |
| thinkphp | ThinkPHP 远程代码执行与参数注入（5.x 系列） |
| tikiwiki | TikiWiki 任意文件上传与 RCE 漏洞演示 |
| tomcat | Apache Tomcat RCE、文件包含与信息泄露漏洞多版本演示 |
| unomi | Apache Unomi SSRF 与 RCE 漏洞场景 |
| uwsgi | uWSGI 未授权接口与 RCE 演示 |
| v2board | V2Board 面板任意文件写入与 RCE 漏洞环境 |
| vite | Vite 配置注入与依赖劫持场景 |
| weblogic | Oracle WebLogic RCE／WLS 漏洞演示（多版本） |
| webmin | Webmin 任意用户创建与命令执行漏洞 |
| wordpress | WordPress 上传绕过、SQL 注入与 RCE 漏洞（多插件多版本） |
| xstream | XStream 反序列化漏洞演示 |
| xxl-job | XXL-Job 任务调度平台 RCE 漏洞复现 |
| yapi | YAPI 接口管理平台 SSRF 与 RCE 场景 |
| zabbix | Zabbix 未授权 API 与命令执行漏洞 |

## 4. 常见问题

### 4.1 环境问题

构建失败：
> 检查网络连接
>
> 更新 Docker 镜像
>
> 清理 Docker 缓存

启动错误：
> 检查端口占用
>
> 验证配置文件
>
> 查看错误日志

### 4.2 漏洞复现问题

环境无法访问：
> 确认容器状态
>
> 检查端口映射
>
> 验证网络配置

漏洞利用失败：
> 确认环境版本
>
> 检查利用条件
>
> 调整攻击参数

## 5. 安全提示

### 5.1 环境安全

隔离措施：
> 使用独立网络
>
> 限制端口访问
>
> 及时关闭环境

### 5.2 使用建议

合规使用：
> 仅用于学习研究
>
> 不要对外网开放
>
> 遵守相关法律

数据保护：
> 不使用敏感数据
>
> 定期清理环境
>
> 备份重要文件 