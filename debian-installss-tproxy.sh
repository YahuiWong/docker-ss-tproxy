#!/bin/bash
apt update
apt install procps kmod zlib1g-dev libpcre3 libpcre3-dev sysvinit-utils dnsmasq git gettext gcc autoconf libtool make asciidoc xmlto libc-ares-dev libev-dev libssl-dev net-tools curl ipset iproute perl wget gcc dnsutils vim haveged -y

update-rc.d haveged defaults
service haveged start

# Build aclocal-1.15, it's needed by dnsforwarder
if ! type aclocal-1.15 2>/dev/null; then
    bigecho "Build aclocal-1.15, Pleast wait..."
    AUTOMAKE_VER=1.15
    AUTOMAKE_FILE="automake-$AUTOMAKE_VER"
    AUTOMAKE_URL="https://ftp.gnu.org/gnu/automake/$AUTOMAKE_FILE.tar.gz"
    if ! wget --no-check-certificate -O $AUTOMAKE_FILE.tar.gz $AUTOMAKE_URL; then
        bigecho "Failed to download file!"
        exit 1
    fi
    tar xf $AUTOMAKE_FILE.tar.gz
    pushd $AUTOMAKE_FILE
    ./configure
    make && make install
    popd
fi

# Build dnsforwarder
if ! type dnsforwarder 2>/dev/null; then
    bigecho "Build dnsforwarder, Pleast wait..."
    git clone https://github.com/holmium/dnsforwarder.git
    pushd dnsforwarder
    ./configure --enable-downloader=no
    make && make install
    popd
fi

# Build chinadns
if ! type chinadns 2>/dev/null; then
    bigecho "Build chinadns, Pleast wait..."
    CHINADNS_VER=1.3.2
    CHINADNS_FILE="chinadns-$CHINADNS_VER"
    CHINADNS_URL="https://github.com/shadowsocks/ChinaDNS/releases/download/$CHINADNS_VER/$CHINADNS_FILE.tar.gz"
    if ! wget --no-check-certificate -O $CHINADNS_FILE.tar.gz $CHINADNS_URL; then
        bigecho "Failed to download file!"
        exit 1
    fi
    tar xf $CHINADNS_FILE.tar.gz
    pushd $CHINADNS_FILE
    ./configure
    make && make install
    popd
fi

# Build Libsodium
if [ ! -f "/usr/lib/libsodium.so" ]; then
    bigecho "Build Libsodium, Pleast wait..."
    LIBSODIUM_VER=1.0.17
    LIBSODIUM_FILE="libsodium-$LIBSODIUM_VER"
    LIBSODIUM_URL="https://download.libsodium.org/libsodium/releases/$LIBSODIUM_FILE.tar.gz"
    if ! wget --no-check-certificate -O $LIBSODIUM_FILE.tar.gz $LIBSODIUM_URL; then
        bigecho "Failed to download file!"
        exit 1
    fi
    tar xf $LIBSODIUM_FILE.tar.gz
    pushd $LIBSODIUM_FILE
    ./configure --prefix=/usr && make
    make install
    popd
    ldconfig
fi

# Build MbedTLS
if [ ! -f "/usr/lib/libmbedtls.so" ]; then
    bigecho "Build MbedTLS, Pleast wait..."
    MBEDTLS_VER=2.6.0
    MBEDTLS_FILE="mbedtls-$MBEDTLS_VER"
    MBEDTLS_URL="https://tls.mbed.org/code/releases/$MBEDTLS_FILE-gpl.tgz"
    if ! wget --no-check-certificate -O $MBEDTLS_FILE-gpl.tgz $MBEDTLS_URL; then
        bigecho "Failed to download file!"
        exit 1
    fi
    tar xf $MBEDTLS_FILE-gpl.tgz
    pushd $MBEDTLS_FILE
    make SHARED=1 CFLAGS=-fPIC
    make DESTDIR=/usr install
    popd
    ldconfig
fi

#Build shadowsocksr-libev
if ! type ssr-redir 2>/dev/null; then
    bigecho "Build shadowsocksr-libev, Pleast wait..."
    git clone https://github.com/shadowsocksr-backup/shadowsocksr-libev.git
    pushd shadowsocksr-libev
    ./configure --prefix=/usr/local/ssr-libev
    make && make install
    popd
    pushd /usr/local/ssr-libev/bin
    mv ss-redir ssr-redir
    mv ss-local ssr-local
    ln -sf ssr-local ssr-tunnel
    mv ssr-* /usr/local/bin/
    popd
    rm -fr /usr/local/ssr-libev
fi

# Install SS-TPROXY
if ! type ss-tproxy 2>/dev/null; then
    bigecho "Install SS-TProxy, Pleast wait..."
    git clone https://github.com/YahuiWong/ss-tproxy.git
    pushd ss-tproxy
    cp -af ss-tproxy /usr/local/bin
	chmod 0755 /usr/local/bin/ss-tproxy
	chown root:root /usr/local/bin/ss-tproxy
	mkdir -m 0755 -p /etc/ss-tproxy
	cp -af ss-tproxy.conf gfwlist.* chnroute.* /etc/ss-tproxy
	chmod 0644 /etc/ss-tproxy/* && chown -R root:root /etc/ss-tproxy
    popd

    # Systemctl
    pushd ss-tproxy
    cp -af ss-tproxy.service /etc/systemd/system/
    popd
    # update-rc.d ss-tproxy defaults
    # service ss-tproxy start
fi