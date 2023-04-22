clean_data = function(data){
#lire les tables de donnees
  
allFiles <- dir("./donnees_BIO500/")
# Tables à fusioner
tabNames <- c('collab', 'cours', 'etudiant')
  
# Nombre de groupes
nbGroupe <- sum(grepl(paste0("^", tabNames[1]), allFiles))
  
# Charger les donnees
for(tab in tabNames) {
  # prendre seulement les fichers de la table specifique `tab`
  tabFiles <- allFiles[grep(tab, allFiles)]
    
  for(groupe in 1:nbGroupe) {
    # Definir le nom de l'obj dans lequel sauver les donnees de la table `tab` du groupe `groupe`
    tabName <- paste0(tab, "", groupe)
      
    # Avant  de charger les données, il faut savoir c'est quoi le séparateur utilisé car
    # il y a eu des données separées par "," et des autres separes par ";"
    ficher <- paste0("./donnees_BIO500/", tabFiles[groupe])
    L <- readLines(ficher, n = 1) # charger première ligne du donnée
    separateur <- ifelse(grepl(';', L), ';', ',') # S'il y a un ";", separateur est donc ";"
     #lire les tables
    data<-read.csv(ficher[-c(grep('8', data))],sep = separateur, header = TRUE, stringsAsFactors = FALSE)
    data_8<-read.csv(ficher[c(grep('8', tabFiles))], quote = "")
    
    #Nettoyage donnees
    col_de_trop<-c("X", "X.1", "X.2", "X.3", "X.4", "X.5", "...9")
    
    #retirer ces lignes
    data<-data[,!(names(data)%in%col_de_trop)]
    
    #changement etudiant 3
    names(data)[names(data) == "prenom_nom."] <- "prenom_nom"
    
    #changement cours 3
    names(data)[names(data) == "ï..sigle"] <- "sigle"
    
    # charger le donnée avec le bon séparateur et donner le nom `tabName`
    assign(tabName, data)
    
  }
}
  # nettoyer des objets temporaires utilisé dans la boucle
  rm(list = c('allFiles', 'tab', 'tabFiles', 'tabName', 'ficher', 'groupe'))  
  
  #changement cours 5 
  cours5<-cours5[-(36:40),]
  
  #changement cours 6_test
  cours6<-cours6[-(13:235),]
  
  #changement collab4
  collab4<-collab4[-(723),]
  
  #changement cours 4
  cours4<-cours4[-(28),]
  
  #changement cours 9
  cours9<-cours9[-(25:29),]
  
  #changement etudiant 5
  etudiant5<-etudiant5[-(52:59),]
  
  #fusion des tables
  etudiant<-rbind(etudiant1,etudiant2,etudiant3,etudiant4,etudiant5,etudiant6,etudiant7,etudiant8,etudiant9,etudiant10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
  collab<-rbind(collab1,collab2,collab3,collab4,collab5,collab6,collab7,collab8,collab9,collab10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
  cours<-rbind(cours1,cours2,cours3,cours4,cours5,cours6,cours7,cours8,cours9,cours10,deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
  
  #enlever ligne fin etudiant all
  etudiant<-etudiant[-(396),]
  
  #enlever ligne collab all
  collab<-collab[-(5203),]
  
  #ajouter les NA une fois que les fichiers sont mis ensemble
  etudiant[etudiant==""]<-NA #ou collab est le nom de la base de donnees fusionnee
  collab[collab==""]<-NA
  cours[cours==""]<-NA
  
  #supprimer les doublons
  cours<-unique(cours,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
  collab<-unique(collab,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
  etudiant<-unique(etudiant,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
  
  #remplacer les false et true par version française
  etudiant$regime_coop[etudiant$regime_coop%in% "FALSE"]<- "FAUX"
  etudiant$regime_coop[etudiant$regime_coop%in% "TRUE"]<- "VRAI"
  
  #COURS
  #correction table cours
  
  #supprimer ligne cours
  cours<-cours[-(326),]
  
  cours<-cours[cours$sigle!="TRUE",]
  
  cours$optionnel[cours$optionnel%in% "FALSE"]<- "FAUX"
  cours$optionnel[cours$optionnel%in% "TRUE"]<- "VRAI"
  cours$optionnel[cours$optionnel%in% "Faux"]<- "FAUX"
  
  #corrections optionnel faux
  cours$optionnel<-ifelse(cours$sigle=="BCM112",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="BCM113",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL406",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL527",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL610",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL611",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="TSB303",'FAUX', cours$optionnel)
  
  #corrections optionnel VRAI
  cours$optionnel<-ifelse(cours$sigle=="BIO401",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL215",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL315",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL522",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL544",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ZOO304",'VRAI', cours$optionnel)
  
  #corrections credits
  cours$credits<-ifelse(cours$sigle=="BIO109",'1', cours$credits)
  cours$credits<-ifelse(cours$sigle=="ECL515",'2', cours$credits)
  cours$credits<-ifelse(cours$sigle=="TSB303",'2', cours$credits)
  
  # retirer les espaces
  for(col in names(cours)){
    cours[,col]<-str_replace_all(cours[,col],pattern="\\s",replacement="")
  }
  for(col in names(cours)){
    cours[,col]<-str_replace_all(cours[,col],pattern="<a0>",replacement="")
  }
  for(col in names(cours)){
    cours[,col]<-str_replace_all(cours[,col],pattern="�",replacement="")
  }
  
  cours<-unique(cours,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
  
  #valider sigle
  cours<-cours%>%
    arrange(sigle)
  unique(cours$sigle)
  
  #retirer les liens entre meme etudiant
  
  collab<-collab %>%
    distinct(etudiant1,etudiant2,.keep_all=TRUE)
  
  #FIN CORRECTIONS COURS BON
  
  #ETUDIANT
  #corrections table etudiant, colonne prenom_nom 
  etudiant$prenom_nom[etudiant$prenom_nom%in% "mael_guerin"]<-"mael_gerin"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "marie_burghin"]<-"marie_bughin"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "philippe_barette"]<-"philippe_barrette" 
  etudiant$prenom_nom[etudiant$prenom_nom%in% "phillippe_bourassa"]<- "philippe_bourassa"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "sabrina_leclerc"]<-"sabrina_leclercq"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "samule_fortin"]<- "samuel_fortin"
  etudiant$prenom_nom[etudiant$prenom_nom%in% c("yannick_sageau","yanick_sagneau")]<-"yanick_sageau"
  etudiant$prenom_nom[etudiant$prenom_nom%in% c("amelie_harbeck bastien","amelie_harbeck_bastien")]<-"amelie_harbeck-bastien"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "arianne_barette"]<-"ariane_barrette"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "francis_bolly"]<-"francis_boily"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "ihuoma_elsie-ebere"]<-"ihuoma_elsie_ebere"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "kayla_trempe-kay"]<-"kayla_trempe_kay"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "peneloppe_robert"]<-"penelope_robert"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "sara-jade_lamontagne"]<- "sara_jade_lamontagne"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "louis-phillippe_theriault"]<- "louis-philippe_theriault"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "catherine_viel_lapointe"]<- "catherine_viel-lapointe"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "louis_philipe_raymond"]<- "louis-philippe_raymond"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "cassandra_gobin"]<- "cassandra_godin"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "edouard_nadon-baumier"]<- "edouard_nadon-beaumier"
  etudiant$prenom_nom[etudiant$prenom_nom%in% "marie_christine_arseneau"]<- "marie-christine_arseneau"
  
  #corrections table etudiant, colonne prenom
  etudiant$prenom[etudiant$prenom%in% "yannick"]<-"yanick"
  etudiant$prenom[etudiant$prenom%in% "arianne"]<-"ariane"
  etudiant$prenom[etudiant$prenom%in% "peneloppe"]<-"penelope"
  etudiant$prenom[etudiant$prenom%in% "sara-jade"]<- "sara_jade"
  etudiant$prenom[etudiant$prenom%in% "louis-phillipe"]<- "louis-philippe"
  etudiant$prenom[etudiant$prenom%in% "cassandre"]<- "cassandra"
  etudiant$prenom[etudiant$prenom%in% "louis_philippe"]<- "louis-philippe"
  
  #corrections table etudiant, colonne nom
  etudiant$nom[etudiant$nom%in% "guerin"]<-"gerin"
  etudiant$nom[etudiant$nom%in% "burghin"]<-"bughin"
  etudiant$nom[etudiant$nom%in% "barette"]<-"barrette" 
  etudiant$nom[etudiant$nom%in% "leclerc"]<-"leclercq"
  etudiant$nom[etudiant$nom%in% "sagneau"]<-"sageau"
  etudiant$nom[etudiant$nom%in% "harbeck_bastien"]<-"harbeck-bastien"
  etudiant$nom[etudiant$nom%in% "barette"]<-"barrette"
  etudiant$nom[etudiant$nom%in% "bolly"]<-"boily"
  etudiant$nom[etudiant$nom%in% "elsie-ebere"]<-"elsie_ebere"
  etudiant$nom[etudiant$nom%in% "rondeau_leclaire"]<-"rondeau-leclaire"
  etudiant$nom[etudiant$nom%in% "trempe-kay"]<-"trempe_kay"
  etudiant$nom[etudiant$nom%in% "therrien"]<- "theriault"
  etudiant$nom[etudiant$nom%in% "ramond"]<- "raymond"
  etudiant$nom[etudiant$nom%in% "viel_lapointe"]<- "viel-lapointe"
  etudiant$nom[etudiant$nom%in% "bovin"]<- "boivin"
  etudiant$nom[etudiant$nom%in% "guilemette"]<- "guillemette"
  etudiant$nom[etudiant$nom%in% "gobin"]<- "godin"
  etudiant$nom[etudiant$nom%in% "baumier"]<- "beaumier"
  
  #ajout des lignes oubliees
  eb<-c("eloise_bernier","eloise","bernier",NA, NA, NA, NA, NA)
  gm<-c("gabrielle_moreault","gabrielle","moreault",NA, NA, NA, NA, NA)
  kh<-c("karim_hamzaoui","karim","hamzaoui",NA, NA, NA, NA, NA)
  mv<-c("maude_viens","maude","viens",NA, NA, NA, NA, NA)
  mc<-c("maxence_comyn","maxence","comyn",NA, NA, NA, NA, NA)
  nm<-c("naomie_morin","naomie","morin",NA, NA, NA, NA, NA)
  etudiant<-rbind(etudiant,eb)
  etudiant<-rbind(etudiant,gm)
  etudiant<-rbind(etudiant,kh)
  etudiant<-rbind(etudiant,mv)
  etudiant<-rbind(etudiant,mc)
  etudiant<-rbind(etudiant,nm)
  
  #corrections region admin
  etudiant$region_administrative[etudiant$region_administrative%in% "monterigie"]<- "monteregie"
  etudiant$region_administrative[etudiant$region_administrative%in% "bas-st-laurent"]<- "bas-saint-laurent"
  
  #trouver les lignes qui se répètent
  doubles_etudiant<-duplicated(etudiant$prenom_nom)
  extrait_etudiant<-subset(etudiant,doubles_etudiant)
  
  #retirer les espaces bizarres
  
  for(col in names(etudiant)){
    etudiant[,col]<-str_replace_all(etudiant[,col],pattern="\\s",replacement="")
  }
  for(col in names(etudiant)){
    etudiant[,col]<-str_replace_all(etudiant[,col],pattern="<a0>",replacement="")
  }
  for(col in names(etudiant)){
    etudiant[,col]<-str_replace_all(etudiant[,col],pattern="�",replacement="")
  }
  
  #mettre dans cet ordre pour que subset garde les doublons avec des regions administrative (garde le premier lu)
  etudiant<-etudiant%>%
    arrange(region_administrative)
  
  #supprimer les lignes qui ont le meme prenom_nom
  etudiant<-subset(etudiant,!duplicated(etudiant$prenom_nom))
  
  #validation en ordre alphabétique
  etudiant<-etudiant%>%
    arrange(prenom_nom)
  
  #FIN CORRECTIONS ETUDIANT BON
  
  #COLLABORATION
  #correction collab_bon etudiant 1
  collab$etudiant1[collab$etudiant1%in% "arianne_barette"]<-"ariane_barrette"
  collab$etudiant1[collab$etudiant1%in% "amelie_harbeck_bastien"]<-"amelie_harbeck-bastien"
  collab$etudiant1[collab$etudiant1%in% "cassandra_gobin"]<-"cassandra_godin"
  collab$etudiant1[collab$etudiant1%in% "catherine_viel_lapointe"]<-"catherine_viel-lapointe"
  collab$etudiant1[collab$etudiant1%in% "edouard_nadon-baumier"]<-"edouard_nadon-beaumier"
  collab$etudiant1[collab$etudiant1%in% "francis_bolly"]<-"francis_boily"
  collab$etudiant1[collab$etudiant1%in% "francis_bourrassa"]<-"francis_bourassa"
  collab$etudiant1[collab$etudiant1%in% "frederick_laberge"]<-"frederic_laberge"
  collab$etudiant1[collab$etudiant1%in% "ihuoma_elsie-ebere"]<-"ihuoma_elsie_ebere"
  collab$etudiant1[collab$etudiant1%in% "jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"
  collab$etudiant1[collab$etudiant1%in% "justine_lebelle"]<-"justine_labelle"
  collab$etudiant1[collab$etudiant1%in% "laurie_anne_cournoyer"]<-"laurie-anne_cournoyer"
  collab$etudiant1[collab$etudiant1%in% "louis-phillippe_theriault"]<-"louis-philippe_theriault"
  collab$etudiant1[collab$etudiant1%in% "madyson_mcclean"]<-"madyson_mclean"
  collab$etudiant1[collab$etudiant1%in% "mael_guerin"]<-"mael_gerin"
  collab$etudiant1[collab$etudiant1%in% "marie_burghin"]<-"marie_bughin"
  collab$etudiant1[collab$etudiant1%in% "marie_christine_arseneau"]<-"marie-christine_arseneau"
  collab$etudiant1[collab$etudiant1%in% "marie_eve_gagne"]<-"marie-eve_gagne"
  collab$etudiant1[collab$etudiant1%in% "noemie_perrier-mallette"]<-"noemie_perrier-malette"
  collab$etudiant1[collab$etudiant1%in% "peneloppe_robert"]<-"penelope_robert"
  collab$etudiant1[collab$etudiant1%in% "philippe_barette"]<-"philippe_barrette"
  collab$etudiant1[collab$etudiant1%in% "phillippe_bourassa"]<-"philippe_bourassa"
  collab$etudiant1[collab$etudiant1%in% "philippe_bourrassa"]<-"philippe_bourassa"
  collab$etudiant1[collab$etudiant1%in% "philippe_leonard_dufour"]<-"philippe_leonard-dufour"
  collab$etudiant1[collab$etudiant1%in% "raphael_charlesbois"]<-"raphael_charlebois"
  collab$etudiant1[collab$etudiant1%in% "sabrica_leclercq"]<-"sabrina_leclercq"
  collab$etudiant1[collab$etudiant1%in% "sara_jade_lamontagne"]<-"sara-jade_lamontagne"
  collab$etudiant1[collab$etudiant1%in% "savier_samson"]<-"xavier_samson"
  collab$etudiant1[collab$etudiant1%in% "yannick_sageau"]<-"yanick_sageau"
  collab$etudiant1[collab$etudiant1%in% "yanick_sagneau"]<-"yanick_sageau"
  
  #correction collab_bon etudiant 2
  collab$etudiant2[collab$etudiant2%in% "arianne_barette"]<-"ariane_barrette"
  collab$etudiant2[collab$etudiant2%in% "amelie_harbeck_bastien"]<-"amelie_harbeck-bastien"
  collab$etudiant2[collab$etudiant2%in% "cassandra_gobin"]<-"cassandra_godin"
  collab$etudiant2[collab$etudiant2%in% "catherine_viel_lapointe"]<-"catherine_viel-lapointe"
  collab$etudiant2[collab$etudiant2%in% "edouard_nadon-baumier"]<-"edouard_nadon-beaumier"
  collab$etudiant2[collab$etudiant2%in% "francis_bolly"]<-"francis_boily"
  collab$etudiant2[collab$etudiant2%in% "francis_bourrassa"]<-"francis_bourassa"
  collab$etudiant2[collab$etudiant2%in% "frederick_laberge"]<-"frederic_laberge"
  collab$etudiant2[collab$etudiant2%in% "ihuoma_elsie-ebere"]<-"ihuoma_elsie_ebere"
  collab$etudiant2[collab$etudiant2%in% "jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"
  collab$etudiant2[collab$etudiant2%in% "justine_lebelle"]<-"justine_labelle"
  collab$etudiant2[collab$etudiant2%in% "laurie_anne_cournoyer"]<-"laurie-anne_cournoyer"
  collab$etudiant2[collab$etudiant2%in% "louis-phillippe_theriault"]<-"louis-philippe_theriault"                   
  collab$etudiant2[collab$etudiant2%in% "madyson_mcclean"]<-"madyson_mclean"
  collab$etudiant2[collab$etudiant2%in% "mael_guerin"]<-"mael_gerin"
  collab$etudiant2[collab$etudiant2%in% "marie_burghin"]<-"marie_bughin"
  collab$etudiant2[collab$etudiant2%in% "marie_christine_arseneau"]<-"marie-christine_arseneau"
  collab$etudiant2[collab$etudiant2%in% "marie_eve_gagne"]<-"marie-eve_gagne"
  collab$etudiant2[collab$etudiant2%in% "noemie_perrier-mallette"]<-"noemie_perrier-malette"
  collab$etudiant2[collab$etudiant2%in% "peneloppe_robert"]<-"penelope_robert"
  collab$etudiant2[collab$etudiant2%in% "philippe_barette"]<-"philippe_barrette"
  collab$etudiant2[collab$etudiant2%in% "phillippe_bourassa"]<-"philippe_bourassa"
  collab$etudiant2[collab$etudiant2%in% "philippe_bourrassa"]<-"philippe_bourassa"
  collab$etudiant2[collab$etudiant2%in% "philippe_leonard_dufour"]<-"philippe_leonard-dufour"
  collab$etudiant2[collab$etudiant2%in% "raphael_charlesbois"]<-"raphael_charlebois"
  collab$etudiant2[collab$etudiant2%in% "sabrica_leclercq"]<-"sabrina_leclercq"
  collab$etudiant2[collab$etudiant2%in% "sara_jade_lamontagne"]<-"sara-jade_lamontagne"
  collab$etudiant2[collab$etudiant2%in% "savier_samson"]<-"xavier_samson"
  collab$etudiant2[collab$etudiant2%in% "yannick_sageau"]<-"yanick_sageau"
  collab$etudiant2[collab$etudiant2%in% "yanick_sagneau"]<-"yanick_sageau"
  
  #modification sigle 
  collab$sigle[collab$sigle%in%"GAE500"]<-"GAE550"
  
  for(col in names(collab)){
    collab[,col]<-str_replace_all(collab[,col],pattern="\\s",replacement="")
  }
  for(col in names(collab)){
    collab[,col]<-str_replace_all(collab[,col],pattern="<a0>",replacement="")
  }
  for(col in names(collab)){
    collab[,col]<-str_replace_all(collab[,col],pattern="�",replacement="")
  }
  
  #corriger lignes qui voient dans le futur
  collab$session[collab$session%in% "E2023"]<-"E2022"
  
  #vérification collab compare a etudiant
  collab<-collab%>%
    arrange(etudiant1)
  unique(collab$etudiant1)
  #etudiant 2
  collab<-collab%>%
    arrange(etudiant2)
  unique(collab$etudiant2)
  
  #valider sigle
  collab<-collab%>%
    arrange(sigle)
  unique(collab$sigle)
  
  # enlever ligne 3201 à 3207 de NA
  
  collab<-collab[-(3201:3207),]
  
  #FIN CORRECTIONS COLLABORATION 
  #lister les sorties
  nett_list<-list(etudiant,collab,cours)
  return(nett_list)
}
