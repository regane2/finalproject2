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
swift %>% distinct(album_name)
albums_to_keep <- swift %>% 
  filter(grepl("\\(", album_name)) %>% 
  filter(!grepl('Karaoke', album_name)) %>%
  filter(!grepl('Big Machine Radio Release Special', album_name)) %>% 
  filter(!grepl('Japanese Version', album_name)) %>% 
  filter(!grepl('Deluxe_package', album_name)) %>% 
  select(album_name) %>% 
  distinct(album_name) %>% 
  pull(album_name)
albums_to_keep
albums_to_keep <- c(albums_to_keep, 'reputation')
albums_to_keep <- c(albums_to_keep, 'Taylor Swift')
swift_condensed <- swift %>% 
  filter(album_name %in% albums_to_keep) %>% distinct()
View(swift_condensed)
colnames(swift_condensed)
swift_condensed <- swift_condensed %>% select(artist_name, album_type, album_release_date, danceability, energy, key, loudness, mode, speechiness, acousticness, instrumentalness, liveness, valence, time_signature, duration_ms, explicit, track_name, track_number, album_name, key_mode) %>% distinct()
#add rep, combine 1989, add Taylor Swift debut, and keep deluxe sn 