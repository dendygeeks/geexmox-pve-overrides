packages: firmware own-kernel

upload: gh-pages 
	apt-repo/update-debs.sh
	git commit

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

.build-deps:
	sudo apt-get install -y reprepro git
	touch $@

gh-pages: apt-repo/.git .build-deps
	rm -rf apt-repo/incoming
	mkdir -p apt-repo/incoming

apt-repo/.git:
	git branch | grep gh-pages || git branch gh-pages origin/gh-pages
	git clone . --branch gh-pages --single-branch apt-repo

clean: firmware-clean own-kernel-clean
	rm -rf apt-repo

.PHONY: gh-pages firmware firmware-clean upload packages clean own-kernel own-kernel-clean

