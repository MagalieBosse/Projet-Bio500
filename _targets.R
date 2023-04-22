#_targets.R File

#Dependances#
library(targets)
tar_option_set(packages=c("targets","dplyr", "rmarkdown", "tidyverse", "RSQLite", "igraph","stringr"))

##Pipeline##

##Packages
#tar_target(
#  packages,
#  command = {
#    install.packages(list_packages)
#  }
#)

#Nettoyage#
source("R/nettoyage_v2.R")
#source("R/basedonnees.R")
#source("R/analyse.R")
#source("R/Figures.R")

list(
  tar_target(
    name = path,
    command = "./donnees_BIO500",
    format = "file"
  ),
  
  tar_target(
    name = data, # Cible pour l'objet de donnees
    command = list.files(path, full.names = TRUE) # Lecture des donnees
  ),
  tar_target(
    name = nettoyage, #fonction qui nettoye toutes les bases de donnees et les fusionnent
    command = clean_data(data)
  )
)
  ##Creation sql##
#  tar_target(
#   name = table_sql,
#   command = create_sql(nettoyage)
#    ),
  #  tar_target(
  #    name = requete_donnees,
  #    command = requetes(table_sql)
  #  ),
  #  tar_target(
  #    name = figures_final,
  #    command = fig_final(requete_donnees)
  #  )
#)