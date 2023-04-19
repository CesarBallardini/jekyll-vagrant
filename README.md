# Jekyll Blog on a Vagrant virtual machine

As a user with a Blog hosted on Github Pages<br>
I need a way to post and keep it's dependencies updated


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
