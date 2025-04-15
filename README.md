# CTF-Web 修炼手册

[![Material for MkDocs](https://img.shields.io/badge/Material%20for%20MkDocs-9.5.0-blue.svg)](https://squidfunk.github.io/mkdocs-material/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

一个专注于 Web 安全与 CTF 学习的知识库，包含 SQL 注入、环境配置等实战经验分享。

## 📚 目录结构

- [环境配置](./md_docs/ENV-1-Mysql安装.md)
  - MySQL 安装与配置
  - SQL-Hackbar 安装与使用
- [SQL 注入技巧](./md_docs/SQL-1-Mysql系统表.md)
  - MySQL 系统表详解
  - 注入中的关键词解析
  - information_schema 利用
  - 普通注入实战
  - Bool 盲注思路
  - Bool 盲注逻辑参考
- [学习资源](./md_docs/网络安全与算法学习平台推荐.md)
  - 优质学习平台推荐

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

欢迎提交 Issue 和 Pull Request 来帮助改进这个项目。

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件
