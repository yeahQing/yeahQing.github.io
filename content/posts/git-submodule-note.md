---
title: "Git Submodule使用记录"
date: 2022-03-23T21:25:23+08:00
draft: false
summary: "git submodule的添加、更新和删除"
toc: true
categories: ["Git"]
tags: ["Git"]
series: ["Git学习笔记"]
---

## 前言

在Hugo中, 当我们想更换或者添加一个主题时, 可能会涉及git Submodule这个命令。这个命令可以在当前我的git仓库下添加其他人的git仓库, 适用于我们项目依赖了其他人的项目的时候。这里我也是在搭建hugo博客时遇到了这个问题。

## Git Submodule的添加

```shell
# 这里借助meme这个主题说明submodule的使用 这里--depth 1表示只获取最近的一次commit
git submodule add --depth 1 https://github.com/reuixiy/hugo-theme-meme.git themes/meme

```

使用上述命令后, 第一次使用会生成一个.gitmodules的文件,里面记录了子模块的路径和git仓库地址

```toml
[submodule "themes/meme"]
	path = themes/meme
	url = https://github.com/reuixiy/hugo-theme-meme.git
```

## GitSubmodule的移除

### 移除子模块目录和源码

1. `cd themes`到包含子模块的目录。使用`rm -rf meme` 删除子模块目录及源码
2. `vim .gitmodules` 删除项目目录下`.gitmodules`文件中子模块相关条目
3. `vim .git/config` 删除配置项中子模块相关条目
4. `rm -r .git/module/meme` 删除模块下的子模块目录, 每个子模块对应一个目录

> 注意只删除对应的子模块目录即可

之后我们使用`git status`查看git的提交里有没有涉及子模块的文件,有的话就把缓存删掉。
这里可能会遇到删不掉的情况，使用`git rm -f --cached` 文件名删除。


## GitSubmodule的更新

使用下面这个命令更新子模块

```shell
git submodule update --rebase --remote
```

## 参考链接

[Hugo MeMe主题](https://github.com/reuixiy/hugo-theme-meme)