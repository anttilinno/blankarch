# Start
Follow up to the [vagrant repository](https://github.com/anttilinno/arch-vagrant)

* Install archlinux packages and docker
	```
    ansible-playbook setup.yml
	```

*User password from playbook is `wanker` and it is not sensitive information*

## Tools to install manually currently

### Install pyenv
	```
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	cd ~/.pyenv && src/configure && make -C src

	pyenv install 3.12.3
	```

### Install volta to manage node versions

	```
	curl https://get.volta.sh | bash
	volta install node@20
	```

// TODO: Add docker
// TODO: Structure repository
