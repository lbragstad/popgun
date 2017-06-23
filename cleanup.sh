#!/bin/bash
NAME=$1

sudo lxc-stop -n $NAME
sudo lxc-destroy -n $NAME
