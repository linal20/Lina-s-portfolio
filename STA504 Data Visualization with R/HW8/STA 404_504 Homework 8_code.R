#Title: HW8 (Proportionally Stacked barchart of Join Pain Levels by BMI)
#Date:May/05/2019
#author:LINA LEE

# ========================================================================================== #
# load libraries 
library(tidyverse)
library(foreign) # package for reading "foreign" data formats (XPT/STATA/SPSS/dta/etc)

library(plotly)
library(viridis)
# =========================================================================================== # 


setwd("C:/Users/linal/Desktop/2019 spring/visual/homwork/hw8")

# reading in the data 
full_data <- foreign::read.xport("LLCP2017.XPT")
head(full_data)

# Subset the dataset with the following variables: 
mydata <- full_data %>%
  select(JOINPAI1,X_BMI5CAT)

remove(full_data) # remove the huge data object from the global environment to avoid using up too much RAM resources

save(mydata,file="mydata.RData")
load("mydata.RData")

#Preparing data for plot 
#Grouping by the selected variables and calculating Percentage for each group
newdata<-mydata%>%
  filter(JOINPAI1!=77 & JOINPAI1!=99)%>%
  mutate(JOINPAI1=factor(JOINPAI1,
                         levels=c(10,9,8,7,6,5,4,3,2,1,0)),
         X_BMI5CAT=factor(X_BMI5CAT,
                          levels=c(1,2,3,4),
                          labels=c("Underweight","Normal","Overweight","Obese")))%>%
  group_by(X_BMI5CAT,JOINPAI1)%>%
  na.omit() %>%
  summarize(count=n())%>%  
  mutate(perc = count/sum(count)*100)

#Proportionally Stacked barchart of Join Pain Levels by BMI using plotly
newdata %>% 
  plot_ly(newdax= ~X_BMI5CAT,y =~perc,color=~JOINPAI1,
          colors = rev(viridis_pal(option = "D")(3)),
          hoverinfo='text',
          text = ~paste(round(perc,1)," % of ",
                        X_BMI5CAT," BMI <br /> at Pain Levels ",
                        JOINPAI1,sep=""),
          type = "bar")%>%
  layout(title="Joint Pain Levels by BMI",
         xaxis = list(title = "BMI Group",tickvals=c(0,1,2,3),
                      ticktext = c("Underweight","Normal","Overweight","Obese")),
         yaxis = list(title = "Percentage"), barmode = "stack")




