plot3 <- function() {
  #first load the dataset
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?", header = TRUE)
  
  #subset the data to include only the first two days of February 2007
  feb_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
  
  #create variable that merges day and time for these two days
  day_time <- strptime(paste(feb_data$Date, feb_data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
  
  #reformat other data values
  Submetering_1 <- as.numeric(feb_data$Sub_metering_1)
  Submetering_2 <- as.numeric(feb_data$Sub_metering_2)
  Submetering_3 <- as.numeric(feb_data$Sub_metering_3)
  
  #create the plot with all three sub-metering variables together (on y-axis)
  plot(day_time, Submetering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(day_time, Submetering_2, type = "l", col = "red")
  lines(day_time, Submetering_3, type = "l", col = "blue")
  legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5)
  
  #copy the graph in the viewer to a PNG file
  dev.copy(png, "plot3.png", width = 480, height = 480)
  dev.off()
}