#!/bin/sh

apk add openrc
apk add util-linux
apk add sudo
apk add bash
apk add coreutils
apk add curl
# Set up a login terminal on the serial console (ttyS0):
ln -s agetty /etc/init.d/agetty.ttyS0
echo 'agetty_options="--autologin sandman --noclear"' > /etc/conf.d/agetty.ttyS0
echo ttyS0 > /etc/securetty
rc-update add agetty.ttyS0 default

# Make sure special file systems are mounted on boot:
rc-update add devfs boot
rc-update add procfs boot
rc-update add sysfs boot
rc-update add cgroups

rc-update add networking default

echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
adduser \
    --disabled-password \
    --shell /bin/bash \
    --ingroup wheel \
    sandman
echo "sandman:sandman" | chpasswd

echo "sandbox" > /etc/hostname
echo "127.0.0.1 sandbox" >> /etc/hosts

echo 'keep_network="NO"' >> /etc/rc.conf


# Then, copy the newly configured system to the rootfs image:
for d in bin etc lib root sbin usr home; do tar c "/$d" | tar x -C /custom-rootfs; done
for dir in dev proc run sys var tmp; do mkdir /custom-rootfs/${dir}; done

mkdir -p /custom-rootfs/var/cache/apk
mkdir -p /custom-rootfs/var/log
mkdir -p /custom-rootfs/var/run
cp /scripts/k3s /custom-rootfs/usr/local/bin/k3s
cp /scripts/k3s_install.sh /custom-rootfs/home/sandman/k3s_install.sh
cp /scripts/network-guest.sh /custom-rootfs/home/sandman/network-guest.sh
cp /scripts/network-interface /custom-rootfs/etc/network/interfaces

# All done, exit docker shell
exit