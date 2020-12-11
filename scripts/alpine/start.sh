sudo firectl \
    --root-drive=rootfs.ext4 \
    --kernel-opts="ro console=ttyS0 noapic reboot=k panic=1 pci=off nomodules cgroup_memory=1 cgroup_enable=memory" \
    --tap-device=tap0/AA:FC:00:00:00:01