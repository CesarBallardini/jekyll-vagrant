#!/bin/bash
#
##
# provision/ansible-setup.sh
# instala lo necesario para que funcione ansible
#

sudo apt-get install -y software-properties-common build-essential
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y

