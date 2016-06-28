# Dockerfile to create a container with the EMI UI service
FROM centos:6
MAINTAINER Marco Verlato <verlato@pd.infn.it>
LABEL version="3.1.0"
LABEL description="Container image to run the EMI UI service. (http://repository.egi.eu/2014/11/10/emi-ui-3-1-0/)"
RUN yum update -y && yum install -y yum-priorities
RUN yum install -y http://repository.egi.eu/sw/production/umd/3/sl6/x86_64/updates/umd-release-3.0.1-1.el6.noarch.rpm
RUN yum install -y ca-policy-egi-core emi-ui voms-clients
# Configuring EMI UI
RUN echo $(hostname -I) $(hostname).localdomain $(hostname) >>/etc/hosts
RUN /opt/glite/yaim/bin/yaim -d 6 -c -s site-info.def -n UI
