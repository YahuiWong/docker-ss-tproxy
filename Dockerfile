# 拉取 CentOS
FROM hub.c.163.com/library/centos:latest

# 维护者
MAINTAINER YahuiWong <yahui9119@live.com>

COPY install-ss-tproxy.sh /install-ss-tproxy.sh
RUN sh /install-ss-tproxy.sh
ENTRYPOINT ss-tproxy restart && tail -f /var/log/pdnsd.log
