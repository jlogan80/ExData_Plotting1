# this function draws a histogram of Global Active Power from the first two days in February 2007, in the Household Electricity Consumption dataset from the UC
# Irvine Machine Learning Repository
plot2 <- function() {
  #first load the dataset
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?", header = TRUE)
  
  #subset the data to include only the first two days of February 2007
  feb_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
  
  #reformat columns to proper values
  feb_data$Global_active_power <- as.numeric(as.character(feb_data$Global_active_power))
  day_time <- strptime(paste(feb_data$Date, feb_data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
  
  #create plot by day and time
  plot(day_time, feb_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  #copy the file from the viewer to a PNG file
  dev.copy(png,'plot2.png', width = 480, height = 480)
  dev.off()
}