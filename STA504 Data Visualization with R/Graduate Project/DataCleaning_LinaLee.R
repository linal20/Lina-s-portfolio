#Title:Create word cloud using Billboard Top 100 songs' lyrics
#Purpose:Cleaning data
#Author:Lina Lee
#Date:May/10/2019

#Description about data cleaning#

"Original data was created by Kaylin Pavlik. Source is https://github.com/walkerkq/musiclyrics
However, I download it from https://www.kaggle.com/rakannimer/billboard-lyrics
The data contains the lyrics of songs on Billboard Year-End Hot 100 for 1965-2015.
The dataset has 5100 observations and include 'Rank', 'Song', 'Artist', 'Year','Lyrics, 'Source' 
as variables. For data cleaning, I extracted lyrics from original data manually and
put it into two excel file by time period ('1965-1970'/'2000-2015'),and then transformed the each
excel file into a txt file. Second, I read the txt file into R using reaLines(),and cleaned the text data 
using package 'tm' and 'tidyverse' in R. I remove unnecessary space, characters, and words. 
After cleaning the text data, I made the text into a matrix. A row now consisted of the word and its frequency. 
and then I transformed the matrix into Rdataset. I did this same process twice for two datasets for two time periods. 
Finally, I got data 'd1' and 'd2' for analysis."



library("tm")
library("wordcloud")
library("RColorBrewer")
library("tidyverse")


#1. Create R data for time period 1965-2015 

#Read txt file into R
text1 <- readLines("C:/Users/linal/Desktop/2019 spring/visual/gradproject2/time1.txt")
docs1 <- Corpus(VectorSource(text1))


#Remove unnecessary characters
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs1 <- tm_map(docs1, toSpace, "/")
docs1 <- tm_map(docs1, toSpace, "@")
docs1 <- tm_map(docs1, toSpace, "\\|")

# Convert the text to lower case
docs1 <- tm_map(docs1, content_transformer(tolower))
# Remove numbers
docs1 <- tm_map(docs1, removeNumbers)
# Remove english common stopwords
docs1 <- tm_map(docs1, removeWords, stopwords("english"))
# Remove punctuations
docs1 <- tm_map(docs1, removePunctuation)
# Eliminate extra white spaces
docs1 <- tm_map(docs1, stripWhitespace)

# Remove your stopwords as a character vector
docs1 <- tm_map(docs1, removeWords, c("dont", "yeah","one","just",
                                      "get","got","hey","right","cant","make",
                                      "youre","good","around","another","let","youve","say",
                                      "thats","know","can","wanna","gonna","aint","lets",
                                      "things","ooh","said","ever","ive","gotta","wont","put")) 


#Create a matrix of words
dtm1 <- TermDocumentMatrix(docs1)
m1 <- as.matrix(dtm1)
v1 <- sort(rowSums(m1),decreasing=TRUE)
#Transform a matrix of words into a data 
d1 <- data.frame(word = names(v1),freq=v1)


#Create groups by ranking (each group consists of ranking 1 or 2 or 3-6 or 7-10) and assign a number to each group
#This process is for assigning a same color to the words in each group later
d1<-d1%>%
  #Rank by frequency
  mutate(rank=order(-d1$freq))%>%
  filter(rank<=300)%>%
  #Create groups by ranking
  mutate(cut=cut(rank, 
                 breaks=c(0,1,2,6,10,300), 
                 labels=c(1,2,3,4,5)))

# Save the data into R file
save(d1,file="C:/Users/linal/Desktop/2019 spring/visual/gradproject2/d1.Rdata")

#2. Create clean data for time period 2000-2010s 

#Read txt file into R
text2 <- readLines("C:/Users/linal/Desktop/2019 spring/visual/gradproject2/time2.txt")
docs2 <- Corpus(VectorSource(text2))

#Remove unnecessary characters
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs2 <- tm_map(docs2, toSpace, "/")
docs2 <- tm_map(docs2, toSpace, "@")
docs2 <- tm_map(docs2, toSpace, "\\|")

# Convert the text to lower case
docs2 <- tm_map(docs2, content_transformer(tolower))
# Remove numbers
docs2 <- tm_map(docs2, removeNumbers)
# Remove english common stopwords
docs2 <- tm_map(docs2, removeWords, stopwords("english"))
# Remove your own stop word

# Remove punctuations
docs2 <- tm_map(docs2, removePunctuation)
# Eliminate extra white spaces
docs2 <- tm_map(docs2, stripWhitespace)

# Specify stopwords as a character vector
docs2 <- tm_map(docs2, removeWords, c("dont", "yeah","one","just",
                                      "get","got","hey","right","cant","make",
                                      "youre","good","around","another","let","youve","say",
                                      "thats","know","can","wanna","gonna","aint","lets",
                                      "things","ooh","said","ever","ive","gotta","wont","put")) 

#Create a matrix of words

dtm2 <- TermDocumentMatrix(docs2)
m2 <- as.matrix(dtm2)
v2 <- sort(rowSums(m2),decreasing=TRUE)

#Transform a matrix of words into a R data 
d2 <- data.frame(word = names(v2),freq=v2)

#Create group by ranking of frequency and assign a number to each group

d2<-d2%>%
  mutate(rank=order(-d2$freq))%>%
  filter(rank<=300)%>%
  mutate(cut=cut(rank, 
                 breaks=c(0,1,2,6,10,300), 
                 labels=c(1,2,3,4,5)))

# Save the data into R file 
save(d2,file="C:/Users/linal/Desktop/2019 spring/visual/gradproject2/d2.Rdata")