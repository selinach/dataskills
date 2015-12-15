# Read in data
data <- read.table("NYPD_Motor_Vehicle_Collisions.csv", header = TRUE, sep=",",fill=TRUE,quote="\"")

# Look at table
View(data)

# Convert DATE field to date-formatted
date2 <- as.Date(data$DATE,"%m/%d/%Y")

#join new date field to table
data2 <-cbind(data,date2)

#sample rows to spot check
data2[sample(nrow(data2),10),c(1,30)]

#use dplyr
library(dplyr)

#convert TIME to date-format
time2 <- strptime(data2$TIME,format="%H:%M")

#use lubridate
library(lubridate)

#calculate hour of each accident
Accidents_by_Hour <- hour(time2)

#use plotly
library(plotly)

#use plotly to make a histogram
plot_ly(x=Accidents_by_Hour, type="histogram")

## Now we're making a line chart

#Select only rows where prescription drugs are a factor
prescriptions <- filter(data2,CONTRIBUTING.FACTOR.VEHICLE.1=="Prescription Medication"|CONTRIBUTING.FACTOR.VEHICLE.2=="Prescription Medication")

#creates a table with 15,787 rows

#create a new field in prescriptions called year
prescriptions <- mutate(prescriptions,year=year(date2))

#get prescription-related accidents by year
table(prescriptions$year)

#Create a data frame of accidents per year
rx_per_year <- data.frame(table(prescriptions$year))

#fix column names
colnames(rx_per_year) <-c("Year","Accidents")

#ditch 2012
rx_per_year <- rx_per_year[2:4,]

#use plotly to make time series chart
plot_ly(rx_per_year, x=Year, y= Accidents, name = "Accidents") %>% layout(xaxis=a)

a <- list (
  autotick=FALSE, 
  ticks="Outside", 
  dtick=1, 
  ticklen=1, 
  tickwidth=1, 
  tickcolor= toRGB("blue"))
