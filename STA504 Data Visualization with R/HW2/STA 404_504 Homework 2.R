#HW2
#course:data visualization
#date:02/17/2019
#author:Lina Lee

#load package#

library(data.table)
library(tidyverse) 
library(lubridate)

#read data "midwest_gas_prices.csv" into r#

gas <- read.csv("C:/Users/linal/Desktop/2019 spring/visual/homwork/hw2/midwest_gas_prices.csv",header=FALSE, skip=2)
names(gas) <- c("yrmon", "week1","value1","week2","value2","week3","value3","week4","value4","week5","value5")


#create seperate data frames with the columns of dates and coluns of prices#

gas_sep1<-gas %>% 
  select(yrmon,week1,week2,week3,week4,week5)

gas_sep2<-gas %>% 
  select(yrmon,value1,value2,value3,value4,value5)


#move from wide formate to tall formate using funtioncs in tidyr package#

gas_tall1<-gas_sep1 %>%
  gather(key="week",value="date",week1:week5)

gas_tall2<-gas_sep2 %>%
  gather(key="week",value="price",value1:value5)%>%
    mutate(week1=str_sub(week,6,6))%>% 
    mutate(week2=paste("week",week1,sep=""))%>%
    select(-week,-week1)%>%
  setnames("week2","week")


#recombine two separated data into one file#

gas_tall_comb<-merge(gas_tall1,gas_tall2,by=c("yrmon","week"))
 

#extract month and day from value of the "date" column

gas_tall_comb$date2<-format(as.Date(gas_tall_comb$date,format="%m/%d/%Y"),"%m/%d")


#extract year from "yrmon" column and make complete date column "date3"
#by pasting month and day from "date2" with year from "yrmon"
#remove N/A rows
#transform the date3 to a POSIX date-formatted variable ("date").
#select date and price only

gas_date<-gas_tall_comb %>%
mutate(date3=paste(date2,str_sub(yrmon,1,4),sep="/")) %>%
drop_na()%>%
mutate(date=mdy(date3))%>%
select(date,price) 


#make a Timeplot of the Average Weekly Midwestern Gas Prices 1995-2012 

ggplot()+geom_line(data=gas_date,aes(x=date,y=price),size=2,color="blue") +labs(x="Time",y="Price for Unleaded Gasoline(dollars/gallon)" 
     ,title="Timeplot of the Average Weekly Midwestern Gas Prices 1995-2012")

