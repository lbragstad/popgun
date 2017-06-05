# popgun
Ansible plays for bootstrapping a container for development.

## usage

Create a container

`sudo lxc-create -n $NAME -t ubuntu -- -r xenial`

Bootstrap `root` user with authorized ssh key

```
ansible-playbook tasks/bootstrap-ssh-key.yml \
  -i "$IP," -u ubuntu \
  -e 'ansible_python_interpreter=/usr/bin/python3' -K -k
```

Prepare container

```
ansible-playbook tasks/main.yml -i "$IP," -u root \
  -e 'ansible_python_interpreter=/usr/bin/python3'
```

Create a new set of ssh keys

```
ansible-playbook tasks/generate_ssh_keys.yml -i "$IP," -u root \
  -e 'ansible_python_interpreter=/usr/bin/python3'
```
