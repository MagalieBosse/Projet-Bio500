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
View(cours5)

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
head(etudiant3_test, 2)

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

<<<<<<< HEAD


=======
#fusion des tables
etudiant_all<-rbind(etudiant1,etudiant2_test,etudiant3_test2.0,etudiant4,etudiant5,etudiant6_test,etudiant7,etudiant8_test,etudiant9,etudiant10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
collab_all<-rbind(collab1,collab2,collab3,collab4_test,collab5,collab6_test,collab7,collab8,collab9,collab10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
cours_all<-rbind(cours1,cours2,cours3,cours4,cours5,cours6_test,cours7,cours8,cours9,cours10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
>>>>>>> 0f13302007c5c011c8c3b92e6305b32b175fa0f5
