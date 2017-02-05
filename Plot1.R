allthedata <- read.table('./data/household_power_consumption.txt', sep=";", header=TRUE, na.strings="?") #In this data ?=NA
names(allthedata) #Date and Time in data
str(allthedata) #Date is called in as a factor

#Change the Date AND TIME to a date/time format from factor format
install.packages("PCICt") #REMEMBER TO INSTALL THIS PACKAGE WHEN WORKING WITH DATE AND TIME FORMATS
library(PCICt)
allthedata$datetime <- strptime(paste(allthedata$Date, allthedata$Time), "%d/%m/%Y %H:%M:%S") 
#^^CREATE A NEW DATETIME VARIABLE COLUMN BY COMBINING DATE AND TIME

#Call in only the subset of data from february we are analyzing
FebData <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))              #DEFINE THE DATES WE WANT TO USE
FebData <- allthedata[as.Date(allthedata$datetime) %in% FebData,]       #MAKE THE DATASET ACTUALLY INCLUDE THOSE DATES AND TIMES
names(FebData)
head(FebData)

#The overall goal here is simply to examine how household energe usage varies over a 2 day period in 
#February, 2007. your task is to reconstruct the following plots (4), all of which were constructed 
#using the base plotting system.
install.packages("datasets")
library(datasets)
png(file="plot1.png", width=480, height=480)
hist(FebData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
