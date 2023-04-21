#_targets.R File

#Dependances#
library(targets)
tar_option_set(packages=c("MASS","igraph"))

##Pipeline##

##Packages
list_packages <- c("targets","dplyr", "rmarkdown", "tidyverse", "RSQLite", "igraph")
tar_target(
  packages,
  command = {
    library(targets)
    install.packages(list_packages)
  }
)

#Nettoyage#
source("R/Nettoyage.R")
list(
  tar_target(
    name = path,
    command = "./donnees_BIO500",
    format = "file"
  ), 

  tar_target(
    name = data,
    command = list.files(path, full.names = TRUE)
  ),
  
  tar_target(
    name = Nettoyage,
    command = clean_data(data)
  ),
  tar_target(
    name = Nettoyage,
    command = clean_uniforme(data)
  ),
  tar_target(
    name = Nettoyage,
    command = clean_data_cours(data)
  ),
  tar_target(
    name = Nettoyage,
    command = clean_data_etudiant(data)
  ),
  tar_target(
    name = Nettoyage,
    command = clean_data_collab(data)
  )
)  
  
##Creation sql##
source("R/basedonnees.R")

list(
  tar_target(
    name = basedonnees,
    command = create_con(Nettoyage)
  ),
  tar_target(
    name = basedonnees,
    command = create_etudiant(Nettoyage)
  ),
  tar_target(
    name = basedonnees,
    command = create_cours(Nettoyage)
  ),
  tar_target(
    name = basedonnees,
    command = create_collab(Nettoyage)
  )
)  
##Requetes sql##
source("R/analyse.R")
 
list( 
  tar_target(
    name = analyse,
    command = requete1(basedonnees)
  ),
  tar_target(
    name = analyse,
    command = requete2(basedonnees)
  ),
  tar_target(
    name = analyse,
    command = requete3(basedonnees)
  ),
  tar_target(
    name = analyse,
    command = requete4(basedonnees)
  ),
  tar_target(
    name = analyse,
    command = requete5(basedonnees)
  ),
  tar_target(
    name = analyse,
    command = requete6(basedonnees)
  ),
  tar_target(
    name = analyse,
    command = requete7(basedonnees)
  )
) 

##Figures##
source("R/Figures.R")
list(
  tar_target(
    name=Figures,
    command = fig_relation(analyse)
  ),
  tar_target(
    name=Figures,
    command = fig_sigle(analyse)
  ),
  tar_target(
    name=Figures,
    command = fig_session(analyse)
  )
)
