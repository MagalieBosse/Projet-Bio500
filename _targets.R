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
source("R/analyse.R")