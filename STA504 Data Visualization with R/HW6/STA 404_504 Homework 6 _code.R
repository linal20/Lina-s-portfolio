# =====================================================================================
library(tidyverse)
library(readxl)
library(ggthemes)

setwd("C:/Users/linal/Desktop/2019 spring/visual/homwork/hw6")
# data posted to Canvas, orignally downloaded from the link below
# https://www.ers.usda.gov/data-products/food-environment-atlas/data-access-and-documentation-downloads/


## local foods data from "LOCAL" tab in excel sheets
local_food <- read_excel("DataDownload.xls", sheet="LOCAL") %>% 
  select(FIPS, State, County, FRESHVEG_FARMS12, ORCHARD_ACRES12, 
         GHVEG_FARMS12, GHVEG_SQFTPTH12, FMRKT16, FMRKTPTH16, DIRSALES_FARMS12)
head(local_food)

# Note: postal abbreviations on state names

## FIPS codes for State and county (unabbreviated) from "Supplemental Data - County" tab
county_fips <- read_excel("DataDownload.xls", sheet="Supplemental Data - County") %>% 
  select(FIPS, State, County)


## County boundary data
county_outlines <- map_data("county") 



### Start your code below -------------
#change charaters of State and County to lowercase

county_fips<-county_fips%>%
  mutate(State=str_to_lower(State),
         County=str_to_lower(County))

#merge the full names of the states onto the food data 

farm_all <- left_join(x=county_fips,
                      y=local_food,
                      by=c("FIPS"="FIPS"))

#merge onto the county outlinesis 

farm_merged <- left_join(x=farm_all,
                         y=county_outlines,
                         by=c("State.x"="region","County.x"="subregion"))

# the fill mapping on the map using a log10() transformation on the counts.

ggplot()+
  geom_polygon(aes(x=long,y=lat,group=group,fill= DIRSALES_FARMS12),data=farm_merged)+
  labs(title="Farm with Direct Sales,2012",
       caption="Data Source:USDA Food Environment Atlas, 2018 \nPlot Built by Lina ")+
  theme_map()+
  coord_map()+
  scale_fill_gradient(trans = "log10","Number \nof Farms",
                      low="light blue",high="dark blue",
                      limits=c(1,1000), 
                      breaks = c(1, 10, 100, 1000))+
  theme(plot.title = element_text(hjust = 0.5,size=22),
        legend.position = c(.9,.2),
        legend.title = element_text(size=16),
        legend.key.size =  unit(0.4, "in"),
        legend.text = element_text(size=12),
        plot.caption = element_text(hjust = 1,size=10))


