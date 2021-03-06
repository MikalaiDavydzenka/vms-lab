#! /bin/bash
set -ex

# dpkg -i /mnt/root/linux*.deb

echo "sandbox" > /etc/hostname
passwd -d root
adduser \
    --disabled-password \
    --shell /bin/bash \
    --ingroup sudo \
    --gecos "" \
    sandman
echo "sandman:sandman" | chpasswd
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
      gateway4: 172.16.0.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF
netplan generate