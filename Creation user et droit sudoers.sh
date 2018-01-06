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
echo -e "$BLEU" "Creation d'utilisateur et affectation des droits sudo" "$NORMAL"
echo ""

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