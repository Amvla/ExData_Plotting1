## Check for dplyr and downloader packages
if(!require(downloader)) {
  install.packages("downloader") 
  require(downloader)
}

if(!require(dplyr)) {
  install.packages("dplyr")
  require(dplyr)
}

## Check if destination folder exists. If not, create destination folder dataweek4
if(!file.exists("./plottingweek1")) {dir.create("./plottingweek1")}

## Download zipped data files into dataweek4 folder
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileUrl, dest="./plottingweek1/household_power_consumption.zip")

## Unzip data files
unzip("./plottingweek1/household_power_consumption.zip", exdir = "./plottingweek1")

## Load data file
hpc <- read.table("./plottingweek1/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

## Convert to dates and times
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

## Create subset to include only dates 2007-02-01 and 2007-02-02
hpc <- filter(hpc, (Date == "2007-02-01")|(Date == "2007-02-02"))
datetime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$datetime <- as.POSIXct(datetime)

## Create Plot 4 and save it as plot4.png
png(filename = "plot4.png", width = 480, height = 480)

## Set parameters for multiple base plots
par(mfrow=c(2,2))

## Draw top left plot
plot(hpc$Global_active_power~hpc$datetime, type ="l", ann=FALSE)
title(ylab = "Global active power (kilowatts)")

## Draw top right plot
plot(hpc$Voltage~hpc$datetime, type = "l", ann=FALSE)
title(xlab="datetime", ylab = "Voltage")

## Draw bottom left plot
with(hpc, plot(Sub_metering_1~datetime, type = "l", ann = FALSE))
with(hpc, lines(Sub_metering_2~datetime, col="red"))
with(hpc, lines(Sub_metering_3~datetime, col="blue"))
title(ylab = "Energy sub metering")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")

## Draw bottom right plot
plot(hpc$Global_reactive_power~hpc$datetime, type = "l", ann=FALSE)
title(xlab="datetime", ylab = "Global_reactive_power")

dev.off()
