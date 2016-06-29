# docker-emi-ui
## Dockerizing EMI UI how to:
- In a CentOS6 VM install docker-engine:
```
yum install docker-engine -y
```
- docker build -t emi-ui .
- docker run -it -v /home/enmruser/.globus:/home/enmruser/.globus wenmr-emi-ui
