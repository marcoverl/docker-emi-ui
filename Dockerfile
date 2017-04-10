# Dockerfile to create a container with the EMI UI service
# docker -t emi-ui .
FROM centos:6
MAINTAINER Marco Verlato <verlato@pd.infn.it>
LABEL version="3.1.0"
LABEL description="Container image to run the EMI UI service. (http://repository.egi.eu/2014/11/10/emi-ui-3-1-0/)"
USER root
WORKDIR /root
RUN  rpm --import http://repository.egi.eu/sw/production/umd/UMD-RPM-PGP-KEY
RUN yum update -y && yum install -y yum-priorities wget openssh-clients gcc
RUN yum install -y http://repository.egi.eu/sw/production/umd/3/sl6/x86_64/updates/umd-release-3.14.4-1.el6.noarch.rpm
RUN yum install -y --nogpgcheck ca-policy-egi-core emi-ui voms-clients
# Configuring EMI UI
COPY site-info.def site-info.def
COPY fakehostname.c fakehostname.c
RUN gcc -o fakehostname.o -c -fPIC -Wall fakehostname.c
RUN gcc -o libfakehostname.so -shared -W1,export-dynamic fakehostname.o -ldl
RUN sed -i 's|hostname -f|hostname|g' /opt/glite/yaim/bin/yaim
RUN export LD_PRELOAD=/root/libfakehostname.so; /opt/glite/yaim/bin/yaim -d 6 -c -s /root/site-info.def -n UI
RUN useradd -ms /bin/bash enmruser
USER enmruser
WORKDIR /home/enmruser
RUN mkdir .globus
COPY test-wms.jdl test-wms.jdl
COPY test-cream.jdl test-cream.jdl
USER root
WORKDIR /root

