export LANG=C

TARGET_SUBDIR:=pve-kernel

all: build

.build-deps: Makefile
	sh ../prepare.sh
	sudo apt-get install -y --allow-unauthenticated dh-python libdw-dev libnuma-dev libslang2-dev lz4 sphinx-common git make gcc dpkg-dev asciidoc bc bison flex libiberty-dev libssl-dev lintian xmlto libelf-dev debhelper libpve-common-perl rsync
	touch $@

upstream: .build-deps
	#git submodule update --init --recursive $(TARGET_SUBDIR)

patching: upstream $(addsuffix .done, $(wildcard patches/*.patch))
patches/%.patch.done:
	cd `grep $(basename $(notdir $@)) patches/patches.dir | awk '{print $$2}'` ; git apply $(basename $(abspath $@))
	touch $@

build: patching
	$(MAKE) -C $(TARGET_SUBDIR) 
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
