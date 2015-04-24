#!/bin/bash
set -e
source /build/buildconfig
set -x

## Temporarily disable dpkg fsync to make building faster.

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD

## Enable Ubuntu Universe and Multiverse.
$minimal_yum_install wget
wget http://ftp.yzu.edu.tw/Linux/Fedora-EPEL/7/x86_64/e/epel-release-7-5.noarch.rpm
yum localinstall -y epel-release-7-5.noarch.rpm
rm epel-release-7-5.noarch.rpm

## Workaround https://github.com/dotcloud/docker/issues/2267,
## not being able to modify /etc/hosts.
mkdir -p /etc/workaround-docker-2267
ln -s /etc/workaround-docker-2267 /cte
cp /build/bin/workaround-docker-2267 /usr/bin/

yum update -y
