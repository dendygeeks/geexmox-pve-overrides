all: .build-deps


.build-deps:
	grep -E '^en_US.UTF-8\s+UTF-8' /etc/locale.gen || echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
	sudo locale-gen
	sudo apt-get update
	sudo apt-get install build-essential git lintian debhelper iasl nasm python uuid-dev -y
	touch $@

.PHONY: all
