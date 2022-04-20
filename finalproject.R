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
