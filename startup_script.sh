#!/bin/bash

echo user: `whoami`
echo path: `pwd`
sudo -u appuser bash
echo change user: `whoami`


echo "Start install Ruby"

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
sudo -u appuser `source ~/.rvm/scripts/rvm`
sudo -u appuser `rvm requirements`
sudo -u appuser `rvm install 2.4.1`
sudo -u appuser `rvm use 2.4.1 --default`
sudo -u appuser `gem install bundler -V --no-ri --no-rdoc`
echo ruby version: `ruby -v`
echo gem version: `gem -v bundler`

echo "End install Ruby"



echo "Start install MongoDB"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod

echo "End install MongoDB"



echo "Start deploy"

sudo -u appuser `git clone https://github.com/Artemmkin/reddit.git /home/appuser/reddit`
cd /home/appuser/reddit
# git clone https://github.com/Artemmkin/reddit.git ~/reddit
# cd ~/reddit
sudo -u appuser `bundle install`
sudo -u appuser `puma -d`

echo "End deploy"

