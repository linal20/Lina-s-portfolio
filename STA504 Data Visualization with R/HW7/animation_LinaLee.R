setwd("C:/Users/linal/Desktop/2019 spring/visual/homwork/hw7")
load("french_fries.Rdata")
# Load any libraries 
library(tidyverse)
library(animation)

#make subdata with overall average potato flavor score over week

ff.time <- french_fries %>% 
  group_by(time) %>%
  summarise(potatoavg = mean(potato, na.rm=TRUE)) %>%
  mutate(time=as.numeric(time),potatoavg=as.numeric(potatoavg))

# Lineplot with one line for overall average potato flavor score over week

saveGIF({
  for( t in 2:10){
    p1<-ggplot() +
      geom_line(aes(x=time, y=potatoavg, group=1), size=2,
                color="brown",data=head(ff.time,t)) + 
      scale_x_continuous(breaks=seq(1,10,by=1),limits=c(0,10))+
      scale_y_continuous(limits=c(0,10))+
      labs(x="week",y="Potato \nFlavor Score",title="Overall Average Potato Flavor Score over Weeks")+
      theme_bw()
    print(p1)
  }
}, 
img.name="frenchfries_frame")
