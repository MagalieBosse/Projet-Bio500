#_targets.R File

#Dependances#
library(targets)
tar_option_set(packages=c("targets","dplyr", "rmarkdown", "tidyverse", "RSQLite", "igraph","stringr"))

#Pipeline#

#Nettoyage#
source("R/nettoyage_v2.R")
source("R/basedonnees.R")
source("R/analyse.R")
source("R/Figures.R")

#definir source donnees (fichiers excels)
list(
  tar_target(
    name = path,
    command = "./donnees_BIO500",
    format = file
  ),
  
#base de donnees
  tar_target(
    name = data, # Cible pour l'objet de donnees
    command = list.files(path, full.names = TRUE) # Lecture des donnees
  ),

#nettoyer les donnees  
  tar_target(
    name = nettoyage, #fonction qui nettoye toutes les bases de donnees et les fusionnent
    command = clean_data(data)
  ),

#creation sql#
  tar_target(
   name = table_sql, #fonction qui cree toutes les tables sql
   command = create_sql(nettoyage)
    ),

#creation des requetes sql
    tar_target(
      name = requete_donnees, #fonction qui utilise ces tables pour faire des analyses/requetes
      command = requetes(table_sql)
    ),

#figures
    tar_target(
      name = figures_final, #fonction qui cree et enregistre toutes nos figures
      command = fig_final(requete_donnees)
    )
)
tar_make()
