all: packages upload

packages: firmware own-kernel qemu-srv

upload: gh-pages
	apt-repo/rm-added-debs.sh
	apt-repo/update-debs.sh
	cd apt-repo ; git commit && git push
	git push `git remote` gh-pages

firmware: gh-pages
	$(MAKE) -C edk2
	cp edk2/result/*.deb apt-repo/incoming
firmware-clean:
	$(MAKE) -C edk2 clean

own-kernel: gh-pages
	$(MAKE) -C kernel
	cp kernel/result/*.deb apt-repo/incoming
own-kernel-clean:
	$(MAKE) -C kernel clean

qemu-srv: gh-pages
	$(MAKE) -C qemu-server
	cp qemu-server/result/*.deb apt-repo/incoming
qemu-srv-clean:
	$(MAKE) -C qemu-server clean 

.build-deps:
	sudo apt-get install -y reprepro git
	touch $@

gh-pages: apt-repo/.git .build-deps
	rm -rf apt-repo/incoming
	mkdir -p apt-repo/incoming
	cd apt-repo ; git pull

apt-repo/.git:
	git branch | grep gh-pages || git branch gh-pages origin/gh-pages
	git clone . --branch gh-pages --single-branch apt-repo

clean: firmware-clean own-kernel-clean qemu-srv-clean
	rm -rf apt-repo

.PHONY: gh-pages firmware firmware-clean upload packages clean own-kernel own-kernel-clean qemu-srv qemu-srv-clean all

