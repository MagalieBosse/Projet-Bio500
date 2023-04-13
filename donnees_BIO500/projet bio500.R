#working directory
setwd()

#packages
library(dplyr)
library(rmarkdown)
library(tidyverse)
library(RSQLite)
library(igraph)

#lecture des fichiers
collab1<-read.csv("1_collaboration.csv",sep=";")
cours1<-read.csv("1_cours.csv",sep=";")
etudiant1<-read.csv("1_etudiant.csv",sep=";")
collab2<-read.csv("2_collaboration.csv",sep=";")
cours2<-read.csv("2_cours.csv",sep=";")
etudiant2<-read.csv("2_etudiant.csv",sep=";")
collab3<-read.csv("3_collaboration.csv",sep=";")
cours3<-read.csv("3_cours.csv",sep=";")
etudiant3<-read.csv("3_etudiant.csv",sep=";")
collab4<-read.csv("4_collaboration.csv",sep=";")
cours4<-read.csv("4_cours.csv",sep=";")
etudiant4<-read.csv("4_etudiant.csv",sep=";")
collab5<-read.csv("5_collaboration.csv",sep=";")
cours5<-read.csv("5_cours.csv",sep=";")
etudiant5<-read.csv("5_etudiant.csv",sep=";")
collab6<-read.csv("6_collaboration.csv",sep=";")
cours6<-read.csv("6_cours.csv",sep=";")
etudiant6<-read.csv("6_etudiant.csv",sep=";")
collab7<-read.csv("7_collaboration.csv",sep=";")
cours7<-read.csv("7_cours.csv",sep=";")
etudiant7<-read.csv("7_etudiant.csv",sep=";")
collab8<-read.csv("8_collaboration.csv",sep=",")
cours8<-read.csv("8_cours.csv",sep=",")
etudiant8<-read.csv("8_etudiant.csv",sep=",")
collab9<-read.csv("9_collaboration.csv",sep=";")
cours9<-read.csv("9_cours.csv",sep=";")
etudiant9<-read.csv("9_etudiant.csv",sep=";")
collab10<-read.csv("10_collaboration.csv",sep=";")
cours10<-read.csv("10_cours.csv",sep=";")
etudiant10<-read.csv("10_etudiant.csv",sep=";")

#changement cours 5 
cours5 <- cours5[-(36:40),]

#changement etudiant 8
etudiant8_test<- subset(etudiant8,select = -c(...9))
head(etudiant8_test, 2)

#changement etudiant 6
etudiant6_test<- subset(etudiant6,select = -c(X))
head(etudiant6_test, 2)

#changement etudiant 2
etudiant2_test<- subset(etudiant2,select = -c(X))
head(etudiant2_test, 2)

#changement etudiant 3
etudiant3_test2.0<- subset(etudiant3,select = -c(X))
head(etudiant3_test2.0, 2)

#changement collab 6
collab6_test<- subset(collab6,select = -c(X, X.1, X.2, X.3, X.4))
head(collab6_test,2)

#changement cours 6
cours6_test<- subset(cours6,select = -c(X, X.1, X.2, X.3, X.4, X.5))
head(cours6_test,2)

#changement cours 6_test
cours6_test<-cours6_test[-(13:235),]

#changement etudiant 3
colnames(etudiant3_test2.0)[colnames(etudiant3_test2.0) == "prenom_nom."] <- "prenom_nom"
colnames(etudiant3_test2.0) <- colnames(etudiant3_test2.0)
names(etudiant3_test2.0)

#changement collab4
collab4_test<-collab4[-(723),]

#changement cours 3
colnames(cours3)[colnames(cours3) == "ï..sigle"] <- "sigle"
colnames(cours3) <- colnames(cours3)
names(cours3)

#changement cours 4
cours4<- subset(cours4,select = -c(X))
head(cours4,2)
cours4<-cours4[-(28),]

#changement etudiant 8
# Charger le fichier CSV
data <- read.csv("8_etudiant.csv", quote = "")

#changement cours 9
cours9<-cours9[-(25:29),]

#changement etudiant 5
etudiant5<-etudiant5[-(52:59),]

