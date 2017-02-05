allthedata <- read.table('./data/household_power_consumption.txt', sep=";", header=TRUE, na.strings="?") #In this data ?=NA
names(allthedata) #Date and Time in data
str(allthedata) #Date is called in as a factor

#Change the Date AND TIME to a date/time format from factor format
install.packages("PCICt") #REMEMBER TO INSTALL THIS PACKAGE WHEN WORKING WITH DATE AND TIME FORMATS
library(PCICt)
allthedata$datetime <- strptime(paste(allthedata$Date, allthedata$Time), "%d/%m/%Y %H:%M:%S") 
#^^CREATE A NEW DATETIME VARIABLE COLUMN BY COMBINING DATE AND TIME 

#Call in only the subset of data from february we are analyzing
FebData <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))              #DEFINE THE DATES WE WANT TO USE in DATE TIME FORMAT
FebData <- allthedata[as.Date(allthedata$datetime) %in% FebData,]       #MAKE THE DATASET ACTUALLY INCLUDE THOSE DATES AND TIMES
names(FebData)
head(FebData)

#The overall goal here is simply to examine how household energe usage varies over a 2 day period in 
#February, 2007. your task is to reconstruct the following plots (4), all of which were constructed 
#using the base plotting system.
install.packages("datasets")
library(datasets)
png(file="plot4.png", width=480, height=480)
with(FebData) {
  par(mfrow=c(2,2))
  with(FebData, {
    plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power") #Top left plot (Same as plot 1)
    plot(datetime, Voltage, type="l", xlab="Date and Time", ylab="Voltage") #Top right plot
    plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy Sub Meters") #Bottom left plot (same as plot 3)
    colors <- c("black", "red", "blue")  #Define Colors used for each of the three items 
    submeters <- paste0("Sub_metering_", 1:3, sep="") #Define the 3 variables to be plotted (Sub_metering_#s1,2,3))
    for (i in seq_along(submeters)) {      #Loop using seq_along from 1 to 3 to draw n=3 lines for each variable in the correct color
      sub_meters <- submeters [i]
      plotthis <- FebData[[sub_meters]]
      lines(datetime, plotthis, col=colors[i])
    }
    legend("topright", legend=submeters, col=colors, lty="solid") #Use Bty to disable legend neatline
    plot(datetime, Global_reactive_power, type="l", xlab="Date and Time", ylab="Global Reactive Power")   #Bottom right plot
})
}
dev.off()
