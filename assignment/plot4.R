# data preparation
filepath <- '/Users/zhangkuo/Desktop/learning/coursera/data science with R/4 exploratory data analysis/project1/'
filename = "household_power_consumption.txt"
file1 <- paste0(filepath, filename)

data <- read.table(file = file1, header = TRUE, sep = ';')
data <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')

colnames <- names(data[3:9])
data[, colnames] <- lapply(data[, colnames], function(x) as.numeric(as.character(x)))

datetime <- as.POSIXct(paste(data$Date, data$Time, sep = ";"), format = "%d/%m/%Y;%H:%M:%S")
data <- cbind("DateTime" = datetime, data)
data$Date <- NULL
data$Time <- NULL

#plot4

png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")

par(mfrow = c(2, 2))

## Add plot1
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Add plot2
plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Add plot3
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), bty = 'n', col = c("black", "red", "blue"))

## Add plot4
plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", lwd = 0.5)

dev.off()
