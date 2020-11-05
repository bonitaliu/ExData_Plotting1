# Plot 3

# Setup

library(dplyr); library(lubridate); library(reshape2)
pwr <- read.table("household_power_consumption.txt", 
                  header = T, na.strings = "?", sep = ";")
pwr$Date <- as.character(pwr$Date) # convert date to character
mydata <- filter(pwr, Date %in% c("1/2/2007","2/2/2007")) # filter out dates I need

# Setup for 'datetime'

mydata$Date <- dmy(mydata$Date) # converts to date class
mydata$datetime <- paste(mydata$Date, mydata$Time, sep = " ") # joins Date and Time
mydata$datetime <- as.POSIXct(mydata$datetime) # converts datetime to POSIXct

# Melting the dataframe

melted <- melt(mydata, 
               id.vars = "datetime",
               measure.vars = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               variable.name = "SubMeter_Num",
               value.name = "SubMeter_Value")

# Plotting

plot(x = melted$datetime, y = melted$SubMeter_Value, 
     type = "n", # initializes empty plot
     xlab = " ", ylab = "Energy sub metering")  
with(subset(melted, SubMeter_Num == "Sub_metering_1"), 
     lines(datetime, SubMeter_Value, col = "black"))
with(subset(melted, SubMeter_Num == "Sub_metering_2"), 
     lines(datetime, SubMeter_Value, col = "red"))
with(subset(melted, SubMeter_Num == "Sub_metering_3"), 
     lines(datetime, SubMeter_Value, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()

