#_targets.R File

#Dependances#
library(targets)
library(dplyr)
library(rmarkdown)
library(tidyverse)
library(RSQLite)
library(igraph)
tar_option_set(packages=c("MASS","igraph"))

#Scripts R reference#
#source("R/Nettoyage.R")
#source("R/basedonnees.R")
#source("R/analyse.R")
<<<<<<< HEAD

=======
source("R/Nettoyage.R")
>>>>>>> dac65a6700e66071b0ccd2c455a934f9eff0194a

##Pipeline##
#Nettoyage#
list_packages <- c("dplyr", "rmarkdown", "tidyverse", "RSQLite", "igraph")

tar_target(
  packages,
  command = {
    library(targets)
    install.packages(list_packages)
  }
)

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
<<<<<<< HEAD
    name = data_cleaned,
    command = Nettoyage(data)
=======
    name = Nettoyage,
    command = clean_data(data)
>>>>>>> dac65a6700e66071b0ccd2c455a934f9eff0194a
  )
)
  