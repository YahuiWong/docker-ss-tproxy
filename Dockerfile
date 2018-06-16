# 拉取 CentOS
FROM hub.c.163.com/library/centos:latest

# 维护者
MAINTAINER YahuiWong <yahui9119@live.com>


RUN curl --silent --location https://github.com/YahuiWong/Usefulfiles/raw/master/install-ss-tproxy.sh  | bash - 
RUN ss-tproxy restart 
CMD ["tail","-f","/var/log/pdnsd.log"]
