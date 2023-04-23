sh -c "$(curl -fsSL https://raw.githubusercontent.com/anttilinno/blankarch/master/install.sh)"

Or run ansible after blank install
```
ansible-playbook -i inventory.yaml archlinux-playbook.yaml
```

User password from playbook is `wanker` and it is not sensitive information
