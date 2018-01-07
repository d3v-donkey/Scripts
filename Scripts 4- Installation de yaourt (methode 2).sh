#! /bin/bash

#==============================================================================================================
#                                
# Auteur  : Alexandre Maury
# License : Distributed under the terms of GNU GPL version 2 or later
# 
# GitHub : https://github.com/d3v-donkey
#==============================================================================================================
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
ROSE="\\033[1;35m"
BLEU="\\033[1;34m"
BLANC="\\033[0;02m"
BLANCLAIR="\\033[1;08m"
JAUNE="\\033[1;33m"
CYAN="\\033[1;36m"
echo    ""
                                                        
echo -e "$VERT" "--------------------------------------------------------------------------------------------------""$NORMAL"
echo -e         "|                                                                                                  ""|"
echo -e         "|  by""$VERT" "d3v-donkey." "$CYAN""(GitHub: https://github.com/d3v-donkey)                                          "$NORMAL"""|"
echo -e         "|                                                                                                  ""|"
echo -e         "|                                     "$ROUGE" -- Scripts Collections --                                    "$NORMAL"""|"
echo -e "$VERT" "--------------------------------------------------------------------------------------------------""$NORMAL"
echo ""
echo -e "$BLEU" " Installation de yaourt (methode 2)" "$NORMAL"
echo "Il faut posséder les droits sudoers"

sudo echo '[archlinuxfr]' >> /etc/pacman.conf 
sudo echo 'SigLevel = Never' >> /etc/pacman.conf
sudo echo 'Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

sudo pacman -Sy yaourt

