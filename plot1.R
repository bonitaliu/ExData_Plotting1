# Plot 1

# Setup

library(dplyr)
pwr <- read.table("household_power_consumption.txt", 
                  header = T, na.strings = "?", sep = ";")
pwr$Date <- as.character(pwr$Date) # convert date to character
mydata <- filter(pwr, Date %in% c("1/2/2007","2/2/2007")) # filter out dates I need

#Plotting

hist(mydata$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")

dev.copy(png, file = "plot1.png", height = 480, width = 480) 

dev.off()