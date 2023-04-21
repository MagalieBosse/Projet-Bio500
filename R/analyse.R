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
}