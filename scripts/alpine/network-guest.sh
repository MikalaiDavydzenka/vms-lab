sudo ip addr add 172.16.0.2/24 dev eth0
sudo ip link set eth0 up
sudo ip route add default via 172.16.0.1 dev eth0