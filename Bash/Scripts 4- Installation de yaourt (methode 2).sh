#!/bin/bash

#==============================================================================================================
#
# Auteur  : Alexandre Maury
# License : Distributed under the terms of GNU GPL version 2 or later
#
# GitHub : https://github.com/d3v-donkey
#==============================================================================================================

# Couleurs Bash

#    30m : noir
#    31m : rouge
#    32m : vert
#    33m : jaune
#    34m : bleu
#    35m : rose
#    36m : cyan
#    37m : gris

#==============================================================================================================
clear
echo -e  "\e[32m                                                  _____    ____   __      __    _______   ______              __  __ ";
echo -e  "\e[32m                                                 |  __ \  |___ \  \ \    / /   |__   __| |  ____|     /\     |  \/  |";
echo -e  "\e[32m                                                 | |  | |   __) |  \ \  / /       | |    | |__       /  \    | \  / |";
echo -e  "\e[32m                                                 | |  | |  |__ <    \ \/ /        | |    |  __|     / /\ \   | |\/| |";
echo -e  "\e[32m                                                 | |__| |  ___) |    \  /         | |    | |____   / ____ \  | |  | |";
echo -e  "\e[32m                                                 |_____/  |____/      \/          |_|    |______| /_/    \_\ |_|  |_|";

echo ""

#================= Test connection
ping -c 4 google.com 
test=$?

if [ "$test" -eq 0 ]; then
    echo -e "\e[33m[-- Network connecter, suite du programme...]";
else
	echo -e "\e[31m[-- S'il vous plait connecter Network...]";
	sleep 3s && exit 0
fi

sudo tee -a /etc/pacman.conf >/dev/null << 'EOF'
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
EOF

sudo pacman -Syy yaourt

