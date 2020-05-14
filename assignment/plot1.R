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

#plot1
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

