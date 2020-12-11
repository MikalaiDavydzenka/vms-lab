#!/bin/bash

cd /opt/linux-${KERNEL_VERSION}

# build kernel and modules
make -j32
# not sure if we need to build vmlinux explicitly
# make -j32 vmlinux


cp vmlinux /opt/out/vmlinux

mkdir -p /opt/out/lib
cp -r /lib/modules/ /opt/out/lib/