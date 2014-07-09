#!/bin/bash
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
add-apt-repository ppa:webupd8team/java
add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update

sudo apt-get install git-core subversion meld curl terminator zsh vim apache2 php5 mysql-server libapache2-mod-php5 php5-mysql php5-xdebug phpmyadmin php-pear gettext sublime-text-installer mysql-workbench filezilla htop libreoffice google-chrome-stable oracle-java8-installer pidgin gimp inkscape

zsh
chsh
/bin/zsh
curl -L http://install.ohmyz.sh | sh
cd
git clone https://github.com/nojhan/liquidprompt.git
source liquidprompt/liquidprompt
# => Edit ~/.zshrc, add "source ~/liquidprompt/liquidprompt"


ln -s /usr/share/phpmyadmin

pear channel-discover pear.phpunit.de
pear channel-discover pear.symfony-project.com
pear install phpunit/PHPUnit-3.7.29

cp ./sublime-text-3 ~/.config/sublime-text-3/

apt-get clean
apt-get auto-remove
