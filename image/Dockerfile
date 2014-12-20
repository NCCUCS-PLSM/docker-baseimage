FROM ubuntu:14.10
# Modified by
MAINTAINER Atkins Chang "atkinschang@icloud.com"
# Origin form
MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
RUN mkdir /build
ADD . /build

RUN /build/prepare.sh && \
	/build/system_services.sh && \
	/build/utilities.sh && \
	/build/cleanup.sh

CMD ["/sbin/my_init"]
