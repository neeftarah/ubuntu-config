#!/bin/sh
# Variable d'installation
PHP_VERSION='php8.2'

# Constantes
RED='\033[1;31m'
GREEN='\33[1;32m'
LIGHT_BLUE='\33[0;36m'
BLUE='\33[1;34m'
NC='\033[0m' # No Color


# Start from home directory
cd ~

# === MISE À JOUR DE LA LISTE DES PAQUETS ===
echo "\n${BLUE}=== MISE À JOUR DE LA LISTE DES PAQUETS ===${NC}"
sudo apt update -qq  # Met à jour la liste des paquets disponibles (mais pas les paquets eux-mêmes).


# === MISE À JOUR DES PAQUETS  ===
echo "\n${BLUE}=== MISE À JOUR DES PAQUETS ===${NC}"
sudo apt full-upgrade -y -qq  # Met à jour le système en supprimant/installant/mettant à jour les paquets.


# === INSTALLATION DE QUELQUES UTILITAIRES ===
echo "\n${BLUE}=== INSTALLATION DE QUELQUES UTILITAIRES ===${NC}"
sudo apt install -yqq htop terminator vim curl wget gpg apt-transport-https snapd gimp inkscape
sudo snap install core
sudo snap install snap-store

# === INSTALLATION DE GIT ===
echo "\n${BLUE}=== INSTALLATION DE GIT ===${NC}"
sudo apt install -yqq git-core

git_username=`git config --global user.name`
if [ ! -z git_username ]; then
    echo "${LIGHT_BLUE}What is your GIT user.name?${NC}"
    read GIT_NAME
    echo "${LIGHT_BLUE}What is your GIT user.email?${NC}"
    read GIT_EMAIL

    git config --global user.name "${GIT_NAME}"
    git config --global user.email "${GIT_EMAIL}"
fi



# === INSTALLATION DE PHP ===
echo "\n${BLUE}=== INSTALLATION DE PHP ===${NC}"
echo "${LIGHT_BLUE} - Installation des dépendances${NC}"
sudo apt install -y -qq lsb-release apt-transport-https ca-certificates 

echo "\n${LIGHT_BLUE} - Téléchargement et enregistrement des dépôt PPA de Ondřej SURY${NC}"
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list

echo "\n${LIGHT_BLUE} - Mise à jour de la liste des dépôts${NC}"
sudo apt update -qq  # Met à jour la liste des paquets avec les paquets PHP SURY

echo "\n${LIGHT_BLUE}- Installation de PHP${NC}"
sudo apt install -y -qq ${PHP_VERSION}

echo "\n${LIGHT_BLUE}- Installation des extensions de PHP${NC}"
sudo apt install -y -qq ${PHP_VERSION}-common
sudo apt install -y -qq ${PHP_VERSION}-xml
sudo apt install -y -qq ${PHP_VERSION}-zip
sudo apt install -y -qq ${PHP_VERSION}-intl
sudo apt install -y -qq ${PHP_VERSION}-gd
sudo apt install -y -qq ${PHP_VERSION}-bz2
sudo apt install -y -qq ${PHP_VERSION}-curl
sudo apt install -y -qq ${PHP_VERSION}-mbstring
sudo apt install -y -qq ${PHP_VERSION}-xsl
sudo apt install -y -qq ${PHP_VERSION}-sqlite3

# === INSTALLATION DE COMPOSER ===
echo "\n${BLUE}=== INSTALLATION DE COMPOSER ===${NC}"
if ! command -v composer >/dev/null # On installe composer seulement s'il n'est pas encore installé
then
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
else
    echo "${GREEN}composer est déjà installé${NC}"
    composer --version
fi

# === INSTALLATION DE PHPUNIT ===
echo "\n${BLUE}=== INSTALLATION DE PHPUNIT ===${NC}"
if ! command -v phpunit >/dev/null # On installe phpunit seulement s'il n'est pas encore installé
then
    wget https://phar.phpunit.de/phpunit.phar
    chmod +x phpunit.phar
    sudo mv phpunit.phar /usr/local/bin/phpunit
    phpunit --version
else
    echo "${GREEN}phpunit est déjà installé${NC}"
    phpunit --version
fi

# === INSTALLATION DE SYMFONYSYMFONY CLI ===
echo "\n${BLUE}=== INSTALLATION DE SYMFONY CLI ===${NC}"
if ! command -v symfony > /dev/null # Si Symfony CLI n'est pas encore installé, on l'installe
then
    curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
    sudo apt install symfony-cli
