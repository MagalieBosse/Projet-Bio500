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
source("R/Nettoyage.R")
source("R/basedonnees.R")
source("R/analyse.R")
source("R/Figures.R")

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
    name = Nettoyage, #fonction qui nettoye toutes les bases de donnees et les fusionnent
    command = clean_data(data)
  ),
  ##Creation sql##
  tar_target(
    name = etudiant_sql,
    command = create_etudiant(Nettoyage)
  )
  #  tar_target(
  #    name = etudiant_sql,
  #    command = dbConnect(SQLite(),dbname="./data.db")
  #  ),
  #  tar_target(
  #    name = basedonnees3,
  #    command = create_cours(basedonnees1)
  #  ),
  #  tar_target(
  #    name = basedonnees4,
  #    command = create_collab(basedonnees1)
  #  ),
  
  ##Requetes sql##
  
  #  tar_target(
  #    name = analyse,
  #    command = requete1(basedonnees)
  #  ),
  #  tar_target(
  #    name = analyse,
  #    command = requete2(basedonnees)
  #  ),
  #  tar_target(
  #    name = analyse,
  #    command = requete3(basedonnees)
  #  ),
  #  tar_target(
  #    name = analyse,
  #    command = requete4(basedonnees)
  #  ),
  #  tar_target(
  #    name = analyse,
  #    command = requete5(basedonnees)
  #  ),
  #  tar_target(
  #    name = analyse,
  #    command = requete6(basedonnees)
  #  ),
  #  tar_target(
  #    name = analyse,
  #    command = requete7(basedonnees)
  #  ),
  
  ##Figures##
  
  #  tar_target(
  #    name=Figures,
  #    command = fig_relation(analyse)
  #  ),
  #  tar_target(
  #    name=Figures,
  #    command = fig_sigle(analyse)
  #  ),
  #  tar_target(
  #    name=Figures,
  #    command = fig_session(analyse)
  #  )
)