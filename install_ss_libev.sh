#!/bin/env bash

function install_deps
{
   SOFT="$1"
   if [ -n "$SOFT" ];then
	which $SOFT
	if [ $? != 0 ];then
	    yum install $SOFT -y
	fi
   fi
}

install_deps git

TAR_DIR=$HOME
cd $TAR_DIR

git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive

sudo yum install epel-release -y
sudo yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium libsodium-devel mbedtls-devel -y

./autogen.sh && ./configure && make
sudo make install
