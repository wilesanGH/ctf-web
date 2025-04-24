# CTF-Web 修炼手册

[![Material for MkDocs](https://img.shields.io/badge/Material%20for%20MkDocs-9.5.0-blue.svg)](https://squidfunk.github.io/mkdocs-material/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

一个专注于 Web 安全与 CTF 学习的知识库，包含 SQL 注入、Web 漏洞基础、环境配置等实战经验分享。

## 📚 目录结构

### 环境配置
- MySQL 安装与配置
- SQL-Hackbar 安装与使用
- 图床配置-腾讯云COS+PicGo
- 靶场环境搭建
  - DVWA 环境搭建
  - bWAPP 靶场搭建
  - Vulhub 靶场搭建
  - Pikachu 靶场搭建
  - WebGoat 靶场搭建
  - SQLi-labs docker 安装

### SQL 注入系列
- MySQL 系统表说明
- SQL 注入中的关键词
- 普通注入实战
- Bool 盲注原理
- Bool 盲注过程
- Bool 盲注语句参考
- SQL 注入完整攻击流程图
- 如何判断 SQL 注入点
- SQL 注入漏洞判断与类型分析
- 基础 SQL 注入语句大全
- MySQL 新手必备关键词手册

### Web 安全基础
- Web 安全漏洞分类全景图
- 常见 Web 漏洞类型详解
- HTTP 状态码详解
- HTTP 请求与响应样例

### 学习资源
- 网络安全与算法学习平台推荐

## 🚀 快速开始

1. 克隆仓库
```bash
git clone https://github.com/wilesanGH/ctf-web.git
cd ctf-web
```

2. 安装依赖
```bash
pip install -r requirements.txt
```

3. 本地预览
```bash
mkdocs serve
```

4. 构建静态站点
```bash
mkdocs build
```

## 🛠️ 技术栈

- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) - 现代化的文档站点生成器
- [Python](https://www.python.org/) - 后端语言
- [Markdown](https://www.markdownguide.org/) - 文档编写语言

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来帮助改进这个项目。在提交之前，请确保：

1. 代码风格符合项目规范
2. 文档更新完整
3. 测试用例覆盖充分

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件
