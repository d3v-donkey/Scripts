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
echo -e         "|                                     "$ROUGE" -- Script Collections --                                    "$NORMAL"""|"
echo -e "$VERT" "--------------------------------------------------------------------------------------------------""$NORMAL"
echo ""
echo -e "$BLEU" " V1" "$NORMAL"
echo ""


var1="15"
var2="0"

while test $var2 != $var1
do
    echo -e "$CYAN" "-- Voulez vous Installez Yaourt (y/N) N pour quittez le scripts..." "$NORMAL"
    read -r var 

    if [ "$var" == "y" ] || [ "$var" == "Y" ]; then
        echo "installation des dependences"

        sudo pacman -S curl yajl 
        mkdir /tmp/aur

        cd /tmp/aur

        echo "installation des package-query"

        wget https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
        tar -xzf package-query.tar.gz

        cd package-query
        makepkg
        sudo pacman -U *.xz

        cd ../
        rm -rf package-query


        echo "installation de yaourt"

        wget https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz

        tar -xzf yaourt.tar.gz
        cd yaourt
        makepkg

        sudo pacman -U *.xz
        cd ../

        rm -rf yaourt
        break

    elif [ "$var" == "n" ] || [ "$var" == "N" ]; then
        
        echo "=== Fermeture du Script By d3v-donkey ======= GitHub: https://github.com/d3v-donkey"
        exit

else
    echo "-- Mauvais choix"

fi

done

echo "=== Installation terminé Script By d3v-donkey ======= GitHub: https://github.com/d3v-donkey"
exit
