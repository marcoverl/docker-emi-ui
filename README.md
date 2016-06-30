# docker-emi-ui
## How to use EMI UI docker container for enmr.eu VO:
#### In a CentOS (or Ubuntu) server, as root, install and start docker-engine:
```
yum install docker-engine -y (or apt-get install docker.io -y)
service docker start
```
#### Copy your usercert.pem and userkey.pem under /root/.globus/ (or where else you prefer)
```
mkdir /root/.globus
scp yourusername@yourpc.domain:.globus/user*.pem /root/.globus/
```
#### Now you have two options:
- pull the image and run the container (faster):
```
docker pull marcoverl/docker-emi-ui
docker run -it -v /root/.globus:/home/enmruser/.globus --name wenmr-ui marcoverl/docker-emi-ui
```
- build the docker image and run the container (slower):
```
git clone https://github.com/marcoverl/docker-emi-ui
cd docker-emi-ui
docker build -t docker-emi-ui .
docker run -it -v /root/.globus:/home/enmruser/.globus --name wenmr-ui docker-emi-ui
```
#### You are logged as root, in case you need to install other packages. As enmruser you can then create your proxy and submit grid jobs
```
chown enmruser.enmruser -R /home/enmruser
su - enmruser
voms-proxy-init -voms enmr.eu
#
# testing job submission via EMI-WMS
#
glite-wms-job-list-match -a test-wms.jdl
glite-wms-job-submit -a -o jidw.txt test-wms.jdl
glite-wms-job-status -i jidw.txt
glite-wms-job-output -i jidw.txt
#
# testing direct job submission to a CREAM-CE
#
glite-ce-allowed-submission pbs-enmr.cerm.unifi.it:8443
glite-ce-job-submit -a -o jidc.txt -r pbs-enmr.cerm.unifi.it:8443/cream-pbs-short test-cream.jdl
glite-ce-job-status -i jidc.txt
glite-ce-job-output -i jidc.txt
```
