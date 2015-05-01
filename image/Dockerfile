FROM centos:6.6
# Modified by
MAINTAINER Atkins Chang "atkinschang@icloud.com"
# Origin form
MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
ENV container docker
RUN mkdir /build
ADD . /build

RUN /build/prepare.sh && \
	/build/system_services.sh && \
	/build/utilities.sh && \
	/build/cleanup.sh

VOLUME ["/sys/fs/cgroup"]
CMD ["/sbin/my_init"]
