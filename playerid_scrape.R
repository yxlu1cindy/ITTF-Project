library(dplyr)
library(RCurl)
library(XML)
library(rvest)
u = "http://ittfstats.alfaweb.gr/index.php?option=com_fabrik&view=list&listid=35&Itemid=155"   #??????url????????????????????????
#tt = getURLContent(u, verbose = TRUE)
#doc = htmlParse(tt)
#tbl = readHTMLTable(doc)
#tbl[[2]]

pgsession <- html_session(u)
pgform <- html_form(pgsession)[[1]]
i=1
filled_form <- set_values(pgform,
                          "limit35"="100","limitstart35"="0")
sbmt <- submit_form(pgsession,filled_form)
Text <- sbmt%>%html_table()
df = data.frame(Text[[2]])





#----------------------------------------------------------------------------
df = unique(df)
for (i in 1:338){
  ipa = 100*(i-1)
  pag = as.character(ipa)
  filled_form <- set_values(pgform,
                            'limit35'="100","limitstart35"=pag)
  sbmt <- submit_form(pgsession,filled_form)
  Text <- sbmt%>%html_table()
  te = data.frame(Text[[2]])
  df = rbind(df,te)
  
  df = unique(df)
}
df_new =df[grep(pattern = "Display", x = df$"Name")]
write.csv(df,"E://ITTFPLAYER.csv",row.names = FALSE) 