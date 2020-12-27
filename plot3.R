
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

df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

#create plot 3
with(df, plot(Sub_metering_1 ~ mix, type = "n", xlab = "", ylab = "Energy sub metering"))
with(df, lines(Sub_metering_1 ~ mix))
with(df, lines(Sub_metering_2 ~ mix, col = "red"))
with(df, lines(Sub_metering_3 ~ mix, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))

#Save plot 3 to file
dev.copy(png, file = "Plot3.png")
dev.off()

