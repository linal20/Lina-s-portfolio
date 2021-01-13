setwd("C:/Users/linal/Desktop/2019 spring/visual/homwork/hw7")

# load file
load("ffSubj.Rdata")

# Load any libraries we plan to use in our app
library(shiny)
library(dplyr)
library(ggplot2)




# Define UI for dataset viewer application
ui <- fluidPage(
  
  # Application title
  titlePanel("French Fry Flavor Profiles"),
  
  sidebarPanel(
    selectInput(inputId="yvar", label="Choose a Y Variable",
                choices =myvars<-c("Buttery","Grassy","Rancid","Painty")
    ),
    
    
    # Checkbox for Smoother
    checkboxInput(inputId = "smooth", 
                  label="Add Trendline"),
    tags$img(src="images.png",height=100,width=100)
  ),
  
  mainPanel(
    plotOutput("mainplot")
  )
)


server <- function(input, output) {
  
  # Build our scatterplot based on inputs here
  output$mainplot <- renderPlot({ 
    # Build plot using input list for flavor
    p1 <- ggplot() +
      geom_line(aes_string(x="time", y=input$yvar, group="subject"), data=ffSubj) + 
      facet_grid(.~treatment) + 
      labs(x="Week",y="Potato Flavor Score")  +
      theme_bw()
    # Check if user wants smoother on plot
    if(input$smooth==TRUE){
      # Add smoother line to p1
      p1 <- p1 + stat_smooth(aes_string(x="time", y=input$yvar,
                                        group="treatment"),
                             data=ffSubj,
                             size=2, se=FALSE)
    }
    # show plot
    print(p1)
    
  })
  
  
}

### specify the ui and server objects to be combined to make App
shinyApp(ui=ui, server=server)

