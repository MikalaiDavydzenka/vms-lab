sudo firectl \
    --root-drive=rootfs.ext4 \
    --memory=2048 \
    --ncpus=1 \
    --kernel-opts="ro console=ttyS0 noapic reboot=k panic=1 pci=off nomodules cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1" \
    --tap-device=tap0/AA:FC:00:00:00:01