#!/bin/bash
apt-get install git-core

cd ~
mkdir Tools

# Teclib'
git clone git@gitlab.prod.teclib.infra:teclib/teclib-glpi-suite.git ~/Tools
git clone git@gitlab.prod.teclib.infra:teclib/teclib-rapport-suite.git ~/Tools

cd /usr/local/bin
ln -s ~/Tools/teclib-glpi-suite/teclib-glpi-util
ln -s ~/Tools/teclib-rapport-suite/tools/teclib-make-report
