#acess to twitter - issue - not working
loc <- "~/data"
getwd()
setwd(loc)

#connect all libraries
library(twitteR)
library(ROAuth)
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)
library(tidytext)
library(rtweet)

# create token named "twitter_token"
twitter_token <- create_token("twitter_app_name","consumer_key","consumer_secret",set_renv = TRUE)

## search for 500 tweets using the #rstats hashtag
twitter_analysis <- as.data.frame(search_tweets(q="TrendingNow",n = 5000,include_rts = FALSE))

clean_Twitter_Data = function(y)
{
  y  <- gsub("[^ -~]", " ", y)
  y  <- gsub("&amp", " ", y )
  y  <- gsub("(RT|via)((?:\\b\\W*@\\w+)+)", " ", y )
  y  <- gsub("@\\w+", "", y )
  y  <- gsub("[[:punct:]]", " ", y )
  y  <- gsub("[[:digit:]]", " ", y )
  y  <- gsub("http\\w+", " ", y )
  y  <- gsub("[ \t]{2,}", " ", y )
  y  <- gsub("rt", "", y ) 
  y  <- gsub("@\\w+", "", y ) 
  y  <- gsub("[[:punct:]]", "", y ) 
  y  <- gsub("[[:digit:]]", "", y ) 
  y  <- gsub("http\\w+", "", y )  
  y  <- gsub("[ |\t]{2,}", "", y ) 
  y  <- gsub("^ ", "", y )  
  y  <- gsub(" $", "", y ) 
  y  <- gsub("^\\s+|\\s+$", " ", y ) 
  y  <- str_replace(y ,"RT @[a-z,A-Z]*: "," ")
  y  <- str_replace_all(y ,"#[a-z,A-Z]*"," ")
  y  <- str_replace_all(y ,"@[a-z,A-Z]*"," ")  
  y  <- str_replace_all(y , "http://t.co/[a-z,A-Z,0-9]*"," ")
  y  <- str_replace_all(y , "https://t.co/[a-z,A-Z,0-9]*"," ")
}

twitter_analysis$tweet_text_org <- twitter_analysis$text

clean_Twitter_Data(twitter_analysis$text)


twitter_analysis1 <- subset(twitter_analysis, select=c("status_id","text"))
write.csv(twitter_analysis1, 'twitter_anaslysis_final_clean.csv',row.names = FALSE)
