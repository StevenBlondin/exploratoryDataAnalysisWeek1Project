####Start plot2.R#####
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

##Add new column combining date and time
dateTime <- paste(workingData$Date, workingData$Time)
##convert new column
workingData$DateTime <- as.POSIXct(dateTime)

png("plot2.png", width=480, height=480)

plot(workingData$Global_active_power~workingData$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

##file will not write until dev.off() is executed
dev.off()
#####End plot2.R#######

