######Begin plot1.R#########
##load libraries
library(dplyr)
library(data.table)

#Reads in data from file then subsets data for specified dates
hpc <- read.table("household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE, header = TRUE, sep = ";")
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
hpc$Time <- format(hpc$Time, format="%H:%M:%S")
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
hpc$Global_reactive_power <- as.numeric(hpc$Global_reactive_power)
hpc$Voltage <- as.numeric(hpc$Voltage)
hpc$Global_intensity <- as.numeric(hpc$Global_intensity)

##create subset for specified dates
workingData <- subset(hpc, Date == "2007-02-01" | Date =="2007-02-02")

png("plot1.png", width=480, height=480)
hist(workingData$Global_active_power, col="red", border = "black", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
##file will not write until dev.off() is executed
dev.off()
#####End plot1.R#########

