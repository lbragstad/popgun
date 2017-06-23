#!/bin/bash
NAME=$1

sudo lxc-create -n $NAME -t ubuntu -- -r xenial
sudo lxc-start -n $NAME

while true
do
    IP=`sudo lxc-info -n $NAME | awk '/IP/{print $2}'`
    if [ -z $IP ]; then
        sleep 2
    else
        break
    fi
done

source .venv/bin/activate
export ANSIBLE_HOST_KEY_CHECKING=False

# Bootstrap `root` user with authorized ssh key

ansible-playbook tasks/bootstrap_ssh_keys.yml -i "$IP," -u ubuntu -e 'ansible_python_interpreter=/usr/bin/python3' -k -K
 
# Prepare container

 ansible-playbook tasks/main.yml -i "$IP," -u root -e 'ansible_python_interpreter=/usr/bin/python3'

# Create a new set of ssh keys

ansible-playbook tasks/generate_ssh_keys.yml -i "$IP," -u root -e 'ansible_python_interpreter=/usr/bin/python3'

deactivate
