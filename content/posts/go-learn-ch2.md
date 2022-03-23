---
title: "Go程序设计语言-第二章"
date: 2022-03-24T00:14:34+08:00
draft: false
summary: "Go程序设计语言 第二章总结"
toc: true
categories: ["Golang"]
tags: ["Golang"]
series: ["Golang学习笔记"]
---

## Go中的关键字

```golang
package main

func main() {
	// Go中的命名规则是开头必须是一个字母(Unicode中的字符即可)或下划线,不能以数字开头。
	// 后面可以跟任意数量的字符、数字和下划线, 并区分大小写, 比如heapSort和HeapSort
	/*  break   default	func	interface	select
		case 	defer	go	map	struct
		chan    else	goto	package	switch
		const	fallthrough	if	range	type
		continue	for	import	return	var*/
}
```

## Go中的类型、函数和命名风格

```golang
// Go中的预声明的常量、类型和函数
	/*
		常量: true false iota nil
		类型: int int8 int16 int32 int64
		uint uint8 uint16 uint32 uint64 uintptr
		float32 float64 complex128 complex64
		bool byte rune string error
		函数:
		make len cap new append copy close delete
		complex real imag 这是复数的一些函数
		panic recover
	*/

	// 命名风格
	// 函数命名为驼峰式 htmlEscape HTMLEscape escapeHTML 不会是escapeHtml
```