else
    echo "${GREEN}Symfony CLI est déjà installé${NC}"
    symfony -V
fi


# === INSTALLATION DE NODE.JS, NVM et YARN ===
echo "\n${BLUE}=== INSTALLATION DE NODE.JS, NVM et YAR ===${NC}"
echo "\n${BLUE}=== INSTALLATION DE SYMFONY CLI ===${NC}"
if ! command -v node > /dev/null # Si Node n'est pas encore installé, on l'installe
then
    sudo snap install node --classic # node
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash # nvm

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install -yqq yarn # yarn
else
    echo "${GREEN}Node est déjà installé${NC}"
    node_version=`node -v`
    yarn_version=`yarn -v`
    echo "node: $node_version"
    echo "yarn: $yarn_version"
fi


# === INSTALLATION DE APACHE ===
echo "\n${BLUE}=== INSTALLATION DE APACHE ===${NC}"
sudo apt install -yqq apache2 libapache2-mod-php
sudo service apache2 start
echo ""
sudo apache2 -v
STATUS="$(sudo systemctl is-active apache2)"
if [ "${STATUS}" = "active" ]; then
    echo "${GREEN}Service is running${NC}"
else 
    echo "${RED}Service not running...${NC}"  
    exit 1  
fi


# === INSTALLATION DE VSCODE ===
echo "\n${BLUE}=== INSTALLATION DE VSCODE ===${NC}"
if ! command -v code >/dev/null # Si VSCode n'est pas encore installé, on l'installe
then
    sudo snap install code --classic
else
    echo "${GREEN}Visual Studio Code est déjà installé${NC}"
fi


# === INSTALLATION DE POSTMAN ===
echo "\n${BLUE}=== INSTALLATION DE POSTMAN ===${NC}"
if ! command -v postman >/dev/null # Si Postman n'est pas encore installé, on l'installe
then
    sudo snap install postman
else
    echo "${GREEN}Postman est déjà installé${NC}"
fi


# === INSTALLATION DE PHPSTORM ===
echo "\n${BLUE}=== INSTALLATION DE PHPSTORM ===${NC}"
if ! command -v phpstorm >/dev/null # Si PhpStorm n'est pas encore installé, on l'installe
then
    sudo snap install phpstorm --classic
else
    echo "${GREEN}PhpStorm est déjà installé${NC}"
fi


# === INSTALLATION DE GOOGLE CHROME ===
echo "\n${BLUE}=== INSTALLATION DE GOOGLE CHROME ===${NC}"
if ! command -v google-chrome >/dev/null # Si Google Chrome n'est pas encore installé, on l'installe
then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -ycc ./google-chrome*.deb
    rm -f ./google-chrome*.deb
else
    echo "${GREEN}Google Chrome est déjà installé${NC}"
fi

# === INSTALLATION DE DOCKER ===
echo "\n${BLUE}=== INSTALLATION DE DOCKER ===${NC}"
if ! command -v docker >/dev/null # Si Docker n'est pas encore installé, on l'installe
then
    sudo apt install -ycc gnome-terminal
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

else
    echo "${GREEN}Docker est déjà installé${NC}"
fi


# === INSTALLATION DE DBEAVER ===
echo "\n${BLUE}=== INSTALLATION DE DBEAVER ===${NC}"
sudo snap install dbeaver-ce



# === INSTALLATION DE ZSH ===
echo "\n${BLUE}=== INSTALLATION DE ZSH ===${NC}"
echo "${BLUE}-> Installation de ZSH ===${NC}"
sudo apt install -yqq zsh # installation de zsh

if [ ! -d ".oh-my-zsh" ]; then
    echo "${BLUE}-> Installation de oh-my-zsh${NC}"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # oh-my-zsh
fi

if [ ! -d ".oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "${BLUE}-> Installation de zsh-syntax-highlighting${NC}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting # zsh-syntax-highlighting
fi

if [ ! -f ".oh-my-zsh/themes/bullet-train.zsh-theme" ]; then
    echo "${BLUE}-> Installation du theme bullet-train${NC}"
    sudo apt install -yqq ttf-ancient-fonts # 
    cd ~/.oh-my-zsh/themes && wget https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme # bullet-train theme
    cd ~
fi


echo "\n${GREEN}=== DONE ===${NC}\n\n"
