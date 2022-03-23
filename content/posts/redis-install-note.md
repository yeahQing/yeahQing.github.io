---
title: "安装说明-Redis_6.2.6"
date: 2022-03-23T23:10:47+08:00
draft: false
summary: "WSL2-Ubuntu20.04安装Redis_6.2.6"
toc: true
categories: ["Redis"]
tags: ["Redis"]
series: ["Redis学习笔记"]
---

## 下载redis安装包 

我们从redis官网下载redis的压缩吧redis.tar.gz

我们使用wget下载, 
[redis官网](https://redis.io/)

``` bash
wget https://download.redis.io/releases/redis-6.2.6.tar.gz

```

之后使用解压缩命令解压缩.gz文件

```bash
tar -zxvf redis-6.2.6.tar.gz

rm redis-6.2.6.tar.gz

```

我们可以在解压完了之后直接删除压缩包

``` bash
# 我们可以将这个文件夹移动到/usr/local/redis下

mkdir /usr/local/redis # 具体按你的喜好就可以

cp redis-6.2.6 /usr/local/redis/

cd /usr/local/redis/redis-6.2.6

```

## 编译安装

在`/usr/local/redis/redis-6.2.6`这个目录下我们可以使用make命令进行安装，如果没有gcc和make的环境，可以先安装一下。

```bash
sudo apt install gcc make

```

我们使用make命令安装完之后，`make test`是可选项，如果想单元测试一下可以执行，不过需要安装tcl,
使用命令安装:
`sudo apt install tcl`

我们不需要进入src目录执行make install，直接根目录执行就行，具体可以在根目录下的Makefile中看到原因, 然后执行make install这个命令后，默认会把它的可执行二进制文件安装到`/usr/local/bin`下，这个具体是在src目录下的Makefile中定义的前缀变量PREFIX, 我们也可以在make install 命令后面指定PREFIX=[/path/to/your/dir/]

```Makefile
# Top level makefile, the real shit is at src/Makefile

default: all

.DEFAULT:
        cd src && $(MAKE) $@

install:
        cd src && $(MAKE) $@

.PHONY: install

```

可以看到根目录执行的make命令和make install命令，都是进入src目录执行的，其实和我们直接进入src目录执行一样。

## 配置运行

我们可以在根目录下找一个`redis.conf`文件，这个文件是启动redis-server的配置文件

```shell
ls -l | grep redis.conf

```

我们可以什么都不改，直接按默认配置来启动就可以

```shell
redis-server redis.conf

```
之后使用客户端测试启动是否正常, 看到PONG就是安装成功了

```shell
# 终端输入redis-cli就可以进入本地的客户端，或者指定-h 127.0.0.1 -p 6379
# 你也可以根据你的服务器来配置
redis-cli

127.0.0.1:6379> ping
PONG

```

我们使用`redis-cli shutdown`来关闭redis-server

同时，我们也可以使用kill命令给进程发送中断信号
-9和-15就是31个unix的不安全的信号值。

```shell
# -9是无条件中断
kill -9 [redis_pid]

# 一般用-15也可以
kill -15 [redis_pid]

```
## 配置后台启动

redis一般肯定是运行在服务器上的，总不能让它一直前台运行吧，感觉也可以?我每次都是开两个终端测试的，不过没有试过服务器的环境。

我们直接修改redis.conf文件就行，

```shell
# 使用vim打开redis.conf，然后在冒号模式/命令模式下使用斜杠`/daemonize`
# 可以在vim的命令模式下使用n和N进行下一个和上一个匹配的移动
# 修改这个键的值为yes即可

daemonize yes

```

查看是否配置后台启动成功

```shell
ps -aux | grep redis

```


## 使用service快捷启动

我们可以通过`sudo service redis start`来启动redis

首先我们进入redis的utils目录

```shell
cd /usr/local/redis/redis-6.2.6/utils

```

我们可以找到`init`两个文件

```shell
ls | grep redis_init_script

redis_init_script
redis_init_script.tpl

```
第一个文件中只有start和stop的shell脚本，第二个文件中有start、stop、restart、status的shell脚本，但是缺少了一些路径变量的定义，我们可以将这个两个文件结合一下，就是把自己需要的东西拼凑以下。

我这里贴一下我的配置，这里主要是要配置一下自己的路径，配置文件的路径也需要修改一下，改成自己的就行。**这里需要注意，我们最好使用sudo命令启动，不然pid没法生成在/var/run/下**。

```shell
#!/bin/sh
#
# Simple Redis init.d script conceived to work on Linux systems
# as it does use of the /proc filesystem.

### BEGIN INIT INFO
# Provides:     redis_6379
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    Redis data structure server
# Description:          Redis data structure server. See https://redis.io
### END INIT INFO

REDISPORT=6379
EXEC=/usr/local/bin/redis-server
CLIEXEC=/usr/local/bin/redis-cli

PIDFILE=/var/run/redis_${REDISPORT}.pid
CONF="/etc/redis/${REDISPORT}.conf"

case "$1" in
    start)
        if [ -f $PIDFILE ]
        then
            echo "$PIDFILE exists, process is already running or crashed"
        else
            echo "Starting Redis server..."
            $EXEC $CONF
        fi
        ;;
    stop)
        if [ ! -f $PIDFILE ]
        then
            echo "$PIDFILE does not exist, process is not running"
        else
            PID=$(cat $PIDFILE)
            echo "Stopping ..."
            $CLIEXEC -p $REDISPORT shutdown
            while [ -x /proc/${PID} ]
            do
                echo "Waiting for Redis to shutdown ..."
                sleep 1
            done
            echo "Redis stopped"
        fi
        ;;
    status)
        PID=$(cat $PIDFILE)
        if [ ! -x /proc/${PID} ]
        then
            echo 'Redis is not running'
        else
            echo "Redis is running ($PID)"
        fi
        ;;
    restart)
        $0 stop
        $0 start
        ;;
    *)
        echo "Please use start, stop, restart or status as first argument"
        ;;
esac

```

我们将这个文件拷贝到`/etc/init.d/`下

```shell
# 这里的名称尽量好记一点，因为后面会用到，因此我把它重命名为了redis
cp redis_init_script redis 

```

## 测试启动

配置到这里我们就可以使用`sudo service redis start`来启动，

查看是否启动成功

```shell
ps -aux | grep redis

# 使用-ef也可以，只不过是关注点不同，-ef不显示CPU、内存、虚拟空间和实际空间使用情况
# 不过这些我们可能不会通过ps去查看就对了，肯定使用top实时看会好点
# 相对的-ef命令可以查看到PPID就是父进程的id

ps -ef | grep redis

```
我们可以看到redis进程运行在了`127.0.0.1:6379`端口下

## 其他命令

我们可以使用其他命令来快捷的操作

```bash
# 关闭
sudo service redis stop

# 重启
sudo service redis restart

# 查看状态
sudo service redis status

```