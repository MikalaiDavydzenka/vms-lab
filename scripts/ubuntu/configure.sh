#! /bin/bash
set -ex

# dpkg -i /mnt/root/linux*.deb

echo 'ubuntu-bionic' > /etc/hostname
passwd -d root
mkdir /etc/systemd/system/serial-getty@ttyS0.service.d/
cat <<EOF > /etc/systemd/system/serial-getty@ttyS0.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin root -o '-p -- \\u' --keep-baud 115200,38400,9600 %I $TERM
EOF

cat <<EOF > /etc/netplan/99_config.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses:
      - 172.16.0.2/24
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF
netplan generate