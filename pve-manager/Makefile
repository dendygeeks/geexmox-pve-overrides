export LANG=C

TARGET_SUBDIR:=pve-manager

all: build

.build-deps: Makefile
	sh ../prepare.sh
	sudo apt-get install build-essential dpkg-dev git debhelper lintian liblocale-po-perl libtest-mockmodule-perl pve-doc-generator pve-cluster libpve-common-perl libpve-storage-perl libpve-guest-common-perl qemu-server pve-container libfile-readbackwards-perl libpve-http-server-perl libpve-cluster-api-perl libtemplate-perl -y --allow-unauthenticated
	touch $@

upstream: .build-deps
	#git submodule update --init --recursive $(TARGET_SUBDIR)

patching: upstream $(addsuffix .done, $(wildcard patches/*.patch))
patches/%.patch.done:
	cd `grep $(basename $(notdir $@)) patches/patches.dir | awk '{print $$2}'` ; git apply $(basename $(abspath $@))
	touch $@

build: patching
	PERLLIB="$(abspath $(TARGET_SUBDIR))/dest" $(MAKE) -C $(TARGET_SUBDIR) deb
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
