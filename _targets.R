#_targets.R File

#Dependances#
library(targets)
tar_option_set(packages=c("MASS","igraph"))

#Scripts R reference#
#source("R/Nettoyage.R")
#source("R/basedonnees.R")
#source("R/analyse.R")
source('R/clean_data.R')

##Pipeline##
#Nettoyage#
list(
  tar_target(
    name = path, # Cible
    command = "./donnees_BIO500", # Emplacement du fichier, cré fichier txt ou on met.db?
    format = "file"
  ), 

  tar_target(
    name = data, # Cible pour l'objet de données
    command = list.files(path, full.names = TRUE) # Lecture des données
  ),
  
  tar_target(
    name = data_cleaned,
    command = clean_data(data)
  )

)
