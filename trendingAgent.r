library("twitteR")
library("dplyr")
library("readr")
library("tidyr")

APIkey <- #API key
APIsecret <- #API secret
tokenKey <- #token key
tokenSecret <-#token secret
setup_twitter_oauth(APIkey, APIsecret, tokenKey, tokenSecret)

# I want to use the lat and long of Soldier Field
# Google says 41.8623° N, 87.6167° W

mywoeid <- closestTrendLocations(lat=41.8623, long=-87.6167)$woeid
# Chicago woeid = 2379574, used when finding what's trending locally
# leading up to a football game, what would be trending?

# making a directory for trending data
if(dir.exists("~/chicago/data/trending/")==FALSE){
  dir.create("~/chicago/data/trending/")
}
# this loop will read what's trending once every five minutes 15 times
# and accumulate them in a larger frame with datestamp info
i=1
bigTrending <- data_frame()
while(i < 16){
  trendPath <- paste("~/chicago/data/trending/", format(Sys.time(), format="%Y%m%d"), sep="")
  if(dir.exists(trendPath)==FALSE){
    dir.create(trendPath)  
  }
  trending <- getTrends(mywoeid)
  trending$dateTime <- Sys.time()
  trending$rank <- seq.int(nrow(trending))
  bigTrending <- bind_rows(bigTrending, trending)
  write_csv(trending, paste(trendPath, "/", format(Sys.time(), format="%Y%m%d%H%M"), ".csv", sep=""))
  i <- i+1
  remove(trending)
  save.image("~/chicago/data/trending.RData")
  # https://developer.twitter.com/en/docs/trends/trends-for-location/api-reference/get-trends-place
  # says the trends are cached for every 5 minutes
  Sys.sleep(300)
}
write_csv(bigTrending, paste(trendPath, "/bigtrending", format(Sys.time(), format="%Y%m%d%H%M"), ".csv", sep=""))
