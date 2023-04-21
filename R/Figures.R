fig_relation = function(analyse){
  tableau_collab<-table(collab[,c("etudiant1","etudiant2")])
  matrice_collab<-igraph::graph.adjacency(tableau_collab)
  plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA) 
  noms<-unique(etudiant$prenom_nom)
  nombre_collab_paire<-nb_collab$nb_collaborations
  rk<-rank(nombre_collab_paire)
  col.vec<-rainbow(length(noms))
  V(matrice_collab)$color=col.vec[rk]
  plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA)
  col.vec.2<-nb_lienetudiant$nb_liens
  V(matrice_collab)$size=col.vec.2[rk]
  plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA)
  graph_reseau<-plot(matrice_collab,vertex.label=NA,edge.arrow.mode=0,vertex.frame.color=NA,layout=layout.kamada.kawai(matrice_collab))
}

fig_sigle = function(analyse){
  colors<-rainbow(length(resume_sigle$sigle))
  barplot(resume_sigle$nb_etudiant,names.arg=resume_sigle$sigle,main="Nombre de collaboration par cours",ylab="Nombre de collaboration",col=colors,las=2)
  mtext("Sigle du cours",side=1,line=3,padj=2)
}

fig_session = function(analyse){
  colors2<-rainbow(length(collab_session$nb_collab_session))
  barplot(collab_session$nb_collab_session,names.arg=collab_session$session,ylab="Nombre de collaboration",col=colors2,las=2)
  title(main="Nombre de collaboration par session")
  mtext("Nom de la session",side=1,line=3,padj=2)
}
