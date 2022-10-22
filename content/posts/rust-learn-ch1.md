---
title: "Rust Learn Ch1"
date: 2022-10-22T10:27:32+08:00
draft: true
summary: "这是摘要"
toc: true
categories: ["Rust"]
tags: ["Rust"]
series: ["Rust学习笔记"]
---

## 前言

最近对于空指针变得越来越难以忍受，于是想到了Rust，类型安全，没有空指针，零成本抽象等等优势，所以来学习一下。

## Rust的安装(rustup)

### 1. Windows

在[官方网站]("https://www.rust-lang.org/tools/install")下载`rustup`包管理工具，然后通过提示就可以了。此外还可以自定义命令行工具的位置，只需要修改环境变量就可以啦。

### 2. Linux/Mac/Wsl

可以直接通过终端下载。

```shell
$ curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh
```

Mac可能需要安装一个C编译器(不是自带了clang吗?好奇怪,我没有mac，等我有了试试看)

```shell
$ xcode-select --install
```


### 3. 是否安装成功

- 看到`Rust is installed now. Great!`
- rustup --version
- rustc -- version

> 这里我们需要重启终端

### 4. 更新和卸载(可选)

我们可以使用rustup工具快捷进行更新和卸载。

更新rust

```shell
$ rustup update
```

删除rust

```shell
$ rustup self uninstall
```





## 参考
[Why developers love rust]("https://ibraheem.ca/posts/why-devs-love-rust/")