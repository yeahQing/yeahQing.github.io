---
title: "Go程序设计语言-第一章"
date: 2022-03-23T23:54:58+08:00
draft: false
summary: "Go程序设计语言 第一章总结"
toc: true
categories: ["Golang"]
tags: ["Golang"]
series: ["Golang学习笔记"]
---

## 第一个Go程序

```golang
package main

import "fmt"

func main() {
    fmt.Println("Hello World!")
}


```

## 获取命令行参数

### 版本1

```golang
package main

import (
	"fmt"
	"os"
)

func main() {
	var s, sep string // 隐式初始化为string类型的空值即""
	for i := 1; i < len(os.Args); i++ {
		s += sep + os.Args[i]
		sep = " "
	}

	if s[len(s)-1:] == " " {
		fmt.Println("true")
	} else {
		fmt.Println(s[len(s)-1:])
	}

	fmt.Println(s)
}
```

### 版本2

```golang
package main

import (
	"fmt"
	"os"
)

func main() {
	s, sep := "", ""
	for _, arg := range os.Args[1:] {
		s += sep + arg
		sep = " "
	}
	fmt.Println(s)
}
```

### 版本3

```golang
package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	fmt.Println(os.Args[:1])
	res := strings.Split(os.Args[0], "/")
	fmt.Println(strings.Join(res[len(res)-1:], ""))

	fmt.Println(strings.Join(os.Args[1:], " "))

	for index, arg := range os.Args {
		fmt.Println("index=", index, "arg=", arg)
	}

}

```

## 标准输入

```golang
package main

import (
	"bufio" // 处理输入和输出
	"fmt"
	"os"
)

func main() {
	counts := make(map[string]int)
	// 定义一个bufio.Scanner类型的变量
	input := bufio.NewScanner(os.Stdin)
	// 获取标准输入流
	// input.Scan()在读到新行的时候返回true, 没有内容返回false
	// 没有内容是指EOF -> ctrl+D
	for input.Scan() {
		// input.Text()获取input.Scan()读取到的内容(去掉换行符)
		// if input.Text() == "q" {
		// 	break
		// }
		/*
			下面的代码等价于:
			line := input.Text()
			counts[line] = counts[line] + 1
		*/
		counts[input.Text()]++
	}
	// 遍历map哈希表 line: 获取到的一行字符串 n: 出现的次数
	// map中的键的迭代顺序是随机的
	for line, n := range counts {
		if n > 1 {
			// 格式化输出
			fmt.Printf("%d\t%s\n", n, line)
		}
	}
}
```

## 格式化输出

```golang
package main

import "fmt"

// 总结一部分常用的格式化输出用到的转义字符
func main() {
	a := 13
	fmt.Printf("a = %d\n", a) //十进制: 13
	fmt.Printf("a = %x\n", a) //十六进制 d
	// 001 101 = 15(八进制)
	fmt.Printf("a = %o\n", a) // 八进制 15
	fmt.Printf("a = %b\n", a) // 二进制 1101
	pi := 3.1415926
	fmt.Printf("pi = %f\n", pi) // 保留到小数点后面6位
	fmt.Printf("pi = %g\n", pi) // 位数更多?
	fmt.Printf("pi = %e\n", pi) // 科学计数法
	b := true
	fmt.Printf("b = %t\n", b)
	c := 'a'                  // A = 65 a= 97
	fmt.Printf("c = %d\n", c) // Unicode的码点的小写字母也是97
	s := "this is a string"
	fmt.Printf("s = %s\n", s)
	q := "this is a string with quote" // 带引号的字符串或字符
	fmt.Printf("q = %q\n", q)
	v := 23.2 + 2i                          // 内置格式的任何值, 竟然能直接输出复数
	fmt.Printf("v = %v, v的类型是: %T\n", v, v) // 内置复数类型complex
	fmt.Printf("%% \\ \" ' ; 是百分号\n")
}
```