#fusion des tables
etudiant_all<-rbind(etudiant1,etudiant2_test,etudiant3_test2.0,etudiant4,etudiant5,etudiant6_test,etudiant7,etudiant8_test,etudiant9,etudiant10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
collab_all<-rbind(collab1,collab2,collab3,collab4_test,collab5,collab6_test,collab7,collab8,collab9,collab10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
cours_all<-rbind(cours1,cours2,cours3,cours4,cours5,cours6_test,cours7,cours8,cours9,cours10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)

#enlever ligne fin etudiant all
etudiant_all<-etudiant_all[-(396),]

#enlever ligne collab all
collab_all<-collab_all[-(5203),]

#ajouter les NA une fois que les fichiers sont mis ensemble
etudiant_all[etudiant_all==""]<-NA #ou collab est le nom de la base de donnees fusionnee
collab_all[collab_all==""]<-NA
cours_all[cours_all==""]<-NA

#supprimer les doublons
cours_bon<-unique(cours_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
collab_bon<-unique(collab_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
etudiant_bon<-unique(etudiant_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)

#remplacer les false et true par version française
etudiant_bon$regime_coop[etudiant_bon$regime_coop%in% "FALSE"]<- "FAUX"
etudiant_bon$regime_coop[etudiant_bon$regime_coop%in% "TRUE"]<- "VRAI"

#COURS
#correction table cours

#supprimer ligne cours bon
cours_bon<-cours_bon[-(326),]

cours_bon <- cours_bon[cours_bon$sigle!="TRUE",]

cours_bon$optionnel[cours_bon$optionnel%in% "FALSE"]<- "FAUX"
cours_bon$optionnel[cours_bon$optionnel%in% "TRUE"]<- "VRAI"
cours_bon$optionnel[cours_bon$optionnel%in% "Faux"]<- "FAUX"

#corrections optionnel faux
cours_bon$optionnel<-ifelse(cours_bon$sigle=="BCM112",'FAUX', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="BCM113",'FAUX', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ECL406",'FAUX', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ECL527",'FAUX', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ECL610",'FAUX', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ECL611",'FAUX', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="TSB303",'FAUX', cours_bon$optionnel)

#corrections optionnel VRAI
cours_bon$optionnel<-ifelse(cours_bon$sigle=="BIO401",'VRAI', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ECL215",'VRAI', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ECL315",'VRAI', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ECL522",'VRAI', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ECL544",'VRAI', cours_bon$optionnel)
cours_bon$optionnel<-ifelse(cours_bon$sigle=="ZOO304",'VRAI', cours_bon$optionnel)

#corrections credits
cours_bon$credits<-ifelse(cours_bon$sigle=="BIO109",'1', cours_bon$credits)
cours_bon$credits<-ifelse(cours_bon$sigle=="ECL515",'2', cours_bon$credits)
cours_bon$credits<-ifelse(cours_bon$sigle=="TSB303",'2', cours_bon$credits)

# retirer les espaces
for(col in names(cours_bon)){
  cours_bon[,col]<-str_replace_all(cours_bon[,col],pattern="\\s",replacement="")
}
for(col in names(cours_bon)){
  cours_bon[,col]<-str_replace_all(cours_bon[,col],pattern="<a0>",replacement="")
}
for(col in names(cours_bon)){
  cours_bon[,col]<-str_replace_all(cours_bon[,col],pattern="�",replacement="")
}

cours_bon<-unique(cours_bon,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)

#valider sigle
cours_bon<-cours_bon%>%
  arrange(sigle)
unique(cours_bon$sigle)

#FIN CORRECTIONS COURS BON

#ETUDIANT
#corrections table etudiant, colonne prenom_nom 
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "mael_guerin"]<-"mael_gerin"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "marie_burghin"]<-"marie_bughin"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "philippe_barette"]<-"philippe_barrette" 
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "phillippe_bourassa"]<- "philippe_bourassa"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "sabrina_leclerc"]<-"sabrina_leclercq"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "samule_fortin"]<- "samuel_fortin"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% c("yannick_sageau","yanick_sagneau")]<-"yanick_sageau"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% c("amelie_harbeck bastien","amelie_harbeck_bastien")]<-"amelie_harbeck-bastien"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "arianne_barette"]<-"ariane_barrette"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "francis_bolly"]<-"francis_boily"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "ihuoma_elsie-ebere"]<-"ihuoma_elsie_ebere"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "kayla_trempe-kay"]<-"kayla_trempe_kay"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "peneloppe_robert"]<-"penelope_robert"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "sara-jade_lamontagne"]<- "sara_jade_lamontagne"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "louis-phillippe_theriault"]<- "louis-philippe_theriault"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "catherine_viel_lapointe"]<- "catherine_viel-lapointe"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "louis_philipe_raymond"]<- "louis-philippe_raymond"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "cassandra_gobin"]<- "cassandra_godin"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "edouard_nadon-baumier"]<- "edouard_nadon-beaumier"
etudiant_bon$prenom_nom[etudiant_bon$prenom_nom%in% "marie_christine_arseneau"]<- "marie-christine_arseneau"

