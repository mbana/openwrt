#!/usr/bin/env sh
DEVICE="${DEVICE:-/dev/sda}"

gunzip --stdout --keep ./bin/targets/mediatek/filogic/openwrt-mediatek-filogic-bananapi_bpi-r4-pro-4e-sdcard.img.gz | sudo dd status=progress conv=notrunc,fsync of=${DEVICE}
sudo partprobe ${DEVICE}

sudo parted --script --fix ${DEVICE} -- align-check optimal 1
sudo partprobe ${DEVICE}

START="$(sudo parted --json ${DEVICE}  -- unit MiB print free | jq -r '.disk.partitions.[-1].start')"
sudo parted --fix --script ${DEVICE} --align optimal mkpart "opt-docker" ext4 "${START}" 50%
sudo parted --fix --script ${DEVICE} --align optimal mkpart "storage-overlay" ext4 50% 100%
sudo partprobe ${DEVICE}

sudo mkfs.ext4 -F -L "opt-docker" ${DEVICE}8
sudo mkfs.ext4 -F -L "storage-overlay" ${DEVICE}9
sudo partprobe ${DEVICE}

echo -e '\a'
