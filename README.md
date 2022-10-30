sh -c "$(curl -fsSL https://raw.githubusercontent.com/anttilinno/blankarch/master/install.sh)"

Or run ansible after blank install
```
ansible-playbook -i inventory.yml archlinux-playbook.yml
```
