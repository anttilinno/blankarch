# Start
Follow up to the [vagrant repository](https://github.com/anttilinno/arch-vagrant)

* Run ansible after blank install
	```
	ansible-playbook -i inventory.yaml archlinux-playbook.yaml --limit "archlinux"
	```

*User password from playbook is `wanker` and it is not sensitive information*

* Install docker

    ```
    ansible-playbook -i inventory.yml playbook.yml --limit "docker"
    ```

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
