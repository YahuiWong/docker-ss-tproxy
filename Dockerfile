# 拉取 CentOS
#FROM hub.c.163.com/library/centos:latest
FROM yahuiwong/centos:7.5.1804Linux4.19.2-1.el7.elrepo.x86_64
# 维护者
MAINTAINER YahuiWong <yahui9119@live.com>

COPY install-ss-tproxy.sh /install-ss-tproxy.sh
RUN sh /install-ss-tproxy.sh
ENTRYPOINT ss-tproxy update-gfwlist && ss-tproxy update-chnroute && ss-tproxy update-chnonly && ss-tproxy restart &&  tail -f /var/log/ssr-redir.log 
