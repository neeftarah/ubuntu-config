#!/bin/bash
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
add-apt-repository ppa:webupd8team/java
add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update

# logiciels de versionning et comparaison
apt-get install git-core
apt-get install subversion
apt-get install meld
apt-get install curl

# Installation d'une console efficace
apt-get install terminator
apt-get install zsh
zsh
chsh
/bin/zsh
curl -L http://install.ohmyz.sh | sh
cd
git clone https://github.com/nojhan/liquidprompt.git
source liquidprompt/liquidprompt
apt-get install vim
# => Edit ~/.zshrc, add "source ~/liquidprompt/liquidprompt"

# installation LAMP
apt-get install apache2
apt-get install php5
apt-get install mysql-server
apt-get install libapache2-mod-php5
apt-get install php5-mysql
apt-get install php5-xdebug
apt-get install phpmyadmin
apt-get install php-pear
apt-get install gettext

ln -s /usr/share/phpmyadmin

pear channel-discover pear.phpunit.de
pear channel-discover pear.symfony-project.com
pear install phpunit/PHPUnit-3.7.29

# Dev
apt-get install sublime-text-installer
cp ./sublime-text-3 ~/.config/sublime-text-3/

# Outils divers
apt-get install mysql-workbench
apt-get install filezilla
apt-get install htop
apt-get install libreoffice
apt-get install google-chrome-stable
apt-get install oracle-java8-installer
apt-get install pidgin

#infographie
apt-get install gimp
apt-get install inkscape

# Nétoyage
apt-get clean
apt-get auto-remove
