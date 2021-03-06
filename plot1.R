# this function draws a histogram of Global Active Power from the first two days in February 2007, in the Household Electricity Consumption dataset from the UC
# Irvine Machine Learning Repository
plot1 <- function() {
  #first load the dataset
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?", header = TRUE)
  
  #subset the data to include only the first two days of February 2007
  feb_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
  
  #reformat columns to proper values
  feb_data$Date <- as.Date(feb_data$Date, format = "%d/%m/%y")
  feb_data$Global_active_power <- as.numeric(as.character(feb_data$Global_active_power))
  feb_data$Global_reactive_power <- as.numeric(as.character(feb_data$Global_reactive_power))
  feb_data$Voltage <- as.numeric(as.character(feb_data$Voltage))
  feb_data$day_time <- strptime(paste(feb_data$Date, feb_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  feb_data$Sub_metering_1 <- as.numeric(as.character(feb_data$Sub_metering_1))
  feb_data$Sub_metering_2 <- as.numeric(as.character(feb_data$Sub_metering_2))
  feb_data$Sub_metering_3 <- as.numeric(as.character(feb_data$Sub_metering_3))
  
  #create the histogram with red bars, a title of "Global Active Power", and a x-axis label of "Global Active Power (kilowatts)"
  hist(feb_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
  
  #copy the histogram in the viewer to a PNG file
  dev.copy(png,'plot1.png', width = 480, height = 480)
  dev.off()
}