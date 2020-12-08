#!/bin/sh

apk add openrc
apk add util-linux
apk add sudo
apk add bash
apk add networkmanager
# Set up a login terminal on the serial console (ttyS0):
ln -s agetty /etc/init.d/agetty.ttyS0
echo 'agetty_options="--autologin sandman --noclear"' > /etc/conf.d/agetty.ttyS0
echo ttyS0 > /etc/securetty
rc-update add agetty.ttyS0 default

# Make sure special file systems are mounted on boot:
rc-update add devfs boot
rc-update add procfs boot
rc-update add sysfs boot

echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
adduser \
    --disabled-password \
    --shell /bin/bash \
    --ingroup wheel \
    sandman
echo "sandman:sandman" | chpasswd

echo "sandbox" > /etc/hostname
echo "127.0.1.1 sandbox" >> /etc/hosts


# Then, copy the newly configured system to the rootfs image:
for d in bin etc lib root sbin usr home; do tar c "/$d" | tar x -C /custom-rootfs; done
for dir in dev proc run sys var; do mkdir /custom-rootfs/${dir}; done

# All done, exit docker shell
exit