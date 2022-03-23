---
title: "安装说明-Mysql_8.0.28"
date: 2022-03-23T22:34:16+08:00
draft: false
summary: "WSL2中Ubuntu20.04安装Mysql8.0.28记录"
toc: true
categories: ["Mysql"]
tags: ["Mysql"]
series: ["Mysql学习笔记"]
---

## 环境

Ubuntu20.04 WSL2

## 安装mysql8.0.28

```shell
sudo apt install mysql-server mysql-client
```

## 配置mysql

默认使用`sudo mysql`会遇到以下错误


```shell
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
```

mysqld - it's a server daemon mysqld表示mysql的服务器守护进程，这个服务必须要启动，客户端才能连接mysql数据库。

这是因为我们没有在配置文件中启动这个mysqld.sock。

我们到`cd /etc/mysql/mysql.conf.d`目录下，打开mysqld.cnf。我们把下面Basic Settings下的带注释的几行取消注释即可。pid-file、socket、port、datadir。

```shell
[mysqld]
#
# * Basic Settings
#
user            = mysql
# pid-file        = /var/run/mysqld/mysqld.pid 
# socket  = /var/run/mysqld/mysqld.sock
# port            = 3306
# datadir = /var/lib/mysql
```

## 启动时警告

```shell
su: warning: cannot change directory to /nonexistent: No such file or directory
```

这个错误是由于mysql异常关闭导致的，我们使用如下方法修复。

```shell
sudo service mysql stop
sudo usermod -d /var/lib/mysql/ mysql
sudo service mysql start

```

## 启动mysql

```shell
sudo service mysql start
```
## 其他操作

```shell
sudo service mysql restart  # 重启
sudo service mysql stop # 停止
sudo service mysql status # 状态
```

## 客户端连接

如果没有设置的话，直接mysql就进去了。
如果进不去的话，ubuntu的默认用户名和密码是在/etc/mysql的debian.cnf下自动生成的。
使用它给的用户名和密码即可登录进去。

```shell
mysql -uroot -p
```

## 创建用户并授权

```mysql
# 使用mysql数据库
use mysql;

# 创建用户
create USER 'username'@'localhost' IDENTIFIED BY 'password';

# 授权所有权限和授权权限给这个用户
grant ALL on *.* to 'username'@'localhost' with grant option;

# 查询创建的用户和其权限
select * from user where User = 'username' \G


```


## 参考

[mysql安装](https://juejin.cn/post/6961800061210591268)