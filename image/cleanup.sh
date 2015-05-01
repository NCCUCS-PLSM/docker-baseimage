#!/bin/bash
set -e
source /build/buildconfig
set -x

yum clean all
rm -rf /build
rm -rf /tmp/* /var/tmp/*

rm -f /etc/ssh/ssh_host_*
