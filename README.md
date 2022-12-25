sh -c "$(curl -fsSL https://raw.githubusercontent.com/anttilinno/blankarch/master/install.sh)"

Or run ansible after blank install
```
ansible-galaxy install gantsign.oh-my-zsh
ansible-playbook -i inventory.yml archlinux-playbook.yml
```

User password from playbook is `wanker` and it is not sensitive information
