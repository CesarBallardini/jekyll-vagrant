#!/usr/bin/env bash

# config Git to be able to push into the origin repo of the blog
git config --global user.email "cesar.ballardini@gmail.com"
git config --global user.name "Cesar Ballardini"


git clone https://github.com/CesarBallardini/CesarBallardini.github.io.git
cd CesarBallardini.github.io/

bundle install
bundle exec jekyll build

# serve the blog locally:
# bundle exec jekyll serve --host 192.168.33.10 --incremental