#corrections table etudiant, colonne prenom
etudiant_bon$prenom[etudiant_bon$prenom%in% "yannick"]<-"yanick"
etudiant_bon$prenom[etudiant_bon$prenom%in% "arianne"]<-"ariane"
etudiant_bon$prenom[etudiant_bon$prenom%in% "peneloppe"]<-"penelope"
etudiant_bon$prenom[etudiant_bon$prenom%in% "sara-jade"]<- "sara_jade"
etudiant_bon$prenom[etudiant_bon$prenom%in% "louis-phillipe"]<- "louis-philippe"
etudiant_bon$prenom[etudiant_bon$prenom%in% "cassandre"]<- "cassandra"
etudiant_bon$prenom[etudiant_bon$prenom%in% "louis_philippe"]<- "louis-philippe"

#corrections table etudiant, colonne nom
etudiant_bon$nom[etudiant_bon$nom%in% "guerin"]<-"gerin"
etudiant_bon$nom[etudiant_bon$nom%in% "burghin"]<-"bughin"
etudiant_bon$nom[etudiant_bon$nom%in% "barette"]<-"barrette" 
etudiant_bon$nom[etudiant_bon$nom%in% "leclerc"]<-"leclercq"
etudiant_bon$nom[etudiant_bon$nom%in% "sagneau"]<-"sageau"
etudiant_bon$nom[etudiant_bon$nom%in% "harbeck_bastien"]<-"harbeck-bastien"
etudiant_bon$nom[etudiant_bon$nom%in% "barette"]<-"barrette"
etudiant_bon$nom[etudiant_bon$nom%in% "bolly"]<-"boily"
etudiant_bon$nom[etudiant_bon$nom%in% "elsie-ebere"]<-"elsie_ebere"
etudiant_bon$nom[etudiant_bon$nom%in% "rondeau_leclaire"]<-"rondeau-leclaire"
etudiant_bon$nom[etudiant_bon$nom%in% "trempe-kay"]<-"trempe_kay"
etudiant_bon$nom[etudiant_bon$nom%in% "therrien"]<- "theriault"
etudiant_bon$nom[etudiant_bon$nom%in% "ramond"]<- "raymond"
etudiant_bon$nom[etudiant_bon$nom%in% "viel_lapointe"]<- "viel-lapointe"
etudiant_bon$nom[etudiant_bon$nom%in% "bovin"]<- "boivin"
etudiant_bon$nom[etudiant_bon$nom%in% "guilemette"]<- "guillemette"
etudiant_bon$nom[etudiant_bon$nom%in% "gobin"]<- "godin"
etudiant_bon$nom[etudiant_bon$nom%in% "baumier"]<- "beaumier"

#corrections region admin
etudiant_bon$region_administrative[etudiant_bon$region_administrative%in% "monterigie"]<- "monteregie"
etudiant_bon$region_administrative[etudiant_bon$region_administrative%in% "bas-st-laurent"]<- "bas-saint-laurent"

#trouver les lignes qui se répètent
doubles_etudiant<-duplicated(etudiant_bon$prenom_nom)
extrait_etudiant<-subset(etudiant_bon,doubles_etudiant)

#retirer les espaces bizarres

for(col in names(etudiant_bon)){
  etudiant_bon[,col]<-str_replace_all(etudiant_bon[,col],pattern="\\s",replacement="")
}
for(col in names(etudiant_bon)){
  etudiant_bon[,col]<-str_replace_all(etudiant_bon[,col],pattern="<a0>",replacement="")
}
for(col in names(etudiant_bon)){
  etudiant_bon[,col]<-str_replace_all(etudiant_bon[,col],pattern="�",replacement="")
}

#mettre dans cet ordre pour que subset garde les doublons avec des regions administrative (garde le premier lu)
etudiant_bon<-etudiant_bon%>%
  arrange(region_administrative)

#supprimer les lignes qui ont le meme prenom_nom
etudiant_bon<-subset(etudiant_bon,!duplicated(etudiant_bon$prenom_nom))

