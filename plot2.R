
#loading packages
library(tidyverse)
library(lubridate)

#read data into R
df <- read_csv2("./data/household_power_consumption.txt") 

#modify date
df$dtg <- as.Date(df$Date, "%d/%m/%Y")

#filter dataframe
df <- df %>% filter(dtg  == "2007-02-01" | dtg == "2007-02-02")

#Add date-time column in correct format
a <- paste(df$Date, df$Time)
df$mix <- parse_date_time(a, "%d/%m/%Y %H:%M:%S")

#modify column for numeric
df$Global_active_power <- as.numeric(df$Global_active_power)

#create plot 2
with(df, plot(Global_active_power ~ mix, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(df, lines(Global_active_power ~ mix))

#Save plot 1 to file
dev.copy(png, file = "Plot2.png")
dev.off()

