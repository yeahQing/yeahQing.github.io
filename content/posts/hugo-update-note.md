---
title: "Hugo安装以及版本升级方法"
date: 2022-04-27T22:41:58+08:00
draft: false
summary: "Hugo安装以及版本升级方法"
toc: true
categories: ["Hugo"]
tags: ["Hugo"]
series: ["Hugo使用笔记"]
---

## 前言

我之前安装Hugo的时候, 因为安装简单且各种操作命令也很好记, 就没有记录笔记。但是有一段时间没有使用后, 还是忘记了很多, 因此这里还是简单记录一下Hugo的安装同时也是升级的方法吧, 我觉得比起Hexo容易得多。

## 依赖

Hugo依赖Go, 因此如果没有安装Go的环境, 需要先安装Go.

## 安装Hugo(更新同理)

## 注意

Hugo在v0.103.0更新了文件命名方式, 现在全部都以GOOS/GOARCH为准，也就是GO环境配置里OS和ARCH是什么就是什么, 比如64位就是amd64, Linux就是linux。为了兼容，新版本还存在部分之前的命名方式的文件, 这里我们最好选择新的命名方式命名的文件，比如hugo_0.103.1_linux-amd64.tar.gz，而不是hugo_0.103.1_Linux-64bit.tar.gz
。


### 二进制方法

我们可以在[HugoGithub仓库](https://github.com/gohugoio/hugo)中看到详细的安装说明。我之前安装使用的是二进制文件的安装方式, 就是直接下载编译好的对应平台的二进制文件, 并将其移动到go的bin目录下即可。我的目录是`/home/yeahqing/go/bin`, 具体需要根据大家的设置来。

```shell

# 下载二进制压缩包, 这里选择对应版本的就可以
wget https://github.com/gohugoio/hugo/releases/download/v0.103.1/hugo_0.103.1_linux-amd64.tar.gz

# 解压缩部分文件到指定目录下，这里我们只将压缩包里的hugo解压缩到go/bin目录下
tar -zxvf hugo_0.103.1_linux-amd64.tar.gz -C go/bin hugo

# 验证安装是否成功
hugo version

# output
# hugo v0.103.1-b665f1e8f16bf043b9d3c087a60866159d71b48d linux/amd64 BuildDate=2022-09-18T13:19:01Z VendorInfo=gohugoio
```

> 如果主题需要使用scss的话, 就下载extended版本的, 如果不需要就下载普通版本

### 编译源码

这里我是直接照着hugo官方提供的方法来的。这里可能存在git clone超时的问题, 我们可以下载压缩包或者使用clash进行翻墙, 然后下载。

记录一个wsl2使用clash的方法。

1. 启动cfw的Allow LAN选项。
2. 在`$HOME`下创建`.proxyrc`文件
3. 使用`source .proxyrc`激活环境变量
4. 可选: 如果不能翻墙, 可能是防火墙没有完全对cfw开放, 需要检查你的网络是专用还是公用, 然后将对应防火墙取消拦截

`.proxyrc`文件内容:
```bash
#!/bin/bash

export hostip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
export port=7890

export https_proxy="http://${hostip}:${port}"
export http_proxy="http://${hostip}:${port}"

```

配置好翻墙代理后，我们就可以从github上clone仓库。

```bash
mkdir $HOME/src
cd $HOME/src
git clone https://github.com/gohugoio/hugo.git
cd hugo
go install
```


go install完成后, 就会在`/home/yeahqing/go/bin`下生成`hugo`的二进制文件。之后我们就可以删除克隆的hugo目录了。

> 如果需要使用scss, 则在编译时, 需要使用`CGO_ENABLED=1 go install --tags extended`这个命令替换`go install`

## 检测是否安装成功

我们可以使用`hugo version`检测hugo版本是否安装成功

```bash
hugo v0.103.1-b665f1e8f16bf043b9d3c087a60866159d71b48d linux/amd64 BuildDate=2022-09-18T13:19:01Z VendorInfo=gohugoio
```

## 参考

[Hugo官方仓库](https://github.com/gohugoio/hugo)

