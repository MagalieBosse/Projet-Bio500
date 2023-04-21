clean_data = function(data){
  data_list = lapply(data, function(x) read.table(x, sep=';'))
  data_8 = lapply(data,read.table("./donnees_BIO500/8_etudiant.csv", quote = ""))
  data_list[[16]]<-data_list[[16]][-(36:40),]
  data_list[[26]]<-subset(data_list[[26]],select = -c(...9))
  data_list[[20]]<-subset(data_list[[20]],select = -c(X))
  data_list[[8]]<-subset(data_list[[8]],select = -c(X))
  data_list[[11]]<-subset(data_list[[11]],select = -c(X))
  data_list[[21]]<- subset(data_list[[21]],select = -c(X, X.1, X.2, X.3, X.4))
  data_list[[19]]<- subset(data_list[[19]],select = -c(X, X.1, X.2, X.3, X.4, X.5))
  data_list[[19]]<-data_list[[19]][-(13:235),]
  colnames(data_list[[11]])[colnames(data_list[[11]]) == "prenom_nom."] <- "prenom_nom"
  colnames(data_list[[11]]) <- colnames(data_list[[11]])
  data_list[[15]]<-data_list[[15]][-(723),]
  colnames(data_list[[10]])[colnames(data_list[[10]]) == "ï..sigle"] <- "sigle"
  colnames(data_list[[10]]) <- colnames(data_list[[10]])
  data_list[[13]]<- subset(data_list[[13]],select = -c(X))
  data_list[[13]]<-data_list[[13]][-(28),]
  data_list[[28]]<-data_list[[28]][-(25:29),]
  data_list[[17]]<-data_list[[17]][-(52:59),]
  etudiant<-rbind(data_list[[2]],data_list[[8]],data_list[[11]],data_list[[14]],data_list[[17]],data_list[[20]],data_list[[23]],data_list[[26]],data_list[[29]],data_list[[5]],deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
  collab<-rbind(data_list[[3]],data_list[[9]],data_list[[12]],data_list[[15]],data_list[[18]],data_list[[21]],data_list[[24]],data_list[[27]],data_list[[30]],data_list[[6]],deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
  cours<-rbind(data_list[[1]],data_list[[7]],data_list[[10]],data_list[[13]],data_list[[16]],data_list[[19]],data_list[[22]],data_list[[25]],data_list[[28]],data_list[[4]],deparse.level=1,make.row.name=TRUE,stringsAsFactors=default.stringsAsFactors(),factor.exclude=TRUE)
}
clean_uniforme = function(clean_data){
  etudiant<-etudiant[-(396),]
  collab<-collab[-(5203),]
  etudiant[etudiant==""]<-NA
  collab[collab==""]<-NA
  cours[cours==""]<-NA
  cours<-unique(cours,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
  collab<-unique(collab,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
  etudiant<-unique(etudiant,imcoparables=FALSE,MARGIN=1,fromLast=FALSE)
  etudiant$regime_coop[etudiant$regime_coop%in% "FALSE"]<- "FAUX"
  etudiant$regime_coop[etudiant$regime_coop%in% "TRUE"]<- "VRAI"
}
clean_data_cours = function(clean_uniforme){
  cours<-cours[-(326),]
  cours<- cours[cours$sigle!="TRUE",]
  cours$optionnel[cours$optionnel%in% "FALSE"]<- "FAUX"
  cours$optionnel[cours$optionnel%in% "TRUE"]<- "VRAI"
  cours$optionnel[cours$optionnel%in% "Faux"]<- "FAUX"
  cours$optionnel<-ifelse(cours$sigle=="BCM112",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="BCM113",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL406",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL527",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL610",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL611",'FAUX', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="TSB303",'FAUX', cours$optionnel)  
  cours$optionnel<-ifelse(cours$sigle=="BIO401",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL215",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL315",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL522",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ECL544",'VRAI', cours$optionnel)
  cours$optionnel<-ifelse(cours$sigle=="ZOO304",'VRAI', cours$optionnel)
  cours$credits<-ifelse(cours$sigle=="BIO109",'1', cours$credits)
  cours$credits<-ifelse(cours$sigle=="ECL515",'2', cours$credits)
  cours$credits<-ifelse(cours$sigle=="TSB303",'2', cours$credits)
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
}
clean_data_etudiant = function(clean_uniforme){
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
  etudiant$prenom[etudiant$prenom%in% "yannick"]<-"yanick"
  etudiant$prenom[etudiant$prenom%in% "arianne"]<-"ariane"
  etudiant$prenom[etudiant$prenom%in% "peneloppe"]<-"penelope"
  etudiant$prenom[etudiant$prenom%in% "sara-jade"]<- "sara_jade"
  etudiant$prenom[etudiant$prenom%in% "louis-phillipe"]<- "louis-philippe"
  etudiant$prenom[etudiant$prenom%in% "cassandre"]<- "cassandra"
  etudiant$prenom[etudiant$prenom%in% "louis_philippe"]<- "louis-philippe"
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
  etudiant$region_administrative[etudiant$region_administrative%in% "monterigie"]<- "monteregie"
  etudiant$region_administrative[etudiant$region_administrative%in% "bas-st-laurent"]<- "bas-saint-laurent"
  doubles_etudiant<-duplicated(etudiant$prenom_nom)
  extrait_etudiant<-subset(etudiant,doubles_etudiant)
  for(col in names(etudiant)){
    etudiant[,col]<-str_replace_all(etudiant[,col],pattern="\\s",replacement="")
  }
  for(col in names(etudiant)){
    etudiant[,col]<-str_replace_all(etudiant[,col],pattern="<a0>",replacement="")
  }
  for(col in names(etudiant)){
    etudiant[,col]<-str_replace_all(etudiant[,col],pattern="�",replacement="")
  }
  etudiant<-etudiant%>%
    arrange(region_administrative)
  etudiant<-subset(etudiant,!duplicated(etudiant$prenom_nom))
  etudiant<-etudiant%>%
    arrange(prenom_nom)
}

clean_data_collab = function(clean_uniforme){
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
  collab$session[collab$session%in% "E2023"]<-"E2022"
  collab<-collab[-(3201:3207),]  
}