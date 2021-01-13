### Running Rock Stars Shiny App ###
### Authors: Rock Stars Team 

#Description of app:
"In this shiny app, the user can compare different genre of music with different audio features.
The data is collected from Spotify and it shows three plots in this app: 
they're time plot; scatterplot and boxplot. In the time plot and scatter plot, 
these two plots will show the overall pattern of different audio features; 
also, users can choose two artists from different genres and the points will be highlighted in these two plots.
In the boxplot, the user can choose two different artists to compare the specific audio features 
and it will show the variabilities of these two artists. From this app, users would be able to learn 
the music style changes over the year and the preference change of music;
also, user could check their favorite artists and do the comparison."

#Citation
"https://developer.spotify.com/"
"STA504 class notes"
"https://www.rdocumentation.org/packages/shiny/versions/1.3.2/topics/wellPanel"
"http://www.sthda.com/english/wiki/colors-in-r"
"https://community.rstudio.com/t/multiple-conditions-in-condition-panel-r-shiny/13492"

library(shiny)
library(tidyverse)
library(plotly)
library(stringr)


load(file="song_data3.RData")

# remove "Other" genre from consideration
song_data3<- song_data3 %>% 
  filter(genre != "Other")

# make artist a character variable
song_data3$artist<-as.character(song_data3$artist)
song_data3$album.name<-as.character(song_data3$album.name)
song_data3$name<-as.character(song_data3$name)
song_data3$album.name<-as.character(song_data3$album.name)

# make an audio feature variable
audio_vars<-c("danceability",
              "energy",
              "loudness",
              "speechiness",
              "acousticness",
              "instrumentalness",
              "liveness",
              "valence",
              "tempo",
              "popularity")

# make an genre variable
genre_vars<-c("Rock",
              "Country",
              "Blues")

### Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Comparison of Rock, Country, and Blues!"),
  
  # Sidebar with a slider input  
  sidebarPanel(
    #Conditional panel for timeplot tab
    conditionalPanel(condition="input.tabs == 'timeplot'",
                     #create a dropdown menu
                     selectInput(inputId="y_var", label="Choose a Y Variable",
                                 choices =audio_vars
                     ),
                     selectInput(inputId="mygenre", label="Choose a Genre",
                                 choices =mygenre<-c("All","Rock","Blues","Country")
                     ),
                     #create a checkbox
                     checkboxInput("NoSmooth","Smooth Line")
    ),
    #Conditional panel for scatter and boxplot tabs
    conditionalPanel(
      condition="input.tabs!=='timeplot'",
      wellPanel(
        h4("Select Two Artists"),
        radioButtons(inputId="genre1", label="Select Genre for Artist 1",
                     choices=genre_vars),
        
        uiOutput("artist1"),
        
        radioButtons(inputId="genre2", label="Select Genre for Artist 2",
                     choices=genre_vars,selected = "Blues"),
        
        uiOutput("artist2")
      ),
      wellPanel(
        h4("Select Audio Features"),
        selectInput(inputId="yvar", label="Audio Feature (Y)",
                    choices=audio_vars, selected = "loudness"),
        
        uiOutput(outputId = "xvar")
      )
    )
  ),
  
  
  ### Show a plot 
  mainPanel(
    #create three tabs
    tabsetPanel(id="tabs",
                tabPanel("timeplot", plotOutput(outputId="timeplot"),
                         br(),
                         p("Instruction: For this time plot, the user can choose the audio feature 
                           using the first drop-down menu 
                           and choose a genre that need to present using the second drop-down menu.
                           Also, the user can use the check box to show the smooth line 
                           and uncheck it to hide the smooth line.")),
                
                tabPanel("scatter", plotlyOutput(outputId="scatterplot"),
                         br(),
                         p("Instruction: For this scatterplot, the user can choose two different artists to compare the audio features.
                           The artist is ordered by genre, you can choose a genre then pick the artists you want to compare using the drop-down menu. 
                           Then you can choose the two different audio features using another two drop-down menu 
                           then you can see the overall pattern in the scatterplot 
                           and the two artist you pick will be highlighted in the scatterplot.")),
                
                tabPanel("boxplot", plotlyOutput(outputId="boxplot"),
                         br(),
                         p("Instruction: For this boxplot, the user can choose the two different artists to compare the audio features. 
                           The artist is ordered by genre, you can choose a genre then pick the artists 
                           you want to compare using the drop-down menu."))
                         )
                         )
                         )





### Define server logic required to draw plots
server <- function(input, output) {
  ##logic for timeplot
  output$timeplot <- renderPlot({
  
    #create year variable to plot timeplot 
    subdata_date<-song_data3 %>%
      filter(album.release_date_precision=="day")%>%
      mutate(year=str_sub(album.release_date,1,4))%>%
      mutate(year=as.numeric(year))
    genre_colors <- c("#F8766D","#7CAE00","#619CFF")
    names(genre_colors) <- unique(subdata_date$genre)
    
    #if genre is 'All three genre' then create a scatter plot with the subdata created above
    if(input$mygenre == "All"){
      
      #scatter plot without smooth line
      p3 <- ggplot(aes_string(x="year", y=input$y_var,color="genre"), 
                   data=subdata_date) +
        geom_point()+
        scale_color_manual(values=genre_colors[subdata_date$genre])+
        labs(x="Year",y=str_to_title(input$y_var),
             title = "Audio Feature Across Time",
             caption="Data Source:Spotify Premium, 
             \nPlot Built by Line Lee, Matt Misterka, Yanrui Huang ")+
        theme_bw()+
          theme(plot.title = element_text(hjust = 0.5))
      
      #Include smooth line on the scatter plot
      p4 <- ggplot(aes_string(x="year", y=input$y_var,color="genre"),
                   data=subdata_date) +
        geom_point()+
        geom_smooth(se=FALSE)+
        labs(x="Year",y=str_to_title(input$y_var),
             title = "Audio Feature Across Time",
             caption="Data Source:Sporify, \nPlot Built by Team RockStar")+
        scale_color_manual(values=genre_colors[subdata_date$genre])+
        theme_bw()+
        theme(plot.title = element_text(hjust = 0.5))
    
    }
    
    else{  
      #Assign a color for each genre and create a colorlist
      colorlist <<- list("Blues"="#619CFF",
                         "Rock"="#F8766D",
                         "Country"="#7CAE00")
      
      #create a scatter plot for a selected genre
      sub_subdata<-subset(subdata_date, subdata_date$genre==input$mygenre)
      
      #scatter plot without smooth line using sub_subdata with selected genre
      p3 <- ggplot(aes_string(x="year", y=input$y_var),
                   data=sub_subdata)+
        geom_point(color=colorlist[input$mygenre])+
        labs(x="Year",y=str_to_title(input$y_var),
             title = "Audio Feature Across Time",
             caption="Data Source:Sporify, \nPlot Built by Team RockStar")+
        theme_bw()+
        theme(plot.title = element_text(hjust = 0.5))
      
      #scatter plot with smooth line using sub_subdata with selected genre
      p4 <- ggplot(aes_string(x="year", y=input$y_var),
                   data=sub_subdata) +
        geom_point(color=colorlist[input$mygenre])+
        geom_smooth(colour=colorlist[input$mygenre],se=FALSE)+
        labs(x="Year",y=str_to_title(input$y_var),
             title = "Audio Feature Across Time",
             caption="Data Source:Sporify, \nPlot Built by Team RockStar")+
        theme_bw()+
        theme(plot.title = element_text(hjust = 0.5,size=10))
    }
    
    
    # show plot if checkbox is checked, otherwise hide it.
    
    if(input$NoSmooth == TRUE)
    {print(p4)} else {
      print(p3)   
    }
    
  })
##Logic for scatterplot from here
   
  #create dropdown menu to select two genres and two aritsts for the genres
  output$xvar <- renderUI({
    conditionalPanel(condition="input.tabs == 'scatter' ",
    selectInput(inputId="xvar", label="Audio Feature (X)",
                choices = audio_vars[audio_vars != input$yvar] ,
                selected = "energy"))
   })
  
  output$artist1 <- renderUI({
    selectInput(inputId="artist1", label="Select an Artist 1",
                choices=sort(unique(song_data3$artist[song_data3$genre==input$genre1])),
                selected = "Green Day")
  })
  
  output$artist2 <- renderUI({
    selectInput(inputId="artist2", label="Select an Artist 2",
                choices=sort(unique(song_data3$artist[song_data3$genre==input$genre2])),
                selected = "Aretha Franklin")
  })
  
#create scatterplot to compare audio feature of two artists using ggplotly
  output$scatterplot <- renderPlotly({
    
    select_artists <- c(input$artist1, input$artist2)
    #filter data having only selected artists
    select_songs <- filter(song_data3, artist %in% select_artists)
    
    p1 <- ggplot()+
      geom_point(aes_string(x=input$xvar,
                            y=input$yvar),color="#bdbdbd",
                 data=song_data3)+
      labs(x=str_to_title(input$xvar),y=str_to_title(input$yvar),
           title = "Comparison of Audio Features",
           caption="Data Source:Sporify, \nPlot Built by Team RockStar")+
      geom_point(aes_string(x=input$xvar,
                            y=input$yvar,label="name",color="artist"),
                 data=select_songs)+ 
      theme_bw()+
      theme(plot.title = element_text(hjust = 0.5,size=12))

    ggplotly(p1)

  })
  
##logic for boxplot from here  
#create boxplot to compare distribution of audio feature between two artists using ggplotly
  output$boxplot <- renderPlotly({
    select_artists <- c(input$artist1, input$artist2)
    select_songs <- filter(song_data3, artist %in% select_artists)
    
    p2 <-  ggplot()+
      geom_boxplot(aes_string(x="artist",
                             y=input$yvar,
                             fill="artist"),
                  data=select_songs)+
      theme_bw()+
      labs(y=str_to_title(input$yvar),x="Artist",
           title = "Distribution of Audio Feature",
           caption="Data Source:Spotify Premium, 
             \nPlot Built by Line Lee, Matt Misterka, Yanrui Huang ")+
      theme(legend.position = "none")+
      theme(plot.title = element_text(hjust = 0.5))
    ggplotly(p2)
  })
  

}

### Run the application 
shinyApp(ui = ui, server = server)

