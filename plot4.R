########Start plot4.R######
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

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(workingData, {
    plot(Global_active_power~DateTime, type="l", ylab="Global Active Power", xlab="")
    plot(Voltage~DateTime, type="l", ylab="Voltage", xlab="DateTime")
    plot(Sub_metering_1~DateTime, type="l", ylab="Global Active Power", xlab="")
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~DateTime, type="l", ylab="Global Reactive Power",xlab="DateTime")
})

##file will not write until dev.off() is executed
dev.off()

####End plot4.R#####

