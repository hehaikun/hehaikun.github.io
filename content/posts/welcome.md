---
title: "欢迎使用 Hugo 博客"
date: 2026-03-28
draft: false
tags: ["Hugo", "博客", "GitHub Pages"]
categories: ["入门教程"]
---

# 欢迎使用 Hugo 博客

这是我使用 Hugo 构建的第一篇博客文章！

## 什么是 Hugo？

Hugo 是一个快速、现代化的静态网站生成器，使用 Go 语言编写。它具有以下特点：

- **构建速度快**：构建大型站点只需要几秒钟
- **易于使用**：配置简单，使用 Markdown 编写内容
- **主题丰富**：有很多现成的主题可以选择
- **免费部署**：可以轻松部署到 GitHub Pages

## 如何开始使用？

### 1. 创建新文章

在 `content/posts/` 目录下创建新的 Markdown 文件：

```bash
hugo new posts/your-article.md
```

### 2. 本地预览

在项目根目录运行：

```bash
hugo server -D
```

然后在浏览器中打开 `http://localhost:1313`

### 3. 构建静态网站

运行：

```bash
hugo
```

生成的静态文件将在 `public/` 目录中。

### 4. 部署到 GitHub Pages

将代码推送到 GitHub 仓库，配置好 GitHub Actions 自动部署即可！

## 下一步

开始编写你的第一篇文章吧！