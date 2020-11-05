# Plot 2

# Setup

library(dplyr); library(lubridate)
pwr <- read.table("household_power_consumption.txt", 
                  header = T, na.strings = "?", sep = ";")
pwr$Date <- as.character(pwr$Date) # convert date to character
mydata <- filter(pwr, Date %in% c("1/2/2007","2/2/2007")) # filter out dates I need

# Setup for 'datetime'

mydata$Date <- dmy(mydata$Date) # converts to date class
mydata$datetime <- paste(mydata$Date, mydata$Time, sep = " ") # joins Date and Time
mydata$datetime <- as.POSIXct(mydata$datetime) # converts datetime to POSIXct

# Plotting

plot(x = mydata$datetime, y = mydata$Global_active_power,     # creates plot 
     xlab = " ", ylab = "Global Active Power (kilowatts)",
     col = "white")
lines(x = mydata$datetime, y = mydata$Global_active_power)   # adds line

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
