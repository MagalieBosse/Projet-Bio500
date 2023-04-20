#_targets.R File

#Dependances#
library(targets)
tar_option_set(packages=c("MASS","igraph"))

#Scripts R reference#
source("./R/projet bio500.R")?? "je pense qu il faudra faire un switch dans deux dossiers différents?"
source("R/analyse.R")
source("R/figure.R")

##Pipeline##
#Origine des donnees#
list(
  tar_target(
    name = path, # Cible
    command = "./donnees BIO500/data.txt", # Emplacement du fichier, cré fichier txt ou on met.db?
    format = "file"
  ), 

  tar_target(
    name = data, # Cible pour l'objet de données
    command = read.table(path) # Lecture des données #ou on met data.db?
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

#Nettoyer les donnees#
#cours
list(
tar_target(
  cours5,
  cours5[-(36:40),]#changement cours 5, ligne 42
),
tar_target(
  cours6_test,
  subset(cours6,select = -c(X, X.1, X.2, X.3, X.4, X.5))#changement cours 6, ligne 65
),
tar_target(
  cours6_test,
  cours6_test[-(13:235),]#changement cours 6_test, ligne 69 #a changer dans notre script pour avoir seulement cours 6?
),
tar_target(
  "sigle",
  colnames(cours3)[colnames(cours3) == "ï..sigle"]#changement cours 3, ligne 80
),
tar_target(
  colnames(cours3),
  colnames(cours3) # changement cours 3, ligne 81 #est-ce nécessaire?
),
tar_target(
  cours4,
  subset(cours4,select = -c(X))#changement cours 4,ligne 85
),
tar_target(
  cours4,
  cours4[-(28),]#changement cours 4, ligne 87
),
tar_target(
  cours9,
  cours9[-(25:29),]#changement cours 9, ligne 94
 )
)
#etudiant
list(
tar_target(
  etudiant5,
  etudiant5[-(52:59),]#changement etudiant 5, ligne 97
),
tar_target(
  "prenom_nom",
  colnames(etudiant3_test2.0)[colnames(etudiant3_test2.0) == "prenom_nom."]#changement etudiant 3, ligne 72
),
tar_target(
  colnames(etudiant3_test2.0),
  colnames(etudiant3_test2.0)#changement etudiant 3, ligne 74
),
tar_target(
  etudiant8_test,
  subset(etudiant8,select = -c(...9))#changement etudiant 8, ligne 45
),
tar_target(
  etudiant6_test,
  subset(etudiant6,select = -c(X))#changement etudiant 6, ligne 49
), 
tar_target(
  etudiant2_test,
  subset(etudiant2,select = -c(X))#changement etudiant 2, ligne 53
),
tar_target(
  etudiant3_test2.0,#a changer le 2.0?
  subset(etudiant3,select = -c(X))#changement etudiant 3, ligne 57
),
tar_target(
  data,
  read.csv("./donnees_BIO500/8_etudiant.csv", quote = "")#changement etudiant 8, ligne 89
 )
)
#collab
list(
tar_target(
  collab6_test,
  subset(collab6,select = -c(X, X.1, X.2, X.3, X.4))#changement collab 6,ligne 61
),
tar_target(
  collab4_test,
  collab4[-(723),]#changement collab 4,ligne 77
 )
)
#Tableaux de donnees#
#Fusion#
#cours
tar_target(
cours_all, #ligne 102
rbind(cours1,cours2,cours3,cours4,cours5,cours6_test,cours7,cours8,cours9,cours10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
)
#etudiant
tar_target(
  etudiant_all,#ligne 100
  rbind(etudiant1,etudiant2_test,etudiant3_test2.0,etudiant4,etudiant5,etudiant6_test,etudiant7,etudiant8_test,etudiant9,etudiant10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
)
#collab
tar_target(
collab_all,#ligne 101
rbind(collab1,collab2,collab3,collab4_test,collab5,collab6_test,collab7,collab8,collab9,collab10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
)

#corrections dans les tables de données#
#etudiant
tar_target(
  etudiant_all,
  etudiant_all[-(396),]#ligne 105
)
#collab
tar_target(
  collab_all,
  collab_all[-(5203),]#ligne 108
)
#mettre les NA dans les cases vides des tableaux de donnees#
#cours
tar_target(
  NA,
  cours_all[cours_all==""]#ligne 113
)
#etudinat
tar_target(
  NA,
  etudiant_all[etudiant_all==""]# ligne 111
)
#collab
tar_target(
  NA,
  collab_all[collab_all==""]# ligne 112
)
#supprimer les doublons des tableaux de donnees#
#cours
tar_target(
  cours_bon,
  unique(cours_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE) #ligne 116
)
#etudiant
tar_target(
etudiant_bon,
unique(etudiant_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)# ligne 118
)
#collab
tar_target(
  collab_bon,
  unique(collab_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)# ligne 117
)
#remplacer false et true par faux et vrai#
list(
tar_target(
  "FAUX",
etudiant_bon$regime_coop[etudiant_bon$regime_coop%in% "FALSE"]# ligne 121
),
tar_target(
  "VRAI",
  etudiant_bon$regime_coop[etudiant_bon$regime_coop%in% "TRUE"]# ligne 122
 )
)
#modification des tableaux de donnees#
#cours
list(
  tar_target(
    cours_bon,
    cours_bon[-(326),]#ligne 128
  ),
  tar_target(
    cours_bon,
    cours_bon[cours_bon$sigle!="TRUE",]#ligne 130
  ),
  tar_target(
    "FAUX",
    cours_bon$optionnel[cours_bon$optionnel%in% "FALSE"]#ligne 132
  ),
  tar_target(
    "VRAI",
    cours_bon$optionnel[cours_bon$optionnel%in% "TRUE"]# ligne 133
  ),
  tar_target(
    "FAUX",
    cours_bon$optionnel[cours_bon$optionnel%in% "Faux"]
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="BCM112",'FAUX', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="BCM113",'FAUX', cours_bon$optionnel)
  ),
  tar_target(
  cours_bon$optionnel,
  ifelse(cours_bon$sigle=="ECL406",'FAUX', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="ECL527",'FAUX', cours_bon$optionnel)
  ),
  tar_target(
  cours_bon$optionnel,
  ifelse(cours_bon$sigle=="ECL610",'FAUX', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="ECL611",'FAUX', cours_bon$optionnel)
  ),
  tar-target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="TSB303",'FAUX', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="BIO401",'VRAI', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="ECL215",'VRAI', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="ECL315",'VRAI', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="ECL522",'VRAI', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="ECL544",'VRAI', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$optionnel,
    ifelse(cours_bon$sigle=="ZOO304",'VRAI', cours_bon$optionnel)
  ),
  tar_target(
    cours_bon$credits,
    ifelse(cours_bon$sigle=="BIO109",'1', cours_bon$credits)
  ),
  tar_target(
    cours_bon$credits,
    ifelse(cours_bon$sigle=="ECL515",'2', cours_bon$credits)
  ),
  tar_target(
    cours_bon$credits,
    ifelse(cours_bon$sigle=="TSB303",'2', cours_bon$credits)
  ),
  #rendu 158
  )
    
###Rendu à la ligne 136 dans projet bio500.R

#Creation des tables sql

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