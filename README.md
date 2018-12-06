# docker-ss-tproxy
[![](https://images.microbadger.com/badges/image/yahuiwong/ss-tproxy.svg)](https://microbadger.com/images/yahuiwong/ss-tproxy "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/yahuiwong/ss-tproxy.svg)](https://microbadger.com/images/yahuiwong/ss-tproxy "Get your own version badge on microbadger.com")



ss-redir 全局透明代理 (REDIRECT + TPROXY)
封装自 https://github.com/YahuiWong/ss-tproxy

## 注意：

你的docker宿主内核版本要是：3.10.0-862.el7.x86_64 

使用时请使用 注意使用 `conf/`下的配置文件，并注意把`ss-tproxy.conf`里的ss配置信息修改为自己的
`您的ss必须支持udp转发`
