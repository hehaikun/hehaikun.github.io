# 🚀 快速开始指南

你的 Hugo 博客已经准备好了！按照以下步骤快速部署到 GitHub Pages。

## 📋 步骤 1: 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 仓库名称格式：`your-username.github.io`（用于个人站点）
3. 选择 Public（免费）
4. 点击 "Create repository"

## 🔗 步骤 2: 连接到你的仓库

**注意：请先重启终端，让 Hugo 命令生效**

```bash
# 添加远程仓库（替换成你的仓库地址）
git remote add origin https://github.com/your-username/your-repo.git

# 重命名分支为 main
git branch -M main

# 推送到 GitHub
git push -u origin main
```

## ⚙️ 步骤 3: 配置网站信息

1. 编辑 `config.toml` 文件，修改以下内容：

```toml
baseURL = "https://your-username.github.io/"  # 改成你的 URL
title = "我的技术博客"                          # 改成你的标题

[params]
  author = "你的名字"                           # 改成你的名字
  description = "分享技术与思考"                 # 改成你的描述
  github = "your-username"                     # 改成你的 GitHub 用户名
```

2. 提交更改：

```bash
git add config.toml
git commit -m "Update config"
git push
```

## 🌐 步骤 4: 启用 GitHub Pages

1. 访问你的 GitHub 仓库
2. 点击 **Settings** → **Pages**
3. 在 **Build and deployment** 部分：
   - Source: 选择 **GitHub Actions**
   - （会自动使用我们配置的 workflow）

## ✅ 步骤 5: 等待部署

- 代码推送后，GitHub Actions 会自动开始构建
- 等待约 1-2 分钟，构建完成后会自动部署
- 访问：`https://your-username.github.io/`

## 🎨 步骤 6: 本地预览（可选）

重启终端后，运行：

```bash
hugo server -D
```

然后在浏览器打开：http://localhost:1313

## ✍️ 步骤 7: 创建新文章

```bash
# 创建新文章
hugo new posts/my-first-post.md

# 编辑文章（在 content/posts/my-first-post.md）

# 提交并推送
git add .
git commit -m "Add new post"
git push
```

## 📱 常用命令

```bash
# 创建新文章
hugo new posts/article-title.md

# 本地预览（包含草稿）
hugo server -D

# 本地预览（不包含草稿）
hugo server

# 构建静态网站
hugo

# 构建并压缩
hugo --minify
```

## 🛠️ 自定义主题

所有主题文件都在 `themes/digital-garden/` 目录下：

- `layouts/` - 页面模板
- `static/` - 静态资源（CSS、JS、图片）
- `archetypes/` - 文章模板

## ❓ 常见问题

### Hugo 命令找不到？
**重启终端**，让环境变量生效。

### GitHub Actions 部署失败？
1. 检查仓库的 Settings → Pages 是否启用了 GitHub Actions
2. 检查 `config.toml` 中的 `baseURL` 是否正确
3. 查看 GitHub Actions 日志获取详细错误信息

### 如何修改主题颜色？
编辑 `themes/digital-garden/layouts/index.html` 中的 CSS 部分，找到颜色代码并修改。

## 📞 需要帮助？

- 查看完整的 README.md 文档
- 访问 Hugo 官方文档：https://gohugo.io/documentation/
- 在 GitHub 上提 Issue

---

祝你博客写作愉快！ 🎉