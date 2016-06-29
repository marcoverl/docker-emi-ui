# docker-emi-ui
## Dockerizing EMI UI how to:
- In a CentOS6 VM, as root, install and start docker-engine:
```
yum install docker-engine -y
service docker start
```
- Create enmruser and copy your usercert.pem and userkey.pem under /home/enmruser/.globus/
```
useradd -ms /bin/bash enmruser
mkdir /home/enmruser/.globus
scp yourusername@yourpc.domain:user*.pem /home/enmruser/.globus/
chown enmruser.enmruser -R /home/enmruser
```
- Now you have two options:
-- pull the image and run the container:
```
docker pull marcoverl/docker-emi-ui
docker run -it -v /home/enmruser/.globus:/home/enmruser/.globus --name wenmr-ui marcoverl/docker-emi-ui
```
--Build the docker image and run the container:
```
git clone https://github.com/marcoverl/docker-emi-ui
cd docker-emi-ui
docker build -t docker-emi-ui .
docker run -it -v /home/enmruser/.globus:/home/enmruser/.globus --name wenmr-ui docker-emi-ui
```
- You are logged as root, in case you need to install other packages. As enmruser you can then create your proxy and submit grid jobs
```
su - enmruser
voms-proxy-init -voms enmr.eu
glite-wms-job-submit -o jid -a test.jdl
glite-wms-job-status -i jid
```
