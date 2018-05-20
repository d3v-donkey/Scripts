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

read -p "-- Entrer votre nom d'utilisateur souhaitez... : " user
user_present="`cat /etc/passwd | grep $user | grep -v grep | wc -l`"
  if [ "$user_present" == "1" ]; then
    echo -e "\nUtilisateur $user déjà creer .. "
    usermod -aG wheel $user
    passwd $user
  else
    adduser $user
    usermod -aG wheel $user
    passwd $user
  fi
#deluser --remove-home $user


read -p "Voulez-vous ajouter cet utilisateur à Sudoers (y/N)? : " response
sudoers_present="`cat /etc/sudoers | grep $user | grep -v grep | wc -l`" 
if [ "$sudoers_present" -ge "1" ]; then
    echo -e "\n Utilisateur déja présents dans sudoers !!"
else
    if [ $response == "Y" ] || [ $response == "y" ]; then
       	sudo sed -i "95 i $user   ALL=(ALL) ALL" /etc/sudoers
		echo " $user ajouté dans sudoers"
    else
       	exit
	fi
fi
