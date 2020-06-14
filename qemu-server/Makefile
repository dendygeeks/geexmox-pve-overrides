export LANG=C

TARGET_SUBDIR:=qemu-server

all: build

.build-deps: Makefile
	../prepare.sh
	sudo apt-get install build-essential dpkg-dev git pve-doc-generator debhelper lintian pve-cluster libpve-access-control libpve-storage-perl libpve-guest-common-perl libio-multiplex-perl libxml-libxml-perl pve-firewall libtest-mockmodule-perl pve-qemu-kvm pve-edk2-firmware pkg-config libjson-c-dev -y --allow-unauthenticated
	touch $@

upstream: .build-deps
	#git submodule update --init --recursive $(TARGET_SUBDIR)

patching: upstream $(addsuffix .done, $(wildcard patches/*.patch))
patches/%.patch.done:
	cd `grep $(basename $(notdir $@)) patches/patches.dir | awk '{print $$2}'` ; git apply $(basename $(abspath $@))
	touch $@

build: patching
	$(MAKE) -C $(TARGET_SUBDIR) deb
	rm -rf result
	mkdir -p result
	cp $(TARGET_SUBDIR)/*.deb result

clean:
	git submodule foreach --recursive git reset --hard
	git submodule foreach --recursive git clean -fd
	rm -f patches/*.done
	rm -rf result
	$(MAKE) -C $(TARGET_SUBDIR) clean

.PHONY: all upstream patching clean build
