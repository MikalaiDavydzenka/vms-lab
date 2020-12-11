SHELL := /bin/bash

BASE_DIR := opt
# KERNEL_VERSION := 5.4.43
KERNEL_VERSION := 4.19.125
# KERNEL_BRANCH := 5.x
KERNEL_BRANCH := 4.x
KERNEL_SOURCE_DIR := $(BASE_DIR)/linux-$(KERNEL_VERSION)
KERNEL_ARCH_FILE := $(BASE_DIR)/linux-$(KERNEL_VERSION).tar.xz
KERNEL_ARCH_URL := https://cdn.kernel.org/pub/linux/kernel/v$(KERNEL_BRANCH)/linux-$(KERNEL_VERSION).tar.xz
PWD := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

build: $(KERNEL_SOURCE_DIR)/.config build-kernel

build-kernel: kernel-builder
	docker run --rm \
		-e KERNEL_VERSION=$(KERNEL_VERSION) \
		--volume=$(PWD)/opt:/opt \
		kernel-builder /opt/scripts/build-kernel.sh

run:
	docker run -it --rm \
		-e KERNEL_VERSION=$(KERNEL_VERSION) \
		--volume=$(PWD)/opt:/opt \
		kernel-builder /bin/bash

kernel-builder:
	docker build -t kernel-builder - < Dockerfile

$(KERNEL_SOURCE_DIR)/.config: $(KERNEL_SOURCE_DIR)
	cp config-$(KERNEL_VERSION) $(KERNEL_SOURCE_DIR)/.config

$(KERNEL_SOURCE_DIR): $(KERNEL_ARCH_FILE)
	[[ -d $(KERNEL_SOURCE_DIR) ]] || tar xf $(KERNEL_ARCH_FILE) -C $(BASE_DIR)

$(KERNEL_ARCH_FILE):
	wget $(KERNEL_ARCH_URL) --directory-prefix $(BASE_DIR)/

