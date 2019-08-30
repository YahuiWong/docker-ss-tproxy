# docker-ss-tproxy
[![](https://images.microbadger.com/badges/image/yahuiwong/ss-tproxy.svg)](https://microbadger.com/images/yahuiwong/ss-tproxy "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/yahuiwong/ss-tproxy.svg)](https://microbadger.com/images/yahuiwong/ss-tproxy "Get your own version badge on microbadger.com")



ss-redir 全局透明代理 (REDIRECT + TPROXY)
封装自 https://github.com/YahuiWong/ss-tproxy

## 注意：

你的docker宿主内核版本要是：4.19.2-1.el7.elrepo.x86_64
```sh
wget http://mirror.rc.usf.edu/compute_lock/elrepo/kernel/el7/x86_64/RPMS/kernel-ml-4.19.2-1.el7.elrepo.x86_64.rpm
yum install kernel-ml-4.19.2-1.el7.elrepo.x86_64.rpm -y
vim /etc/default/grub # GRUB_DEFAULT=0
grub2-mkconfig -o /boot/grub2/grub.cfg
reboot
```
使用时请使用 注意使用 `conf/`下的配置文件，并注意把`ss-tproxy.conf`里的ss配置信息修改为自己的
`您的ss必须支持udp转发`
