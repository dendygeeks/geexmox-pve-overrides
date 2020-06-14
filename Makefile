all: packages

packages: firmware own-kernel qemu-srv pve-mgr
	apt-repo/update-debs.sh

install:
	apt-repo/add-apt-repos.sh
	apt-repo/update-debs.sh
	dpkg -i apt-repo/result/*.deb

firmware: apt-repo/incoming
	$(MAKE) -C edk2
	cp edk2/result/*.deb apt-repo/incoming

firmware-clean:
	$(MAKE) -C edk2 clean

own-kernel: apt-repo/incoming
	$(MAKE) -C kernel
	cp kernel/result/*.deb apt-repo/incoming

own-kernel-clean:
	$(MAKE) -C kernel clean

qemu-srv: apt-repo/incoming
	$(MAKE) -C qemu-server
	cp qemu-server/result/*.deb apt-repo/incoming
qemu-srv-clean:
	$(MAKE) -C qemu-server clean

pve-mgr: apt-repo/incoming
	$(MAKE) -C pve-manager
	cp pve-manager/result/*.deb apt-repo/incoming
pve-mgr-clean:
	$(MAKE) -C pve-manager clean

apt-repo/incoming:
	mkdir -p apt-repo/incoming

clean: firmware-clean own-kernel-clean qemu-srv-clean pve-mgr-clean
	rm -rf apt-repo

.PHONY: gh-pages firmware firmware-clean upload packages clean own-kernel own-kernel-clean qemu-srv qemu-srv-clean all pve-mgr pve-mgr-clean

