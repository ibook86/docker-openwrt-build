FROM ubuntu:latest

LABEL maintainer="made by ibook86"

WORKDIR /home/openwrt

ENV BUILD_PATH="/home/openwrt"

RUN apt-get install -qq -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
      bzip2 ccache cmake cpio curl device-tree-compiler ecj fastjar flex gawk gettext gcc-multilib g++-multilib \
      git git-core gperf haveged help2man intltool lib32gcc1 libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev \
      libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncurses5-dev libreadline-dev libssl-dev libtool libz-dev \
      lrzsz mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pip python3-ply \
      python-docutils qemu-utils re2c rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim \
      wget xmlto xxd zlib1g-dev && apt-get -qq autoremove --purge && apt-get -qq clean

RUN git clone -b "openwrt-21.02" --single-branch https://github.com/immortalwrt/immortalwrt && cd $BUILD_PATH/immortalwrt && \
    ./scripts/feeds update -a && ./scripts/feeds install -a && \
    rm -rf ./tmp && rm -rf .config && \
    wget -O .config https://raw.githubusercontent.com/ibook86/newifi3-d2-openwrt/master/.config_immortalwrt && \
    make defconfig && make -j8 download && make -j$(nproc)