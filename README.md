# 我的 Hugo 博客

这是一个使用 Hugo 构建的静态博客，可以部署到 GitHub Pages。

## 特点

- 🚀 使用 Hugo 构建，速度快
- 🎨 现代化的设计风格
- 📱 响应式设计，支持移动端
- 🚀 自动部署到 GitHub Pages
- ✨ 支持标签和分类

## 本地开发

### 前置要求

- Hugo Extended 版本（需要重启终端后才能使用 `hugo` 命令）

### 安装 Hugo

如果你还没安装 Hugo，可以按照以下步骤安装：

#### Windows (已自动安装)
```bash
# Hugo 已经通过 winget 安装
# 重启终端后可以使用 hugo 命令
```

#### macOS
```bash
brew install hugo
```

#### Linux
```bash
sudo apt-get install hugo
```

### 本地预览

1. 重启终端（确保 Hugo 在 PATH 中）
2. 运行开发服务器：

```bash
hugo server -D
```

3. 在浏览器中打开：http://localhost:1313

### 创建新文章

```bash
hugo new posts/your-article.md
```

## 部署到 GitHub Pages

### 1. 创建 GitHub 仓库

在 GitHub 上创建一个新仓库，命名为 `your-username.github.io`（用于个人站点）或任何你喜欢的名称。

### 2. 初始化 Git 仓库

```bash
git init
git add .
git commit -m "Initial commit"
```

### 3. 推送到 GitHub

```bash
git remote add origin https://github.com/your-username/your-repo.git
git branch -M main
git push -u origin main
```

### 4. 启用 GitHub Pages

1. 进入仓库的 Settings → Pages
2. Source 选择 "GitHub Actions"
3. 推送代码后，GitHub Actions 会自动构建并部署你的网站

### 5. 访问你的网站

如果你的仓库名是 `your-username.github.io`：
- 访问：https://your-username.github.io

如果仓库名是其他名称：
- 访问：https://your-username.github.io/your-repo

## 自定义配置

### 修改网站信息

编辑 `config.toml` 文件：

```toml
baseURL = "https://yourusername.github.io/"
title = "我的技术博客"
theme = "digital-garden"
languageCode = "zh-CN"

[params]
  author = "你的名字"
  description = "分享技术与思考"
```

### 添加菜单

在 `config.toml` 中修改：

```toml
[menu]
  [[menu.main]]
    name = "首页"
    url = "/"
    weight = 1
  [[menu.main]]
    name = "文章"
    url = "/posts/"
    weight = 2
```

### 添加社交链接

在 `config.toml` 的 `[params]` 部分添加：

```toml
[params]
  github = "yourusername"
  twitter = "yourusername"
  linkedin = "yourusername"
```

## 写作指南

### 文章格式

在 `content/posts/` 目录下创建 Markdown 文件：

```markdown
---
title: "文章标题"
date: 2026-03-28
draft: false
tags: ["标签1", "标签2"]
categories: ["分类"]
---

这里是文章内容...
```

### 添加图片

将图片放到 `static/` 目录下，然后使用：

```markdown
![图片描述](/path/to/image.jpg)
```

## 文件结构

```
my-blog/
├── content/
│   ├── posts/          # 博客文章
│   └── about/          # 关于页面
├── static/             # 静态资源（图片、CSS 等）
├── themes/
│   └── digital-garden/ # 主题
├── config.toml         # 配置文件
├── .github/
│   └── workflows/
│       └── deploy.yml  # GitHub Actions 配置
└── README.md           # 说明文档
```

## 常用命令

```bash
# 创建新文章
hugo new posts/my-post.md

# 启动开发服务器（包含草稿）
hugo server -D

# 启动开发服务器（不包含草稿）
hugo server

# 构建静态网站
hugo

# 构建并压缩
hugo --minify
```

## 常见问题

### Hugo 命令找不到？

重启终端，让环境变量生效。

### GitHub Actions 部署失败？

1. 检查 GitHub Actions 日志
2. 确保 GitHub Pages 已启用
3. 检查 `config.toml` 中的 `baseURL` 是否正确

### 如何更换主题？

1. 删除或重命名 `themes/digital-garden` 目录
2. 添加新主题：`git submodule add https://github.com/theme-owner/theme-name themes/theme-name`
3. 在 `config.toml` 中修改 `theme` 配置

## 许可证

MIT License

## 联系方式

如有问题，请在 GitHub 上提 Issue。