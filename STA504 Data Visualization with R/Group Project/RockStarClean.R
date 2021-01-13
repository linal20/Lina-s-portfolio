### Data scraping and cleaning for Rock Stars Shiny App ###
### Authors: Rock Stars Team 
### data taken from: https://developer.spotify.com/

# Load packages and necessary tools ---------------
library("tidyverse")
library("spotifyr")
library("Rspotify")

setwd("C:\\Users\\Matt\\Documents\\STA504_Project2")


### keys for spotify functions
Sys.setenv(SPOTIFY_CLIENT_ID = "eb6d334cb1b94da6bad8fab4c7cf5ace")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "921542d9014c48b3b6905df9331f8649")

### grab rock, country, and blues artists from genres
classic_rock<-get_genre_artists("classic rock",limit = 50)
rock<-get_genre_artists("rock",limit = 50)
country<-get_genre_artists("country",limit = 50)
country_road<-get_genre_artists("country road",limit = 50)
blues<-get_genre_artists("blues",limit = 50)

rock<-rbind(classic_rock,rock)
country<-rbind(country,country_road)
### remove duplicated artists
rock<-rock[!duplicated(rock$name), ]
### remove duplicated artists
country<-country[!duplicated(country$name), ]
### rbind all of the artists
music<-rbind(rock,country,blues)
### remove duplicated artists
music<-music[!duplicated(music$name), ]
music<-music %>% 
  select(id,images,name,popularity,followers.total,genre)

remove(list=c("blues","classic_rock","country",
              "country_road","rock"))

### grab songs from 183 artists ###
result<-NULL
for (i in 1:183){
  songs<-get_artist_top_tracks(music[i,1])
  result<-rbind(result,songs)
}

### compress songs into lists of 100 songs
### tried to make this more efficient
### using below code

# result2<-NULL
# for(i in seq(from = 1,to = 1800, by=100)){
#   
#   for(t in 1:18){
#     
#     result2[t]<-list(paste0(result$id[i:(i+100)-1], collapse=","))
#   }
# }
# result2[[19]]<-list(paste0(result$id[1801:1822], collapse=","))

tracks1<-list(paste0(result$id[1:100], collapse=","))
tracks2<-list(paste0(result$id[101:200], collapse=","))
tracks3<-list(paste0(result$id[201:300], collapse=","))
tracks4<-list(paste0(result$id[301:400], collapse=","))
tracks5<-list(paste0(result$id[401:500], collapse=","))
tracks6<-list(paste0(result$id[501:600], collapse=","))
tracks7<-list(paste0(result$id[601:700], collapse=","))
tracks8<-list(paste0(result$id[701:800], collapse=","))
tracks9<-list(paste0(result$id[801:900], collapse=","))
tracks10<-list(paste0(result$id[901:1000], collapse=","))
tracks11<-list(paste0(result$id[1001:1100], collapse=","))
tracks12<-list(paste0(result$id[1101:1200], collapse=","))
tracks13<-list(paste0(result$id[1201:1300], collapse=","))
tracks14<-list(paste0(result$id[1301:1400], collapse=","))
tracks15<-list(paste0(result$id[1401:1500], collapse=","))
tracks16<-list(paste0(result$id[1501:1600], collapse=","))
tracks17<-list(paste0(result$id[1601:1700], collapse=","))
tracks18<-list(paste0(result$id[1701:1800], collapse=","))
tracks19<-list(paste0(result$id[1801:1822], collapse=","))

### these functions take a list of 100 songs each and get audio features
### below is code from one of the lists of 100 that I tried to grab the features from
# want<-get_track_audio_features(result2[[1]], authorization = get_spotify_access_token())
songs1<-get_track_audio_features(tracks1, authorization = get_spotify_access_token())
songs2<-get_track_audio_features(tracks2, authorization = get_spotify_access_token())
songs3<-get_track_audio_features(tracks3, authorization = get_spotify_access_token())
songs4<-get_track_audio_features(tracks4, authorization = get_spotify_access_token())
songs5<-get_track_audio_features(tracks5, authorization = get_spotify_access_token())
songs6<-get_track_audio_features(tracks6, authorization = get_spotify_access_token())
songs7<-get_track_audio_features(tracks7, authorization = get_spotify_access_token())
songs8<-get_track_audio_features(tracks8, authorization = get_spotify_access_token())
songs9<-get_track_audio_features(tracks9, authorization = get_spotify_access_token())
songs10<-get_track_audio_features(tracks10, authorization = get_spotify_access_token())
songs11<-get_track_audio_features(tracks11, authorization = get_spotify_access_token())
songs12<-get_track_audio_features(tracks12, authorization = get_spotify_access_token())
songs13<-get_track_audio_features(tracks13, authorization = get_spotify_access_token())
songs14<-get_track_audio_features(tracks14, authorization = get_spotify_access_token())
songs15<-get_track_audio_features(tracks15, authorization = get_spotify_access_token())
songs16<-get_track_audio_features(tracks16, authorization = get_spotify_access_token())
songs17<-get_track_audio_features(tracks17, authorization = get_spotify_access_token())
songs18<-get_track_audio_features(tracks18, authorization = get_spotify_access_token())
songs19<-get_track_audio_features(tracks19, authorization = get_spotify_access_token())

### put all songs in one data frame
song_data<-rbind(songs1,songs2,songs3,songs4,songs5,songs6,songs7,
                 songs8,songs9,songs10,songs11,songs12,songs13,songs14,
                 songs15,songs16,songs17,songs18,songs19)

### inner join the audio features to all of the songs
### inner join takes matches in both
song_data2<-inner_join(result,song_data,by="id")

### for some reason there were 1822 songs and it jumps to 1840
### remove songs with duplicated ids
song_data2<-song_data2[!duplicated(song_data2$id), ]

### getting artist names
### appears to be multiple artists on a song
result<-NULL
for (i in 1:1814){
  want<-song_data2$artists[[i]]
  want2<-want$name
  result<-rbind(result,want2)
}

### getting album artist names
### appears to be multiple album artists on a song
result2<-NULL
for (i in 1:1814){
  want<-song_data2$album.artists[[i]]
  want2<-want$name
  result2<-rbind(result2,want2)
}

### create artist vectors
artist<-as.vector(result)
album.artist<-as.vector(result2)

### add artist names to song_data
song_data2<-cbind(artist,album.artist,song_data2)


### find genre cutoffs
### I looked through the music data set
### and found cutoff rows for the genres
rock.genre<-music$name[1:88]
country.genre<-music$name[89:146]
blues.genre<-music$name[147:183]

song_data2$genre<-NA

### relabel 5 genres in music to be rock, country, and blues.  
song_data2$genre<-ifelse(song_data2$artist %in% rock.genre,"Rock",NA)
song_data2$genre<-ifelse(song_data2$artist %in% country.genre,"Country",song_data2$genre)
song_data2$genre<-ifelse(song_data2$artist %in% blues.genre,"Blues",song_data2$genre)

song_data2$genre<-ifelse(is.na(song_data2$genre),"Other",song_data2$genre)

### remove duplicate columns
song_data2<- song_data2[, !duplicated(colnames(song_data2))]

#### past datasets that we didn't use are named "song_data2.RData"
song_data3<-song_data2

### save file 
save(song_data3,file = "song_data3.RData")
