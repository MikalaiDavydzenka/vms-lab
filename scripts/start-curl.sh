BASE_PATH="../firecracker"
kernel_path=$(realpath ${BASE_PATH}/vmlinux)
rootfs_path=$(realpath ${BASE_PATH}/rootfs.ext4)
# kernel_path=$(pwd)"/vmlinux-5.9"
# kernel_path=$(pwd)"/vmlinux-4.19"
# kernel_path=$(pwd)"/hello-vmlinux.bin"
# rootfs_path=$(pwd)"/rootfs.ext4"

curl --unix-socket /tmp/firecracker.socket -i \
    -X PUT 'http://localhost/boot-source'   \
    -H 'Accept: application/json'           \
    -H 'Content-Type: application/json'     \
    -d "{
        \"kernel_image_path\": \"${kernel_path}\",
        \"boot_args\": \"console=ttyS0 reboot=k panic=1 pci=off i8042.noaux i8042.nomux i8042.nopnp i8042.dumbkbd\"
    }"
        # \"boot_args\": \"console=ttyS0 reboot=k panic=1 pci=off\"

curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/drives/rootfs' \
  -H 'Accept: application/json'           \
  -H 'Content-Type: application/json'     \
  -d "{
        \"drive_id\": \"rootfs\",
        \"path_on_host\": \"${rootfs_path}\",
        \"is_root_device\": true,
        \"is_read_only\": false
   }"

curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/actions'       \
  -H  'Accept: application/json'          \
  -H  'Content-Type: application/json'    \
  -d '{
      "action_type": "InstanceStart"
   }'

# curl --unix-socket /tmp/firecracker.socket -i -X GET "http://localhost/"