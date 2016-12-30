#!/bin/bash

source_file=$2
source_directory=apache-maven-3.3.9

if [ -z `echo $JAVA_HOME` ]; then
    echo "Please install java and setup environment JAVA_HOME firstly."
    exit 0
fi

if which mvn | grep mvn
then
    echo "Maven has installed."
else
    if [ -z $source_file ]; then 
        source_file=apache-maven-3.3.9-bin.tar.gz
    fi
    
    if [ ! -e $source_file ]; then
        echo "Start downloading ..."
        wget http://apache.website-solution.net/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
        source_file=apache-maven-3.3.9-bin.tar.gz
    fi
    
    if [ ! -e $source_directory ]; then
        tar -zxvf $source_file
    fi
    
    echo "Move $source_directory to /usr/local"
    mv $source_directory /usr/local/ || exit 1
    
    echo "Setup maven environment ..."
    echo -e 'export M2_HOME=/usr/local/apache-maven-3.3.9' >> /etc/profile
    echo -e 'export MAVEN_OPTS="-Xms256m -Xmx512m"' >> /etc/profile
    echo -e 'export PATH=$M2_HOME/bin:$PATH' >> /etc/profile
    
    echo "Reload source /etc/profile"
    source /etc/profile
    echo "Install maven success"
fi

