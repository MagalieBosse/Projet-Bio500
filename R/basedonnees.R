create_sql = function(nettoyage){
  
  con<-dbConnect(SQLite(),dbname="./data.db")
  #create table etudiant_sql
  #appeler les bonnes commandes
  etudiant<-nett_list[[1]]
  collab<-nett_list[[2]]
  cours<-nett_list[[3]]
  #creation table etudiant
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
  #injection des donnees
  dbWriteTable(con, append =TRUE, name ="etudiant_sql", value = etudiant, row.names =FALSE)
  #creation table cours
  cours_sql<-'
  CREATE TABLE cours(
    sigle VARCHAR(10),
    optionnel BOLEAN,
    credits INTEGER,
    PRIMARY KEY (sigle)
  );'
  dbSendQuery(con,cours_sql)
  dbListTables(con)
  #injection des donnees
  dbWriteTable(con, append =TRUE, name = "cours_sql", value = cours, row.names =FALSE)
  #creation table collaboration
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
  #Injection des donnees
  dbWriteTable(con, append =TRUE, name ="collaboration_sql", value = collab, row.names =FALSE)
  table_sql<-list(etudiant_sql,collaboration_sql,cours_sql)
  return(table_sql)
  }
