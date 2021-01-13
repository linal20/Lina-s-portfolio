#Title: Word cloud using Billboard Top 100 songs' lyrics
#Purpose: Explanation about files included in the zip.file
#Author:Lina Lee

-File-
billboard_lyrics_1964-2015.csv: original data
time1.txt: txt file for time period "1964-1979" 
time2.txt: txt file for time period "2000-2015" 
d1.Rdata: R data for time period "1964-1979" 
d2.Rdata: R data for time period "2000-2015" 

txt.file was needed to created to "d1.Rdata" and "d2.Rdata".
Shiny app is run by only "d1.Rdata" and "d2.Rdata".

-Original data description:
The data contains the lyrics of songs on Billboard Year-End Hot 100 for 1965-2015.
The dataset has 5100 observations and include 'Rank', 'Song', 'Artist', 'Year','Lyrics, 'Source' as variables.
Each observation consists of a song.

-Code-
DataCleaning_LinaLee: R code file for Data cleaning
ShinyApp_LinaLee: R Code file for Shiny App

