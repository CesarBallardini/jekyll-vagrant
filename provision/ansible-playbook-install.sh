#!/bin/bash
#
##
# provision/ansible-playbook-install.sh
# instala roles, playbboks y variables
#

##
# instalo inventario
#

cat > /vagrant/provision/ansible/jk.inventory <<!EOF
[jk]
jk.dev  ansible_connection=local
!EOF


##
# playbook de instalacion de software
#
cat > /vagrant/provision/ansible/instala-jekyll.yml <<!EOF
- hosts: jk
  vars:
    jekyll_version: 4.3.2

  roles:
    - { role: rvm.ruby, 
	rvm1_gpg_key_server: 'hkp://keyserver.ubuntu.com:80',
        tags: ruby,
        rvm1_rubies: ['ruby-3.2.0'],
        rvm1_user: 'vagrant',
      }

    - {role: igor_mukhin.jekyll, tags: jekyll, become: false }

!EOF

##
# instalo roles
#

mkdir -p /vagrant/provision/ansible/roles/
cd /vagrant/provision/ansible/

export ANSIBLE_CONFIG=./ansible.cfg
ansible-galaxy role install rvm.ruby --roles-path ./roles/
ansible-galaxy role install igor_mukhin.jekyll --roles-path ./roles/


sudo apt-get install -y \
	acl \
        autoconf automake bison libffi-dev libgdbm-dev libncurses5-dev \
	libsqlite3-dev libtool libyaml-dev pkg-config sqlite3 \
	zlib1g-dev libgmp-dev libreadline-dev libssl-dev \

