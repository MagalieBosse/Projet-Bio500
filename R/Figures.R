fig_final = function(requete_donnees,nettoyage){
  #definir les liens
  collab<-nett_list[[2]]
  etudiant<-nett_list[[1]]
  collab_session<-resultat_sql[[5]]
  nb_collab<-resultat_sql[[1]]
  nb_lienetudiant<-resultat_sql[[2]]
  resume_sigle<-resultat_sql[[3]]
  nb_etudiant<-resultat_sql[6]
  #creation tableau collab
  tableau_collab<-table(collab[,c("etudiant1","etudiant2")])
  #matrice de liens
  matrice_collab<-igraph::graph.adjacency(tableau_collab)
  #graphique
  plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA) 
  #liste de noms dans nos donnees
  noms<-unique(etudiant$prenom_nom)
  nombre_collab_paire<-nb_collab$nb_collaborations
  #definir un rang
  rk<-rank(nombre_collab_paire)
  #definir un vecteur de couleurs
  col.vec<-rainbow(length(noms))
  V(matrice_collab)$color=col.vec[rk]
  plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA)
  col.vec.2<-nb_lienetudiant$nb_liens
  V(matrice_collab)$size=col.vec.2[rk]
  plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA)
  #graph final
  graph_reseau<-plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA,layout=layout.kamada.kawai(matrice_collab))

#tableau 2
  colors<-rainbow(length(resume_sigle$sigle))
  barplot(resume_sigle$nb_etudiant,names.arg=resume_sigle$sigle,main="Nombre de collaboration par cours",ylab="Nombre de collaboration",col=colors,las=2)
  mtext("Sigle du cours",side=1,line=3,padj=2)

#tableau 3
  colors2<-rainbow(length(collab_session$nb_collab_session))
  barplot(collab_session$nb_collab_session,names.arg=collab_session$session,ylab="Nombre de collaboration",col=colors2,las=2)
  title(main="Nombre de collaboration par session")
  mtext("Nom de la session",side=1,line=3,padj=2)
}
