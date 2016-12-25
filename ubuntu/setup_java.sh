#!/bin/bash

jdk_source=$1
if [[ -z $jdk_source ]]; then
    jdk_source=./jdk-8u51-linux-x64.tar.gz
fi

if [[ "$jdk_source" == "help" ]]; then
    echo "Usage: $0 [jdk_source_option]"
    echo "Example 1: $0"
    echo "Example 2: $0 /tmp/jdk-8u51-linux-x64.tar.gz"
    exit 0
fi

if [ -z `which javac | grep javac` ]; then
    echo "Check jdk source ..."
    if [[ ! -e $jdk_source ]]; then
        echo "Jdk doesn't exist, start downloading ..."
        wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u51-b16/jdk-8u51-linux-x64.tar.gz"
        jdk_source=./jdk-8u51-linux-x64.tar.gz
        echo "Download jdk8 from oracle success."
    else
        echo "Install jdk from source "$jdk_source
    fi


    echo "Check jdk1.8.0_51 directory exist ...."
    if [[ ! -e jdk1.8.0_51 ]]; then
        tar -zxvf $jdk_source || exit 1
    fi

    echo "Move jdk1.8.0_51 to /usr/java"
    mv jdk1.8.0_51 /opt/jdk1.8.0_51 || exit 2

    # 配置java环境变量
    echo "setup java exvironment ..."
    echo "export JAVA_HOME=/opt/jdk1.8.0_51" >> /etc/profile
    echo -e 'export CLASSPATH=.:$CLASSPATH:$JAVA_HOME/jre/lib:$JAVA_HOME/lib' >> /etc/profile
    echo -e 'export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin' >> /etc/profile

    echo "Reload source /etc/profile"
    source /etc/profile

    echo "Install success."

else
    echo "Java has installed."
fi
