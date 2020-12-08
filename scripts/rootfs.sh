ROOTFS_FILE=rootfs.ext4
TMP_MOUNT=/tmp/rootfs

rm -f ${ROOTFS_FILE}
dd if=/dev/zero of=${ROOTFS_FILE} bs=1M count=1024
mkfs.ext4 ${ROOTFS_FILE}
mkdir -p ${TMP_MOUNT}
sudo mount ${ROOTFS_FILE} ${TMP_MOUNT}

docker run -it --rm \
    --volume ${PWD}:/scripts \
    --volume ${TMP_MOUNT}:/custom-rootfs \
    alpine /scripts/make-rootfs.sh

sudo umount ${TMP_MOUNT}