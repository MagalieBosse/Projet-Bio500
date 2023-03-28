#packages
library(dplyr)

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

=======
#supprimer les doublons
cours_bon<-unique(cours_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
collab_bon<-unique(collab_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
etudiant_bon<-unique(etudiant_all,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)

#trier collab etudiant 1 ordre alphabétique

collab_bon_et1<-arrange(collab_bon,etudiant1)
collab_bon_et2<-arrange(collab_bon,etudiant2)

#supprimer ligne cours bon
cours_bon<-cours_bon[-(326),]

=======
#remplacer les false et true par version française
etudiant_bon$regime_coop[etudiant_bon$regime_coop%in% "FALSE"]<- "FAUX"
etudiant_bon$regime_coop[etudiant_bon$regime_coop%in% "TRUE"]<- "VRAI"

#correction table cours
cours_bon <- cours_bon[cours_bon$sigle!="TRUE",]

cours_bon$optionnel[cours_bon$optionnel%in% "FALSE"]<- "FAUX"
cours_bon$optionnel[cours_bon$optionnel%in% "TRUE"]<- "VRAI"
cours_bon$optionnel[cours_bon$optionnel%in% "Faux"]<- "FAUX"

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

#mettre dans cet ordre pour que subset garde les doublons avec des regions administrative (garde le premier lu)
library(dplyr)
etudiant_bon<-etudiant_bon%>%
  arrange(region_administrative)

#supprimer les lignes qui ont le meme prenom_nom
etudiant_bon<-subset(etudiant_bon,!duplicated(etudiant_bon$prenom_nom))

#validation en ordre alphabétique
etudiant_bon<-etudiant_bon%>%
  arrange(prenom_nom)
#FIN TABLE ETUDIANT BON EST A UTILISER POUR LA SUITE
>>>>>>> 5aafa5d45516e251c57fb8625418364e6395a3ba

#correction collab_bon_et1
collab_all$etudiant1[collab_all$etudiant1%in% "arianne_barette"]<-"ariane_barrette"
collab_all$etudiant1[collab_all$etudiant1%in% "cassandra_gobin"]<-"cassandra_godin"
collab_all$etudiant1[collab_all$etudiant1%in% "catherine_viel_lapointe"]<-"catherine_viel-lapointe"
collab_all$etudiant1[collab_all$etudiant1%in% "edouard_hadon-baumier"]<-"edouard_hadon-beaumier"
collab_all$etudiant1[collab_all$etudiant1%in% "francis_bolly"]<-"francis_boily"
collab_all$etudiant1[collab_all$etudiant1%in% "elsie-ebere"]<-"elsie_ebere"
collab_all$etudiant1[collab_all$etudiant1%in% "jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"
collab_all$etudiant1[collab_all$etudiant1%in% "juliette_meilleur<a0>"]<-"juliette_meilleur"
collab_all$etudiant1[collab_all$etudiant1%in% "mael_guerin"]<-"mael_gerin"
collab_all$etudiant1[collab_all$etudiant1%in% "marie_burghin"]<-"mael_bughin"
collab_all$etudiant1[collab_all$etudiant1%in% "marie_christine_arseneau"]<-"marie-christine_arseneau"
collab_all$etudiant1[collab_all$etudiant1%in% "marie_eve_gagne"]<-"marie-eve_gagne"
collab_all$etudiant1[collab_all$etudiant1%in% "mia_carriere<a0>"]<-"mia_carriere"
collab_all$etudiant1[collab_all$etudiant1%in% "noemie_perrier-mallette"]<-"noemie_perrier-malette"
collab_all$etudiant1[collab_all$etudiant1%in% "peneloppe_robert"]<-"penelope_robert"
collab_all$etudiant1[collab_all$etudiant1%in% "philippe_barette"]<-"philippe_barrette"
collab_all$etudiant1[collab_all$etudiant1%in% "phillippe_bourassa"]<-"philippe_bourassa"
collab_all$etudiant1[collab_all$etudiant1%in% "raphael_charlesbois"]<-"raphael_charlebois"
collab_all$etudiant1[collab_all$etudiant1%in% "sabrica_leclercq"]<-"sabrina_leclercq"
collab_all$etudiant1[collab_all$etudiant1%in% "sara_jade_lamontagne"]<-"sara-jade_lamontagne"
collab_all$etudiant1[collab_all$etudiant1%in% "savier_samson"]<-"xavier_samson"
collab_all$etudiant1[collab_all$etudiant1%in% "yannick_sageau"]<-"yanick_sageau"
collab_all$etudiant1[collab_all$etudiant1%in% "yanick_sagneau"]<-"yanick_sageau"