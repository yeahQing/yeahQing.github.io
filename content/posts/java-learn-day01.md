---
title: "Java学习记录01"
date: 2023-05-13T21:04:22+08:00
draft: false
summary: "记录学习java中害怕遗忘的知识点"
toc: true
categories: ["Java"]
tags: ["Java", "Static关键字", "在终端编译java"]
series: ["Java学习笔记"]
---

## 前言

最近又重新学习了一下java相关的知识，因为工作从golang又迁移到了java。今天主要看了一下java的静态变量和静态方法，说实话，静态的东西理解起来还是比较轻松的，因为每一种语言都比较相似。之后，发现IDEA快要到期了，又趁着学生机会续了一年教育包，但是害怕以后习惯IDEA离不开，现在都慢慢用vscode开发，想看看使用vscode能不能代替IDEA，不得不说vscode还是比较简陋的，虽然说该有的都有吧，但是比起IDEA还是差点意思。最后，我还重温了一下在终端编译java代码，虽然没啥用就是了。下面将分别介绍这几个方面。

## 静态变量和静态方法

使用`static`修饰的变量或者方法就可以叫做静态变量或者静态方法，叫这个名字的原因是因为这种变量和方法在使用的时候不需要实例化对象，而是直接使用类名就可以调用，是类实例共享的内存。具体的用法如下。

```java

package com.yq.main;

public class StaticModule {
    public static void main(String[] args) {
        System.out.println(StaticFiled.number);
        StaticFiled.addNumber(1);
        System.out.println(StaticFiled.number);
    }
}

class StaticFiled {
    static int number = 0;  // 静态变量
    static void addNumber(int i) {  // 静态方法
        number += i;
    }
}


```

## 使用vscode新建java项目

在vscode中新建一个java项目需要安装对应的java插件

这里如果默认新建一个窗口然后新建一个`.java`后缀的文件的话，就会默认提示安装对应的java相关的插件包`Extension Pack for Java`。如下图所示。

![vscode中的java插件包](https://cdn.jsdelivr.net/gh/yeahqing/ImgStg@latest/images/202305132145612.png)

如果是第一次使用vscode创建java项目，则可以使用`ctrl+shift+P`呼出命令面板，然后输入`>java: Tips for Beginners`使用这样的方式就可以出现一个1分钟熟悉vscode新建java代码的新手教程。

如果想要创建一个java项目，则使用同样的命令呼出命令面板，然后输入`>java: Create Java Project`就可以弹出几种不同的创建Java项目的方式，这里新手可以直接创建一个不需要构建工具的项目，等熟练了之后再使用maven或者gradle来构建项目，或者使用springboot、springcloud这些框架。

## 在终端编译java

在终端编译java虽然不常用，但是对于一开始学习java的人来说，可以了解java的编译逻辑。首先在需要编译的文件的目录下使用javac [需要编译的文件名].java，注意哦，这里文件名必须要和public声明的类名一致才行，不然编译是不会通过的。

之后会在同一个目录下生成一个.class文件，这里需要注意的是，如果这个类文件指定了包名，那么需要到src目录下，再使用`java`命令运行这个文件，且此时还需要加上包名，例如`com.yq.main.Test`。

```bash

# 此处需要在源代码所在目录下运行
javac Test.java # 编译源代码文件为字节码文件
 
# 此处需要在src目录下运行
java com.yq.main.Test # 执行字节码文件

```

## 参考

[在 VSCode 里写Java 项目（持续更新）](https://blog.csdn.net/qq_42520962/article/details/120488403)