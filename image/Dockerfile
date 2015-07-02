FROM ubuntu:15.10
# Modified by
MAINTAINER Atkins Chang "atkinschang@icloud.com"
# Origin form
MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
ADD . /build

RUN /build/prepare.sh && \
	/build/system_services.sh && \
	/build/utilities.sh && \
	/build/cleanup.sh

CMD ["/sbin/my_init"]
