# Propriété
chaine = str() 
tabBinaire = []
nvlChaine = ''

# Fct convertion decimal => binaire
def binary(parameter_list) :

    for nbr in chaineExplose :
        liste = []

        while nbr != 0 :
            liste.append(int(nbr) % 2)
            nbr = int(nbr) // 2

        liste.reverse()

        if (len(liste) < 8) :
            while len(liste) < 8 :
                liste.insert(0, 0)

        

        tabBinaire.append(liste)


    return tabBinaire

# Fct convertion binaire => decimal
# def decimal(parameter_list) :
    

############ Début du script ############

# Récupére la valeur entrer
print("Tapez votre adresse Ip :")
chaine = input()

# Transforme la chaine sous forme de list 
chaineExplose = chaine.split('.')

# Appel de la fct de convertion décimal => binaire
maSuperChaine = binary(chaineExplose)

# Test
# print(maSuperChaine)






