# AGENTS.md — ctf-web 仓库维护指南(供 AI 助手/新 session)

> 本仓库 = 《CTF-Web修炼手册》静态站(MkDocs Material)+ 学术征稿页(外部管线托管)。
> 线上:https://wilesangh.github.io/ctf-web/ (GitHub Pages,源 = main 分支 `/docs` 目录)

## 一、目录结构与铁律

| 路径 | 是什么 | 规则 |
|---|---|---|
| `md_docs/` | **站点源码**(Markdown) | ✅ 改内容改这里 |
| `docs/` | **mkdocs 构建产物**(HTML) | ❌ **绝不手改**——`mkdocs build` 会整体重生成,手改必丢 |
| `md_docs/cfp/` | 学术征稿页(总表/安全手册) | ❌ **不要手改**——由外部管线覆盖(见 §四) |
| `mkdocs.yml` | 站点配置 + nav 导航 | 新增页面须在 `nav:` 登记,否则不进侧边栏 |
| `txt_docs/`、`.spec-workflow/` | 工作区杂项 | 与站点无关,勿动勿提交 |

## 二、标准工作流(改内容/加页面)

```bash
# 1. 编辑/新增 md_docs/ 下的 .md(中文文件名是本仓库惯例)
# 2. 新页面在 mkdocs.yml 的 nav: 里登记
mkdocs build          # 源 md_docs/ → 产物 docs/(会清理旧产物)
mkdocs serve          # 本地预览 http://127.0.0.1:8000(可选)
git add md_docs docs mkdocs.yml
git commit -m "docs: <改了什么>"
git push origin main  # Pages 自动重新部署,约 1 分钟生效
```

- 环境:本机已装 `mkdocs 1.6.1` + `mkdocs-material`(homebrew python3.13)。
- 主题:Material,中文,indigo;插件含 git-revision-date-localized(新文件无 git 记录时警告可忽略)。

## 三、推送凭据(重要坑)

本机环境变量里有 `GITHUB_TOKEN`(账号 paper-support,**无本仓库写权限**),会抢凭据导致 push 403。
本仓库已配**仓库级** credential helper 绕开它(清空继承链 + 走 wilesanGH keyring):

```bash
git config --get-all credential.helper
#  (空行)
#  !env -u GITHUB_TOKEN gh auth git-credential
```

若 push 再报 `denied to paper-support`,重新执行:

```bash
git config --unset-all credential.helper
git config --add credential.helper ''
git config --add credential.helper '!env -u GITHUB_TOKEN gh auth git-credential'
```

## 四、学术征稿页(cfp/)— 外部托管,本仓库只读

- `md_docs/cfp/index.md`(在征征稿总表)与 `md_docs/cfp/security.md`(安全投稿手册)由
  **另一个仓库** `/Users/ss/Documents/SCIE征稿-公众号` 的管线生成并覆盖:
  `python3 tools/build_master_table.py && bash tools/publish_pages.sh`(月更,含 build+push 本仓库)。
- 需要改这两页内容 → 去 SCIE 仓库改数据/脚本,**不要在本仓库改**(下次月更即被覆盖)。
- 这两页的**线上链接被公众号关键词回复引用,URL 不可变**:
  - `https://wilesangh.github.io/ctf-web/cfp/`
  - `https://wilesangh.github.io/ctf-web/cfp/security/`
  → 不要重命名/移动 `cfp/` 目录与文件,不要从 `mkdocs.yml` nav 删「学术征稿」分组。

## 五、写作约定

- 站点主体是 CTF/Web 安全学习笔记:工具手册、漏洞原理、靶场搭建;文件名用中文、一文一主题。
- Markdown 注意:**中文夹注的粗体**(`汉字**词**汉字`)python-markdown 渲染失败会出裸星号——
  粗体两侧留空格/标点,或不用粗体。
- 宽表格:Material 自动横向滚动,但重要列(如链接)放前几列,避免被视口截断。