#validation en ordre alphabétique
etudiant_bon<-etudiant_bon%>%
  arrange(prenom_nom)

#FIN CORRECTIONS ETUDIANT BON

#COLLABORATION
#correction collab_bon etudiant 1
collab_bon$etudiant1[collab_bon$etudiant1%in% "arianne_barette"]<-"ariane_barrette"
collab_bon$etudiant1[collab_bon$etudiant1%in% "amelie_harbeck_bastien"]<-"amelie_harbeck-bastien"
collab_bon$etudiant1[collab_bon$etudiant1%in% "cassandra_gobin"]<-"cassandra_godin"
collab_bon$etudiant1[collab_bon$etudiant1%in% "catherine_viel_lapointe"]<-"catherine_viel-lapointe"
collab_bon$etudiant1[collab_bon$etudiant1%in% "edouard_nadon-baumier"]<-"edouard_nadon-beaumier"
collab_bon$etudiant1[collab_bon$etudiant1%in% "francis_bolly"]<-"francis_boily"
collab_bon$etudiant1[collab_bon$etudiant1%in% "francis_bourrassa"]<-"francis_bourassa"
collab_bon$etudiant1[collab_bon$etudiant1%in% "frederick_laberge"]<-"frederic_laberge"
collab_bon$etudiant1[collab_bon$etudiant1%in% "ihuoma_elsie-ebere"]<-"ihuoma_elsie_ebere"
collab_bon$etudiant1[collab_bon$etudiant1%in% "jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"
collab_bon$etudiant1[collab_bon$etudiant1%in% "justine_lebelle"]<-"justine_labelle"
collab_bon$etudiant1[collab_bon$etudiant1%in% "laurie_anne_cournoyer"]<-"laurie-anne_cournoyer"
collab_bon$etudiant1[collab_bon$etudiant1%in% "louis-phillippe_theriault"]<-"louis-philippe_theriault"
collab_bon$etudiant1[collab_bon$etudiant1%in% "mael_guerin"]<-"mael_gerin"
collab_bon$etudiant1[collab_bon$etudiant1%in% "marie_burghin"]<-"marie_bughin"
collab_bon$etudiant1[collab_bon$etudiant1%in% "marie_christine_arseneau"]<-"marie-christine_arseneau"
collab_bon$etudiant1[collab_bon$etudiant1%in% "marie_eve_gagne"]<-"marie-eve_gagne"
collab_bon$etudiant1[collab_bon$etudiant1%in% "noemie_perrier-mallette"]<-"noemie_perrier-malette"
collab_bon$etudiant1[collab_bon$etudiant1%in% "peneloppe_robert"]<-"penelope_robert"
collab_bon$etudiant1[collab_bon$etudiant1%in% "philippe_barette"]<-"philippe_barrette"
collab_bon$etudiant1[collab_bon$etudiant1%in% "phillippe_bourassa"]<-"philippe_bourassa"
collab_bon$etudiant1[collab_bon$etudiant1%in% "philippe_bourrassa"]<-"philippe_bourassa"
collab_bon$etudiant1[collab_bon$etudiant1%in% "raphael_charlesbois"]<-"raphael_charlebois"
collab_bon$etudiant1[collab_bon$etudiant1%in% "sabrica_leclercq"]<-"sabrina_leclercq"
collab_bon$etudiant1[collab_bon$etudiant1%in% "sara_jade_lamontagne"]<-"sara-jade_lamontagne"
collab_bon$etudiant1[collab_bon$etudiant1%in% "savier_samson"]<-"xavier_samson"
collab_bon$etudiant1[collab_bon$etudiant1%in% "yannick_sageau"]<-"yanick_sageau"
collab_bon$etudiant1[collab_bon$etudiant1%in% "yanick_sagneau"]<-"yanick_sageau"

#correction collab_bon etudiant 2
collab_bon$etudiant2[collab_bon$etudiant2%in% "arianne_barette"]<-"ariane_barrette"
collab_bon$etudiant2[collab_bon$etudiant2%in% "amelie_harbeck_bastien"]<-"amelie_harbeck-bastien"
collab_bon$etudiant2[collab_bon$etudiant2%in% "cassandra_gobin"]<-"cassandra_godin"
collab_bon$etudiant2[collab_bon$etudiant2%in% "catherine_viel_lapointe"]<-"catherine_viel-lapointe"
collab_bon$etudiant2[collab_bon$etudiant2%in% "edouard_nadon-baumier"]<-"edouard_nadon-beaumier"
collab_bon$etudiant2[collab_bon$etudiant2%in% "francis_bolly"]<-"francis_boily"
collab_bon$etudiant2[collab_bon$etudiant2%in% "francis_bourrassa"]<-"francis_bourassa"
collab_bon$etudiant2[collab_bon$etudiant2%in% "frederick_laberge"]<-"frederic_laberge"
collab_bon$etudiant2[collab_bon$etudiant2%in% "ihuoma_elsie-ebere"]<-"ihuoma_elsie_ebere"
collab_bon$etudiant2[collab_bon$etudiant2%in% "jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"
collab_bon$etudiant2[collab_bon$etudiant2%in% "justine_lebelle"]<-"justine_labelle"
collab_bon$etudiant2[collab_bon$etudiant2%in% "laurie_anne_cournoyer"]<-"laurie-anne_cournoyer"
collab_bon$etudiant2[collab_bon$etudiant2%in% "louis-phillippe_theriault"]<-"louis-philippe_theriault"                   
collab_bon$etudiant2[collab_bon$etudiant2%in% "mael_guerin"]<-"mael_gerin"
collab_bon$etudiant2[collab_bon$etudiant2%in% "marie_burghin"]<-"marie_bughin"
collab_bon$etudiant2[collab_bon$etudiant2%in% "marie_christine_arseneau"]<-"marie-christine_arseneau"
collab_bon$etudiant2[collab_bon$etudiant2%in% "marie_eve_gagne"]<-"marie-eve_gagne"
collab_bon$etudiant2[collab_bon$etudiant2%in% "noemie_perrier-mallette"]<-"noemie_perrier-malette"
collab_bon$etudiant2[collab_bon$etudiant2%in% "peneloppe_robert"]<-"penelope_robert"
collab_bon$etudiant2[collab_bon$etudiant2%in% "philippe_barette"]<-"philippe_barrette"
collab_bon$etudiant2[collab_bon$etudiant2%in% "phillippe_bourassa"]<-"philippe_bourassa"
collab_bon$etudiant2[collab_bon$etudiant2%in% "philippe_bourrassa"]<-"philippe_bourassa"
collab_bon$etudiant2[collab_bon$etudiant2%in% "raphael_charlesbois"]<-"raphael_charlebois"
collab_bon$etudiant2[collab_bon$etudiant2%in% "sabrica_leclercq"]<-"sabrina_leclercq"
collab_bon$etudiant2[collab_bon$etudiant2%in% "sara_jade_lamontagne"]<-"sara-jade_lamontagne"
collab_bon$etudiant2[collab_bon$etudiant2%in% "savier_samson"]<-"xavier_samson"
collab_bon$etudiant2[collab_bon$etudiant2%in% "yannick_sageau"]<-"yanick_sageau"
collab_bon$etudiant2[collab_bon$etudiant2%in% "yanick_sagneau"]<-"yanick_sageau"

#modification sigle 
collab_bon$sigle[collab_bon$sigle%in%"GAE500"]<-"GAE550"

for(col in names(collab_bon)){
  collab_bon[,col]<-str_replace_all(collab_bon[,col],pattern="\\s",replacement="")
}
for(col in names(collab_bon)){
  collab_bon[,col]<-str_replace_all(collab_bon[,col],pattern="<a0>",replacement="")
}
for(col in names(collab_bon)){
  collab_bon[,col]<-str_replace_all(collab_bon[,col],pattern="�",replacement="")
}

#corriger lignes qui voient dans le futur
collab_bon$session[collab_bon$session%in% "E2023"]<-"E2022"

#vérification collab compare a etudiant
collab_bon<-collab_bon%>%
  arrange(etudiant1)
unique(collab_bon$etudiant1)
#etudiant 2
collab_bon<-collab_bon%>%
  arrange(etudiant2)
unique(collab_bon$etudiant2)

#valider sigle
collab_bon<-collab_bon%>%
  arrange(sigle)
unique(collab_bon$sigle)

# enlever ligne 3201 à 3207 de NA

collab_bon<-collab_bon[-(3201:3207),]

#FIN CORRECTIONS COLLABORATION

#creation des tables
con<-dbConnect(SQLite(),dbname="./data.db")
etudiant_sql<- '
CREATE TABLE etudiant(
  prenom_nom VARCHAR(40),
  prenom VARCHAR(20),
  nom VARCHAR(20),
  region_administrative VARCHAR(40),
  regime_coop BOLEAN,
  formation_prealable VARCHAR(30),
  annee_debut VARCHAR(10),
  programme VARCHAR(10),
  PRIMARY KEY (prenom_nom)
);'

dbSendQuery(con,etudiant_sql)
dbListTables(con)

cours_sql<-'
CREATE TABLE cours(
  sigle VARCHAR(10),
  optionnel BOLEAN,
  credits INTEGER,
  PRIMARY KEY (sigle)
);'
dbSendQuery(con,cours_sql)
dbListTables(con)

collaboration_sql<-'CREATE TABLE collaboration (
  etudiant1     VARCHAR(40),
  etudiant2     VARCHAR(40),
  cours   VARCHAR(20),
  PRIMARY KEY (etudiant1, etudiant2, cours),
  FOREIGN KEY (etudiant1) REFERENCES etudiant(prenom_nom),
  FOREIGN KEY (etudiant2) REFERENCES etudiant(prenom_nom),
  FOREIGN KEY (cours) REFERENCES cours(sigle)
);'
dbSendQuery(con,collaboration_sql)
dbListTables(con)

#base de donnees
dbWriteTable(con, append =TRUE, name ="etudiant_sql", value = etudiant_bon, row.names =FALSE)
dbWriteTable(con, append =TRUE, name = "cours_sql", value = cours_bon, row.names =FALSE)
dbWriteTable(con, append =TRUE, name ="collaboration_sql", value = collab_bon, row.names =FALSE)

#requete 1 nombre de liens par etudiant
sql_requete1<-"
SELECT etudiant1, count(etudiant2) AS nb_collaborations
FROM collaboration_sql
GROUP BY etudiant1
ORDER BY nb_collaborations DESC;"
nb_collab<-dbGetQuery(con,sql_requete1)
head(nb_collab)

#requete 2 decompte de liens par paire d'etudiants
sql_requete2<-"
SELECT etudiant1, etudiant2, COUNT (sigle) AS nb_liens 
FROM collaboration_sql
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens DESC;"
nb_lienetudiant<-dbGetQuery(con,sql_requete2)
head(nb_lienetudiant)

#requete 3 cours ayant le plus de collab
sql_requete3<-"
SELECT sigle, session, count(DISTINCT etudiant1) AS nb_etudiant
FROM collaboration_sql
INNER JOIN cours_sql USING (sigle)
GROUP BY sigle
ORDER BY nb_etudiant DESC;"
resume_sigle<-dbGetQuery(con,sql_requete3)
head(resume_sigle)

#requete 4 nombre etudiant par programme
sql_requete4<-"
SELECT programme, count(prenom_nom) AS nb_par_prog
FROM etudiant_sql
GROUP BY programme;"
etudiantprog<-dbGetQuery(con,sql_requete4)
view(etudiantprog)

#requete 5 nombre de collaboration par session
sql_requete5<-"
SELECT session, COUNT(*) AS nb_collab_session
FROM collaboration_sql
GROUP BY session;"
collab_session<-dbGetQuery(con,sql_requete5)
view(collab_session)

#requete 6 nb etudiants en tout
sql_requete6<-"
SELECT COUNT (*) AS nb_etudianttotal
FROM etudiant_sql"
et_total<-dbGetQuery(con, sql_requete6)
#sauver le nombre etudiant total
nb_etudiant<-et_total$nb_etudianttotal

#requete 7 nb collaboration
sql_requete7<-"
SELECT COUNT (*) AS nb_collabtotal
FROM collaboration_sql"
collab_total<-dbGetQuery(con, sql_requete7)
#sauver le nombre de lignes de collab
nb_collab<-collab_total$nb_collabtotal

#figures

#1 creer une matrice etudiant1/etudiant2
matrice_collab<-matrix(0,nrow=nb_etudiant,ncol=nb_etudiant)
#definir la boucle
for (i in 1:nb_etudiant) {
  for (j in 1:nb_etudiant) {
#lire le prenom d'une personne dans la table etudiants CE QUI NOUS MANQUE
   
# Vérifier si la paire apparait dans la table "collaboration", si oui mettre 1 dans la matrice
    if (nrow(subset(collaboration_sql, etudiant1 == i & etudiant2 == j)) > 0) {
      resultats[i, j] <- 1
    }
  }
}
#creer un objet igraph
graph_reseau<-graph.adjacency(resultat)
#voir figure
plot(graph_reseau)