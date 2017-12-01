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
  
  ## Create Plot 1 and save it as plot1.png
  png(filename = "plot1.png", width = 480, height = 480)
  hist(hpc$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
  dev.off()
  
  