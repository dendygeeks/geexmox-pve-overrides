packages: firmware

upload: gh-pages 
	apt-repo/update-debs.sh
	git commit

firmware: gh-pages
	$(MAKE) -C edk2
	cp edk2/result/*.deb apt-repo/incoming
firmware-clean:
	$(MAKE) -C edk2 clean

.build-deps:
	sudo apt-get install -y reprepro git
	touch $@

gh-pages: apt-repo/.git .build-deps
	rm -rf apt-repo/incoming
	mkdir -p apt-repo/incoming

apt-repo/.git:
	git branch | grep gh-pages || git branch gh-pages origin/gh-pages
	git clone . --branch gh-pages --single-branch apt-repo

clean: firmware-clean
	rm -rf apt-repo

.PHONY: gh-pages firmware firmware-clean upload packages clean

