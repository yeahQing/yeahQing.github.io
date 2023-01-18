---
title: "Linux命令汇总"
date: 2023-01-18T18:04:53+08:00
draft: false
summary: "Linux常用命令汇总"
toc: true
categories: ["Linux"]
tags: ["Linux"]
series: ["Linux"]
---

## 前言

最近在训练模型的时候，发现自己对linux命令只停留在几个基础命令上，很多命令都是先用先查，因此，这里把自己容易忘记的命令和用法做一个记录。

## 查看文件以及文件夹个数

1. 查看当前目录下的文件个数

```shell
ls -l | grep -c "^-"
```

2. 查看当前目录下文件夹个数

```shell
ls -l | grep -c "^d"
```

其实可以从上面两个命令中找到规律，这里就是使用grep命令通过正则表达式来统计文件或者文件夹的个数。

3. 查看当前目录以及其子目录下的文件夹个数

```shell
ls -lR | grep -c "^d"
```

4. 查看当前目录下文件和文件夹的个数

```shell
ls | wc -l
```

这里wc命令统计的就是ls出来的内容的数量，wc也可以统计文件的行数。

5. 直接使用tree命令即可

```shell
> tree
.
├── a.txt
├── b.txt
├── c.txt
├── test_1
│   └── test_3
└── test_2

3 directories, 3 files
```

## 参考

[Linux统计文件夹中文件个数以及目录个数](https://blog.csdn.net/flyingluohaipeng/article/details/128427498?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EAD_ESQUERY%7Eyljh-1-128427498-blog-6445778.pc_relevant_3mothn_strategy_and_data_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EAD_ESQUERY%7Eyljh-1-128427498-blog-6445778.pc_relevant_3mothn_strategy_and_data_recovery&utm_relevant_index=2)