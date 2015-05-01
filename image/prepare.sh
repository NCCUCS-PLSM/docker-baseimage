#!/bin/bash
set -e
source /build/buildconfig
set -x

mv /build/Centos-Source.repo /etc/yum.repos.d/Centos-Source.repo

yum update -y

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD

## Enable Ubuntu Universe and Multiverse.
$minimal_yum_install unzip wget tar
wget http://ftp.yzu.edu.tw/Linux/Fedora-EPEL/6/x86_64/epel-release-6-8.noarch.rpm
yum localinstall -y epel-release-6-8.noarch.rpm
rm epel-release-6-8.noarch.rpm

localedef --no-archive -i en_US -f UTF-8 en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
echo -n en_US.UTF-8 > /etc/container_environment/LANG
echo -n en_US.UTF-8 > /etc/container_environment/LC_CTYPE

cp /build/bin/workaround-pam /usr/bin/
