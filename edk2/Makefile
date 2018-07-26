all: build

.build-deps:
	grep -E '^en_US.UTF-8\s+UTF-8' /etc/locale.gen || echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
	sudo locale-gen
	sudo apt-get update
	sudo apt-get install build-essential git lintian debhelper iasl nasm python uuid-dev -y
	touch $@

upstream: .build-deps
	git submodule update --init --recursive

patching: upstream $(addsuffix .done, $(wildcard patches/*.patch))
patches/%.patch.done:
	cd `grep $(basename $(notdir $@)) patches/patches.dir | awk '{print $$2}'` ; git apply $(basename $(abspath $@))
	touch $@

build: patching
	$(MAKE) -C pve-edk2-firmware
	rm -rf result
	mkdir -p result
	cp pve-edk2-firmware/*.deb result

clean:
	git submodule foreach --recursive git reset --hard
	git submodule foreach --recursive git clean -fd 
	rm -f patches/*.done
	rm -rf result

.PHONY: all upstream patching clean build
