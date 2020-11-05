
# Plot 4

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

par(mfrow = c(2, 2), mar=c(2,4,2,1), oma=c(0,0,2,0)) # sets layout

plot(mydata$datetime, mydata$Global_active_power,
     xlab = " ", ylab = "Global Active Power", col = "white")
lines(x = mydata$datetime, y = mydata$Global_active_power)   

plot(mydata$datetime, mydata$Voltage,
     xlab = "datetime", ylab = "Voltage", col = "white")
lines(x = mydata$datetime, mydata$Voltage)

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
       col = c("black", "red", "blue"), bty = "n",
       lty = 1)

plot(mydata$datetime, mydata$Global_reactive_power,
     xlab = "datetime", ylab = "Global_reactive_power",
     col = "white")
lines(mydata$datetime, mydata$Global_reactive_power)

dev.copy(png, "plot4.png", height = 480, width = 480)
dev.off()