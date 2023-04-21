# Jekyll Blog on a Vagrant virtual machine

As a user with a Blog hosted on Github Pages<br>
I need a way to post and keep it's dependencies updated

* Install dependencies

  * Vagrant
  * Virtualbox
  * Git
  * Vagrant plugins:

```bash
vagrant plugin install vagrant-reload
```


* Launch the VM with all dependencies: Ruby, Jekyll, etc.

```bash
git clone https://github.com/CesarBallardini/jekyll-vagrant.git
cd jekyll-vagrant/

time vagrant up

```

* Login on the VM

```bash
vagrant ssh
```

On Microsoft Windows 11 that command gives me a shell on the VM, but Crtl-C ends it. 
So I have a script and an alias as a workaround:

```bash
#!/bin/bash
# ~/bin/vagrant-ssh.sh

PORT=$(vagrant ssh-config | grep Port | grep -o '[0-9]\+')
IDENTITY_FILE=$(vagrant ssh-config | grep IdentityFile | cut -d\  -f4)
ssh -q \
    -o UserKnownHostsFile=/dev/null \
    -o StrictHostKeyChecking=no \
    -i $IDENTITY_FILE  \
    vagrant@localhost \
    -p $PORT \
    "$@"

# Ref: https://github.com/hashicorp/vagrant/issues/12838#issuecomment-1499374359
```


```bash
alias vagrant-ssh='~/bin/vagrant-ssh.sh'
```

* Clone the blog and make it run locally

```bash
cd 
git clone https://github.com/CesarBallardini/CesarBallardini.github.io.git
cd CesarBallardini.github.io/

# install dependencies
bundle install

# build the static site
bundle exec jekyll build

# serve locally the site
bundle exec jekyll serve --host 192.168.33.10 --incremental

```

* Configure Git

```bash
git config --global user.email "cesar.ballardini@gmail.com"
git config --global user.name "Cesar Ballardini"

```

* Make your changes, and push them to Github
