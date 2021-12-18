# 拉取 CentOS
#FROM hub.c.163.com/library/centos:latest
# FROM yahuiwong/centos:7.5.1804Linux4.19.2-1.el7.elrepo.x86_64
FROM centos7:7.9.2009
# 维护者
MAINTAINER YahuiWong <yahui9119@live.com>
RUN cp -a /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak &&\
    curl -o /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo &&\
    curl -o /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo
COPY install-ss-tproxy.sh /install-ss-tproxy.sh
RUN sh /install-ss-tproxy.sh
RUN ss-tproxy update-gfwlist && ss-tproxy update-chnroute && ss-tproxy update-chnonly && ss-tproxy restart &&  tail -f /var/log/ssr-redir.log 
