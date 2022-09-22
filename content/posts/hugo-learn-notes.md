---
title: "Hugo命令备忘录"
date: 2022-09-23T00:57:37+08:00
draft: false
summary: "记录一下Hugo的常用命令"
toc: true
categories: ["Hugo"]
tags: ["Hugo"]
series: ["Hugo使用笔记"]
---

## 前言

很久没有更新博客了，一方面是发生了很多事情，很忙也很累，另一方面是自己太懒了。不得不说编码这种事情，如果长时间不做，就很容易忘记相关的命令。因此，写博客或者记笔记对于学习来说是很有必要的，好记性不如烂笔头嘛。

## Hugo安装

Hugo的安装很简单，这里可以参考我之前的博客。

[Hugo安装以及版本升级方法](/posts/hugo-update-note/)

## 创建站点

```bash
# 在当前站点文件根目录执行
hugo new site my_blog
```

## 设置主题

这里可以参考我之前的博客，设置meme主题。

[Git Submodule使用记录](/posts/git-submodule-note)

> 需要在config.toml文件中修改theme为指定的主题。

## 添加文章

```bash
# 在当前站点文件根目录执行
hugo new posts/my-first-post.md
```

## 启动服务器预览


```bash
# -D 表示显示草稿文章
hugo server -D
```

## 构建静态页面

```bash
# 默认生成到./public目录下，-d或--destination可以指定生成路径，也可以在配置文件中配置publishDir指定。
hugo -D
```

## 自动构建部署脚本

这里我提供一下我自己写的自动构建脚本，可以一键编译，添加CNAME，发布到github仓库。

```shell

#!/bin/bash
# source can be used with chmod u+x deploy.sh && ./deploy.sh
# if token expired, use gh auth login
source ~/.proxyrc
echo "using vpn through $http_proxy"

sleep 1s

ROOT_HOME="${HOME}/go/src/blog/"
DOMAIN_NAME="yeahqing.cn"

cd ${ROOT_HOME}


if [ ! -d docs ]; then
    echo "error: docs not found!"
else
    rm -r docs
    echo "clean successfully"
fi

hugo --theme=meme --baseUrl="https://yeahqing.cn/"

CNAME_FILE_PATH="docs/CNAME"
touch ${CNAME_FILE_PATH}
echo ${DOMAIN_NAME} > ${CNAME_FILE_PATH}

echo "generate CNAME done"

git add .

git status

sleep 1s

MSG="auto commit at "$(date "+%Y-%m-%d %H:%M:%S")


if  [ ! "$1" ]; then
    git commit -m "${MSG}"
    echo ${MSG}
else
    git commit -m "$1"
    echo "commit with msg $1"
fi

sleep 1s
git push origin hugo


```

## 参考

[Hugo官方仓库](https://github.com/gohugoio/hugo)