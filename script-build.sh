#!/usr/bin/env sh
# sudo apt install bc binutils-gold bison build-essential ccache ecj fastjar file flex g++ gawk gcc-arm* gettext git help2man libbsd-dev libelf-dev liblzma-dev libncurses-dev libssl-dev mtd-utils meson mold mtd-utils ninja-build pbzip2 pigz pkg-config python3-dev python3-setuptools rsync subversion swig texinfo time u-boot-tools unzip wget xsltproc xxd zlib1g-dev zstd
# sudo apt install bzip2 g++ gawk gcc git glibc-source libncurses-dev make
# ./scripts/feeds update -a
# ./scripts/feeds install -a

make defconfig
nice make -j$(nproc --all) V=sc || nice make -j1 V=sc
# Bell sound when the above completes
echo -e '\a'
