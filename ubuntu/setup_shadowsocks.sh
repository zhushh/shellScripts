#!/bin/bash

sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt-get update 
sudo apt-get install shadowsocks-qt5

sudo apt-get install python-pip
sudo pip install --upgrade pip
sudo pip install shadowsocks
