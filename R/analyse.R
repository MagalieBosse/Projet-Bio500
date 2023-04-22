requete1 = function(basedonnees){
sql_requete1<-"
SELECT etudiant1, count(etudiant2) AS nb_collaborations
FROM collaboration_sql
GROUP BY etudiant1
ORDER BY nb_collaborations DESC;"
nb_collab<-dbGetQuery(con,sql_requete1)
}

requete2 = function(basedonnees){
sql_requete2<-"
SELECT etudiant1, etudiant2, COUNT (sigle) AS nb_liens 
FROM collaboration_sql
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens DESC;"
nb_lienetudiant<-dbGetQuery(con,sql_requete2)
}

requete3 = function(basedonnees){
sql_requete3<-"
SELECT sigle, count(DISTINCT etudiant1) AS nb_etudiant
FROM collaboration_sql
INNER JOIN cours_sql USING (sigle)
GROUP BY sigle
ORDER BY nb_etudiant DESC;"
resume_sigle<-dbGetQuery(con,sql_requete3)
}

requete4 = function(basedonnees){
sql_requete4<-"
SELECT programme, count(prenom_nom) AS nb_par_prog
FROM etudiant_sql
GROUP BY programme;"
etudiantprog<-dbGetQuery(con,sql_requete4)
}

requete5 = function(basedonnees){
sql_requete5<-"
SELECT session, COUNT(*) AS nb_collab_session
FROM collaboration_sql
GROUP BY session;"
collab_session<-dbGetQuery(con,sql_requete5)
}

requete6 = function(basedonnees){
sql_requete6<-"
SELECT COUNT (*) AS nb_etudianttotal
FROM etudiant_sql"
et_total<-dbGetQuery(con, sql_requete6)
#sauver le nombre etudiant total
nb_etudiant<-et_total$nb_etudianttotal
}

requete7 = function(basedonnees){
sql_requete7<-"
SELECT COUNT (*) AS nb_collabtotal
FROM collaboration_sql"
collab_total<-dbGetQuery(con, sql_requete7)
#sauver le nombre de lignes de collab
nb_collaboration<-collab_total$nb_collabtotal
<<<<<<< HEAD

#figures
noms<-unique(etudiant_bon$prenom_nom)

#Tableau 1
#1 creer une matrice etudiant1/etudiant2
tableau_collab<-table(collab_bon[,c("etudiant1","etudiant2")])
matrice_collab<-igraph::graph.adjacency(tableau_collab)
#creer objet igraph
graph_reseau<-plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA)

#varier la couleur des points selon le nombre de collaborations faites par la paire d'etudiant
nombre_collab_paire<-nb_collab$nb_collaborations
rk<-rank(nombre_collab_paire)
col.vec<-rainbow(length(noms))
V(matrice_collab)$color=col.vec[rk]
plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA)
#varier la taille des points selon le nombre de collaboration de l'etudiant
col.vec.2<-nb_lienetudiant$nb_liens
V(matrice_collab)$size=col.vec.2[rk]
plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA)
#changer la disposition des noeuds
plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA,layout=layout.kamada.kawai(matrice_collab))

#Tableau 2
colors<-rainbow(length(resume_sigle$sigle))
barplot(resume_sigle$nb_etudiant,names.arg=resume_sigle$sigle,main="Nombre de collaboration par cours",ylab="Nombre de collaboration",col=colors,las=2)
mtext("Sigle du cours",side=1,line=3,padj=2)
#Tableau 3
colors2<-rainbow(length(collab_session$nb_collab_session))
barplot(collab_session$nb_collab_session,names.arg=collab_session$session,ylab="Nombre de collaboration",col=colors2,las=2)
title(main="Nombre de collaboration par session")
mtext("Nom de la session",side=1,line=3,padj=2)

#Tableau : faire dans markdown 
print(etudiantprog)
.
=======
}
>>>>>>> f365292cdc7cd42c9089d762b07ce914b3559cd0
