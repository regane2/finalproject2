#Question: What makes 1989 one of the most popular Taylor Swift albums? 
#By: Someone who has 1989 at the Bottom of her tier ranking. (reputation supremacy)

library(spotifyr)
library(tidyverse)
library(knitr)

#getting the data 
Sys.setenv(SPOTIFY_CLIENT_ID = 'c68051dec4174364a2748645aa18c878')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '61253abe841a49659ff9a901ad688e85')
access_token <- get_spotify_access_token() 
swift <- get_artist_audio_features('taylor swift')
View(swift)

#slicing and dicing 
#I got rid of the original albums, live versions, Karaoke, Radio Release, and others so that it is down to the Deluxe Editions. There are duplicates but that's because I can't figure that out. Which. Fair enough. 
swift %>% distinct(album_name)
albums_to_keep <- swift %>% 
  filter(grepl("\\(", album_name)) %>% 
  filter(!grepl('Karaoke', album_name)) %>%
  filter(!grepl('Big Machine Radio Release Special', album_name)) %>% 
  filter(!grepl('US Version', album_name)) %>% 
  filter(!grepl('Japanese Version', album_name)) %>%
  filter(!grepl("International Version", album_name)) %>%
  filter(!grepl('Deluxe Package', album_name)) %>% 
  filter(!grepl('1989', album_name)) %>% 
  select(album_name) %>% 
  distinct(album_name) %>% 
  pull(album_name)
albums_to_keep
albums_to_keep <- c(albums_to_keep, 'reputation')
albums_to_keep <- c(albums_to_keep, 'Taylor Swift')
albums_to_keep <- c(albums_to_keep, "Lover")
albums_to_keep <- c(albums_to_keep, "1989 (Deluxe Edition)")
swift_condensed <- swift %>% 
  filter(album_name %in% albums_to_keep) %>% distinct()
View(swift_condensed)
colnames(swift_condensed)
swift_condensed <- swift_condensed %>% select(artist_name, album_type, album_release_date, danceability, energy, key, loudness, mode, speechiness, acousticness, instrumentalness, liveness, valence, time_signature, duration_ms, explicit, track_name, track_number, album_name, key_mode) %>% distinct() 


#The Plots (said in the same voice as the aliens saying the claw in Toy Story)
ggplot(swift_condensed, aes(x= track_number, y= danceability, color = album_name)) + geom_point()
ggplot(swift_condensed, aes(x = danceability, y= album_name)) + geom_point()
swift_condensed %>% group_by(album_name) %>% summarize(mean_danceability= mean(danceability)) %>% ggplot(aes(x=mean_danceability, y= reorder(album_name, mean_danceability))) + geom_col()

#The decision 
# People like 1989 the most because it is one of the most danceable albums! Also go me for predicting 1989 rerecord kinda! (she's releasing This love (TV) May 5th midnight!)
# 