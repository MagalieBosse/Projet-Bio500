#Dependance
library(targets)
tar_option_set(packages=c("MASS","igraph"))

#Scripts R referance
source("./R/projet bio500.R")

# Origine des donnees (code pris dans l'exemple du prof, ajuster pour nous)
list(
  tar_target(
    name = path, # Cible (a changer?)
    command = "./donnees BIO500/data.txt", # Emplacement du fichier
    format = "file"
  ), 

  tar_target(
    name = data, # Cible pour l'objet de données
    command = read.table(path) # Lecture des données
  ),   
  tar_target(
    resultat_modele, # Cible pour le modèle 
    mon_modele(data) # Exécution de l'analyse
  ),
  tar_target(
    figure, # Cible pour l'exécution de la figure
    ma_figure(data, resultat_modele) # Réalisation de la figure
  )
)

#Nettoyer les donnees

#Cours

#Etudiants

#Collaboration

#Creation des tables

#Requete 1

#Requete 2

#Requete 3

#Requete 4

#Requete 5

#Requete 6

#Requete 7

#Figure 1. reseau de collaboration

#Figure 2. nombre de collaboration par session

#Figure 3. nombre de collaboration par cours

#Tableau 1. A CHOISIR!

#Fin, reste a ecrire le rapport