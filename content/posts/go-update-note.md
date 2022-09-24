---
title: "Golang版本升级记录"
date: 2022-04-27T21:34:34+08:00
draft: false
summary: "将Golang从1.18升级到1.18.1, 并记录Golang的版本升级方法。"
toc: true
categories: ["Golang"]
tags: ["Golang"]
series: ["Golang学习笔记"]
---

## 前言

最近Golang发布了1.18.1的版本更新, 我突然想到我自从学习Golang开始, 还没有学习过如何升级版本。因此, 这里记录一下我从Golang1.18升级到1.18.1的过程, 便于以后使用。不得不说Golang的版本升级真的好简单。

## 环境和依赖

- Ubuntu20.04

## 第一步: 下载新的Golang版本

我们可以在[Golang官网](https://go.dev/dl/)下载对应操作系统的安装包

这里我们下载的是Linux版本的安装包, 压缩格式是tar.gz

![Golang Version](https://cdn.jsdelivr.net/gh/yeahqing/ImgStg@latest/images/20220924182104.png)

这里我们使用wget工具下载安装包。`wget https://go.dev/dl/go1.18.1.linux-amd64.tar.gz`

## 第二步: 备份旧版本(可选)

为了以防意外, 我们可以将原来版本的golang备份。我的go安装在`/usr/local/go`目录下, 因此我们可以拷贝这个目录重命名为`go1.18.0`

```bash
cd /usr/local
sudo mv go go1.18.0
```

## 第三步: 解压压缩包到指定目录

将下载好的压缩包移动到/usr/local目录下,并解压缩。

```bash
sudo mv go1.18.1.linux-amd64.tar.gz /usr/local/
sudo tar zxvf go1.18.1.linux-amd64.tar.gz
```

解压缩完后, `/usr/local`目录下会出现go目录, 因此我们无需更改环境变量。

```bash
ls -l go
```

使用`go version`命令, 可以得到一下输出结果

```
go version go1.18.1 linux/amd64
```

至此我们就完成了golang的版本升级, 如果没有任何问题, 我们可以删除下载的压缩包后备份的旧版本目录, 以释放空间。

```
cd /usr/local
sudo rm go1.18.1.linux-amd64.tar.gz
sudo rm -r go1.18.0
```

## 参考

[掘金-快速升级Go版本](https://juejin.cn/post/6982858375423852558)