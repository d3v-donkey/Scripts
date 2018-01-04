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
echo -e "$BLEU" " Formatage et partitionnement V1 EFI ou BIOS" "$NORMAL"
echo ""

vble_bcl=0  vble1_bcl=1 
vble_bcl1=1 vble2_bcl=2
vble_bcl2=2 vble3_bcl=3
vble_bcl3=3 vble4_bcl=4

vble_bcl4=0  vble5_bcl=1

fonct_form() {
    while test  $vble_bcl != $vble1_bcl
    do
        fdisk -l
        echo -e "$CYAN" "-- Quel disque souhaitez-vous formatter..." "$NORMAL"
        read -r form

        echo -e "$CYAN" "-- Nombre de passe... ex: pour 2 fois, saisir 2" "$NORMAL"
        read -r pass

        dd if=/dev/zero of=/dev/$form bs=512 count=$pass

        echo -e "$CYAN" "Formatage Terminer" "$NORMAL"
        fdisk -l

        echo -e "$CYAN" "-- Souhaitez-vous formatez un autres disque y/N" "$NORMAL"
        read -r fin

        if [ "$fin" == "y" ] || [ "$fin" == "Y" ]; then
            echo -e "$CYAN" "-- C'est parti" "$NORMAL"

        elif [ "$fin" == "n" ] || [ "$fin" == "N" ]; then
            vble_bcl=1
            
        fi

    done
}

fonct_part() {
    while test $vble_bcl1 != $vble2_bcl
    do
        fdisk -l
        echo -e "$CYAN" "-- Quel disque souhaitez-vous partitionner..." "$NORMAL"
        read -r form

        echo -e "$CYAN" "-- Partitionnement BIOS ou EFI... Saisir sur le prompt BIOS ou EFI" "$NORMAL"
        read -r var6

        if [ "$var6" == "efi" ] || [ "$var6" == "EFI" ]; then
            echo -e "$CYAN" "-- Table de partitions GPT..." "$NORMAL"

            echo -e "$CYAN" "-- Valeurs par defaut..." "$NORMAL"
            echo -e "$VERT" "sda1 partion / 20GiB ext4" "$NORMAL"
            echo -e "$VERT" "sda2 partion boot 512MiB F32" "$NORMAL"
            echo -e "$VERT" "sda3 partion swap 16GiB" "$NORMAL"
            echo -e "$VERT" " -- Rappel : La partition home (sda4) prendra toute la places restante -- " "$NORMAL"

            while test  $vble_bcl2 != $vble3_bcl
            do
                echo -e "$CYAN" "-- Souhaitez-vous un partitionnement automatique (y/N)... Attention le disque sera effacé !!" "$NORMAL"
                read -r var4

                if [ "$var4" == "y" ] || [ "$var4" == "Y" ]; then
                    echo -e "$CYAN" "-- Montage des partitions en cours (table GPT)..." "$NORMAL"

                    # Préparation 
                    sgdisk -Z /dev/$form 
                    sgdisk -a 2048 -o /dev/$form 

                    # Creation des partitions
                    sgdisk -n 0:0:+20G -t 0:8300 -c 0:"/" /dev/$form
                    sgdisk -n 0:0:+512M -t 0:ef00 -c 0:"boot" /dev/$form
                    sgdisk -n 0:0:+16G -t 0:8200 -c 0:"swap" /dev/$form
                    sgdisk -n 0:0:0 -t 0:8300 -c 0:"home" /dev/$form
                    sgdisk -p /dev/$form
                    #partprobe /dev/$form
              
                    mkfs.ext4 /dev/$form 1
                    mkfs.fat -F32 /dev/$form 2
                    mkfs.ext4 /dev/$form 4

                    mkswap /dev/$form 3
                    swapon /dev/$form 3

                    mount /dev/$form 1 /mnt
                    mkdir /mnt/{boot,home}
                    mount /dev/$form 2 /mnt/boot
                    mount /dev/$form 4 /mnt/home

                    vble_bcl2=3
                    vble_bcl1=2

                elif [ "$var4" == "n" ] || [ "$var4" == "N" ]; then
                    echo -e "$ROUGE" "demarrage de cgdisk" "$NORMAL"
                    cgdisk /dev/$form
                    vble_bcl2=3
                    vble_bcl1=2
                else
                    echo "-- Je n'ai pas compris, Veuillez repeter svp..."
                fi
            done
        
        elif [ "$var6" == "bios" ] || [ "$var6" == "BIOS" ]; then
            echo -e "$CYAN" "-- Table de partitions MS-DOS (MBR)..." "$NORMAL"

            echo -e "$VERT" "-- Partitionnement automatique Table BIOS/MBR..." "$NORMAL"
            echo -e "$VERT" "-- 100MiB > sda1 partition boot" "$NORMAL"
            echo -e "$VERT" "-- 16GiB > sda2  partition swap" "$NORMAL"
            echo -e "$VERT" "-- 35GiB > sda3 partition / " "$NORMAL"
            echo -e "$VERT" "-- La totalité qui reste sur le support de partitionnement > sda4 partition /home " "$NORMAL"

            while test $vble_bcl3 != $vble4_bcl
            do
                echo -e "$CYAN" "-- Souhaitez-vous un partitionnement automatique (y/N)... Attention le disque sera effacé !!" "$NORMAL"
                read -r var4

                if [ "$var4" == "y" ] || [ "$var4" == "Y" ]; then
                    echo -e "o\nn\np\n1\n\n+100M\na\nn\np\n2\n\n+16G\nn\np\n3\n\n+35G\nn\np\n4\n\n\nw" | fdisk /dev/$form
                    
                    echo -e "$CYAN" "-- Montage des partitions en cours (table MBR)..." "$NORMAL"

                    mkfs.ext2 /dev/$form 1
                    mkfs.ext4 /dev/$form 3
                    mkfs.ext4 /dev/$form 4

                    mkswap /dev/$form 2
                    swapon /dev/$form 2

                    mount /dev/$form 3 /mnt
                    mkdir /mnt/{boot,home}
                    mount /dev/$form 1 /mnt/boot
                    mount /dev/$form 4 /mnt/home

                    vble_bcl3=4
                    vble_bcl1=2

                elif [ "$var4" == "n" ] || [ "$var4" == "N" ]; then
                    echo -e "$ROUGE" "demarrage de cfdisk" "$NORMAL"
                    cfdisk /dev/$form
                    vble_bcl3=4
                    vble_bcl1=2
                else
                    echo "-- Je n'ai pas compris, Veuillez repeter svp..."
                fi
            done
        else
            echo "-- Je n'ai pas compris, Veuillez repeter svp...."

        fi
    
    done
    vble_bcl4=1
}

