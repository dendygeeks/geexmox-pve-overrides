TARGET_SUBDIR:=pve-edk2-firmware

all: build

.build-deps:
	grep -E '^en_US.UTF-8\s+UTF-8' /etc/locale.gen || echo 'en_US.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen
	sudo locale-gen
	sudo apt-get install build-essential git lintian debhelper iasl nasm python uuid-dev gcc-aarch64-linux-gnu python3.7-distutils -y
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
