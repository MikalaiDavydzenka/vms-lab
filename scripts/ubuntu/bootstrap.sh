#! /bin/bash
set -ex

ROOTFS_FILE=rootfs.ext4
TMP_MOUNT=/tmp/rootfs

rm -f ${ROOTFS_FILE}
dd if=/dev/zero of=${ROOTFS_FILE} bs=1M count=1024
mkfs.ext4 ${ROOTFS_FILE}
mkdir -p ${TMP_MOUNT}
sudo mount ${ROOTFS_FILE} ${TMP_MOUNT}

sudo debootstrap --include openssh-server,netplan.io,vim,curl bionic ${TMP_MOUNT} http://by.archive.ubuntu.com/ubuntu/
sudo mount --bind ${PWD} ${TMP_MOUNT}/mnt

sudo chroot ${TMP_MOUNT} /bin/bash /mnt/configure.sh

sudo umount ${TMP_MOUNT}/mnt
# sudo umount ${TMP_MOUNT}
