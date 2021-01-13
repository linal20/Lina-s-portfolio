#Title:Create word cloud using Billboard Top 100 songs' lyrics
#Purpose:Create a shiny app with a word cloud and a barplot
#Author:Lina Lee
#Date:May/06/2019

#Reference
"STA504 class notes"
"https://shiny.rstudio.com/gallery/word-cloud.html"

#Load package
library("shiny")
library("wordcloud")
library("RColorBrewer")
library("ggplot2")
library("tidyverse")


#Load the prepared dataset for each time period(1964-1979/2000-2015)

load(file="d1.RData")
load(file="d2.RData")


#UI
ui <-fluidPage(
  # Application title
  titlePanel("Top Frequent Words in the Billboard Top 100 Songs' Lyrics"),
  
  # Sidebar with a slider and selection inputs
  sidebarPanel(
    conditionalPanel(
      #Make a conditiona panel for word cloud tab
      condition="input.tabs=='Wordcloud'",
      selectInput(inputId ="selection", label="Choose a Time Period:",
                  choices = c("1964-1979","2000-2015")),
      sliderInput(inputId="freq",
                  label="Minimum Frequency:",
                  min = 0,  max = 4000, value = 200),
      sliderInput(inputId="max",
                  "Maximum Number of Words:",
                  min = 0,  max = 300,  value = 100)
    ),
    #Make a conditiona panel for barplot tab
    conditionalPanel(condition="input.tabs == 'Barplot'",
                     selectInput(inputId ="selection2", label="Choose a Time Period:",
                                 choices = c("1964-1979","2000-2015")),
                     sliderInput(inputId="freq2",
                                 label="Minimum Frequency:",
                                 min = 0,  max = 4000, value = 200),
                     sliderInput(inputId="max2",
                                 "Maximum Number of Words:",
                                 min = 10,  max = 30,  value = 100)
    )
  ),
  
  # Show plots
  mainPanel(
    tabsetPanel(id="tabs",
                tabPanel("Wordcloud", plotOutput(outputId="Wordcloud"),
                         p("Instruction: The user can choose one of two time periods (1945-1979/2000-2015)
                           from the dropdown menu. Displayed words need to have a frequency greater than
                           the specified minimum. The maximum number of words is the number of words displayed
                           in the wordcloud. Size of words represents frequency, and color of words represents
                           the ranking of the frequency for each word. Dark green represents Top1, orange for Top2,
                           blue for ranking 3-6, and pink for ranking 7-10"),
                         p("Description: For the period 1964-1975, the most frequent words are 'love', 'baby', 
                           'like', 'now', 'come', 'time','want','never','way','see'. For the period 2000-2015, 
                           the most frequent words are 'like', 'love', 'baby','now', 'girl', 'want', 
                           'cause', 'see', 'way', 'back'. As the minimum frequency becomes larger, 
                           the difference of the number of words displayed in each wordcloud between two time periods
                           becomes bigger."),
                         h5("Data was downloaded from:https://www.kaggle.com/rakannimer/billboard-lyrics")
                ),    
                
                tabPanel("Barplot", plotOutput(outputId="Barplot"),
                         br(),
                         p("Description: The main purpose of this barplot is to show the frequency of each top word 
                           displayed in the wordcloud for each time period. Moreover, by comparison, given minmum frequency
                           the number of words (x-values) displayed in each barpot is different bewtween two time periods. Also, the order of 
                           ranking of words based on the frequency are different between the two periods.The frequency of top words 
                           in newer time period has increased from that of the older time period,in general.
                           "))
                         )
                         )
                         )


server <-function(input, output) {
  #Create a wordcloud using dataset1(d1) if selected time period is "1964-1979" 
  output$Wordcloud <- renderPlot({
    if(input$selection=="1964-1979"){
      set.seed(1234)
      wordcloud(words = d1$word, freq = d1$freq,
                min.freq =input$freq,
                max.words=input$max,ordered.colors = TRUE, random.order=FALSE, rot.per=0.35,
                colors=brewer.pal(5, "Set2")[factor(d1$cut)])
    }else{set.seed(1234)
      #Create a wordcloud using dataset2(d2) if selected time period is "2000-2015"
      p<- wordcloud(words = d2$word, freq = d2$freq, min.freq = input$freq,
                    max.words=input$max,ordered.colors = TRUE, random.order=FALSE, rot.per=0.35, 
                    colors=brewer.pal(5, "Set2")[factor(d2$cut)])
      
      print(p)
    }
  })
  
  #Create a barplot
  output$Barplot <- renderPlot({
    #If "1964-1979" is selected, create a barplot using d1
    if(input$selection2=="1964-1979"){
      #Subset having the selected maximum number of words
      subdata1<-d1[1:input$max2,]%>%
        subset(freq>input$freq2)
      
      p1<- ggplot(aes_string(x = "reorder(word, -freq)", y = "freq"),data=subdata1) +
        geom_bar(stat = "identity",fill="steelblue") + 
        theme_bw()+
        labs(x="Words",
             y="Frequency",
             title="Top Words in Lyrics of Songs on Billboard Top 100 in 1964-1979",
             caption="Data Source:Kaggle \nPlot built by Lina")+
        ylim(0, 6300)+
        theme(panel.border = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(), 
              axis.line = element_line(colour = "black"),
              axis.text.x=element_text(angle=45, hjust=1),
              plot.title = element_text(hjust = 0.5,size=17))
      
      #show the barplot
      print(p1)
      
    }else{
      #If "2000-2015" is selected, create a barplot using d2
      
      #Subset having the selected maximum number of words
      subdata2<-d2[1:input$max2,]%>%
        subset(freq>input$freq2)
      
      p2 <- ggplot(aes_string(x = "reorder(word, -freq)", y = "freq"),data=subdata2) +
        geom_bar(stat = "identity",fill="steelblue") + 
        theme_bw()+
        labs(x="Words",
             y="Frequency",
             title="Top Words in Lyrics of Songs on Billboard Top 100 in 2000-2015",
             caption="Data Source:Kaggle \nPlot built by Lina")+
        ylim(0, 6300)+
        theme(panel.border = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(), 
              axis.line = element_line(colour = "black"),
              axis.text.x=element_text(angle=45, hjust=1),
              plot.title = element_text(hjust = 0.5))
      #show the barplot
      print(p2)
    }
  })
}
### specify the ui and server objects to be combined to make App
shinyApp(ui=ui, server=server)













