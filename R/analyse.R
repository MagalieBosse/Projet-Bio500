#appeler les bonnes tables
requetes = function(table_sql){
  collaboration_sql<-table_sql[[2]]
  etudiant_sql<-table_sql[[1]]
  cours<-table_sql[[3]]
  
#requete 1 nombre de liens par etudiant
  sql_requete1<-"
SELECT etudiant1, count(etudiant2) AS nb_collaborations
FROM collaboration_sql
GROUP BY etudiant1
ORDER BY nb_collaborations DESC;"
  nb_collab<-dbGetQuery(con,sql_requete1)

#requete 2 decompte de liens par paire d'etudiants
  sql_requete2<-"
SELECT etudiant1, etudiant2, COUNT (sigle) AS nb_liens 
FROM collaboration_sql
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens DESC;"
  nb_lienetudiant<-dbGetQuery(con,sql_requete2)

#requete 3 cours ayant le plus de collaborations
  sql_requete3<-"
SELECT sigle, count(DISTINCT etudiant1) AS nb_etudiant
FROM collaboration_sql
INNER JOIN cours_sql USING (sigle)
GROUP BY sigle
ORDER BY nb_etudiant DESC;"
resume_sigle<-dbGetQuery(con,sql_requete3)

#requete 4 nombre etudiant par programme
  sql_requete4<-"
SELECT programme, count(prenom_nom) AS nb_par_prog
FROM etudiant_sql
GROUP BY programme;"
  etudiantprog<-dbGetQuery(con,sql_requete4)

#requete 5 nombre de collaboration par session
  sql_requete5<-"
SELECT session, COUNT(*) AS nb_collab_session
FROM collaboration_sql
GROUP BY session;"
  collab_session<-dbGetQuery(con,sql_requete5)

#requete 6 nb etudiants en tout
  sql_requete6<-"
SELECT COUNT (*) AS nb_etudianttotal
FROM etudiant_sql"
  et_total<-dbGetQuery(con, sql_requete6)
  #sauver le nombre etudiant total
  nb_etudiant<-et_total$nb_etudianttotal

#requete 7 nombre collaboration
  sql_requete7<-"
SELECT COUNT (*) AS nb_collabtotal
FROM collaboration_sql"
  collab_total<-dbGetQuery(con, sql_requete7)
#sauver le nombre de lignes de collab
  nb_collaboration<-collab_total$nb_collabtotal
  
#creer liste des requetes
  resultat_sql<-list(nb_collab,nb_lienetudiant,resume_sigle,etudiantprog,collab_session,nb_etudiant,nb_collaboration)
  return(table_sql)
}
