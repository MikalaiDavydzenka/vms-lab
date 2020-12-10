# Install

```bash
# it would be better to make special virtualenv
# for example with virtualenvwrapper
# --system-site-packages required due to we need to have access to system python-apt package
mkvirtualenv vms-lab --system-site-packages

# install ansible and all required python packages
pip install -r requirements.txt

# install ansible collection
ansible-galaxy collection install -r ansible-requirements.yml
```

# Firecracker

Links:
- [Firecracker Docs](https://github.com/firecracker-microvm/firecracker/tree/master/docs)
- Build Kernel
    * https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel
    * [Work with kernel config](https://stackoverflow.com/a/31936064)
        + `make olddefconfig` sets every option to their default value without asking interactively
- [Firectl](https://github.com/firecracker-microvm/firectl) - helps manage firecracker vms
- [Docker container to build kernel and rootfs compatible with firecracker](https://github.com/bkleiner/ubuntu-firecracker)

# Build Kernel

```sh
# dependencies
sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev
# download
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.9.12.tar.xz
# unarchive
tar xf linux-5.9.12.tar.xz
# copy .config file to resulted folder
make olddefconfig
make vmlinux
```

# Start

```
sudo setfacl -m u:${USER}:rw /dev/kvm
firecracker --api-sock /tmp/firecracker.socket
```

# K3S

[binary link](https://github.com/rancher/k3s/releases/download/v1.19.4+k3s1/k3s)
```sh
#install
sudo INSTALL_K3S_SKIP_DOWNLOAD=true ./k3s_install.sh
```