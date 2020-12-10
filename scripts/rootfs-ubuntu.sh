ROOTFS_FILE=rootfs.ext4
TMP_MOUNT=/tmp/rootfs
BASE=ubuntu-base-20.04.1-base-amd64.tar.gz

rm -f ${ROOTFS_FILE}
dd if=/dev/zero of=${ROOTFS_FILE} bs=1M count=1024
mkfs.ext4 ${ROOTFS_FILE}
mkdir -p ${TMP_MOUNT}
sudo mount ${ROOTFS_FILE} ${TMP_MOUNT}

sudo tar xf ${BASE} -C ${TMP_MOUNT}

sudo umount ${TMP_MOUNT}