fonct_exit() {
    echo -e "$CYAN" "Voulez vous quittez le scripts d'installation (y/N) ?" "$NORMAL"
    read -r var 

    if [ "$var" == "y" ] || [ "$var" == "Y" ]; then
        echo "=== Fermeture du Script By d3v-donkey et redemarrage de la machine ======= GitHub: https://github.com/d3v-donkey"
        exit

    elif [ "$var" == "n" ] || [ "$var" == "N" ]; then
        echo "Retours au menu"
    fi
}

echo -e "$ROUGE" "-- INFO" "$NORMAL"

echo -e "$VERT" "-- Partitionnement automatique Table BIOS/MBR..." "$NORMAL"
echo -e "$VERT" "-- 100MiB > sda1 partition boot" "$NORMAL"
echo -e "$VERT" "-- 12GiB > sda2  partition swap" "$NORMAL"
echo -e "$VERT" "-- 35GiB > sda3 partition / " "$NORMAL"
echo -e "$VERT" "-- La totalité qui reste sur le support de partitionnement > sda4 partition /home " "$NORMAL"

echo -e "$VERT" "-- Partitionnement automatique Table EFI/GPT..." "$NORMAL"
echo -e "$VERT" "-- 20GiB > sda1 partition /" "$NORMAL"
echo -e "$VERT" "-- 512MiB > sda2  partition boot" "$NORMAL"
echo -e "$VERT" "-- 16GiB > sda3 partition swap " "$NORMAL"
echo -e "$VERT" "-- La totalité qui reste sur le support de partitionnement > sda4 partition /home " "$NORMAL"

while  test $vble_bcl4 != $vble5_bcl  
do 
    echo -e "$VERT" "=============================" "$NORMAL" " -- MENU SCRIPTS -- " "$VERT" "==================================" "$NORMAL"
    echo -e "$VERT" "=======================================================================================" "$NORMAL"
    echo -e "$BLANCLAIR" " - 1 - Formatage des disques - =========================================================" "$NORMAL"
    echo -e "$VERT" "=======================================================================================" "$NORMAL"
    echo -e "$BLANCLAIR" " - 2 - Partitionnement auto/manuel- ====================================================" "$NORMAL"
    echo -e "$VERT" "=======================================================================================" "$NORMAL"
    echo -e "$BLANCLAIR" " - 3 - Exit - =========================================================================" "$NORMAL"
    echo -e "$VERT" "=======================================================================================" "$NORMAL"
    echo -e "$CYAN" "Entrer votre choix !!" "$NORMAL"
    read -r sel

    case $sel in
        1) fonct_form ;; 
        2) fonct_part ;; 
        3) fonct_exit ;;
        
        *) echo "Choix invalide" 
    esac
done