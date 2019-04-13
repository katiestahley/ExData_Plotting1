## Exploratory Data Analysis Project 1: Plot 4

# Set universal working directory and load libraries
dir <- paste(Sys.getenv("USERPROFILE"), "\\Desktop\\KatieData\\4. Exploratory Analysis", sep = "")
setwd(dir)

# Download data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfolder <- download.file(fileURL, destfile = "dataset.zip")
unzip("dataset.zip", exdir = "dataset")

# Read the data into a dataframe 
data <- read.table("dataset\\household_power_consumption.txt", sep = ";", 
                   header = TRUE, stringsAsFactors = FALSE)

# Convert Date to date/time class
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Subset dataset to Feb 1 and 2, 2007 to reduce dataframe size
DF <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

# Conver Time to date/time class
DF$Time <- paste(DF$Date, DF$Time)
DF$Time <- strptime(DF$Time, format = "%Y-%m-%d %H:%M:%S")

# Convert cols 3:9 to numeric
num <- 3:9
DF[num] <- lapply(DF[num], as.numeric)

# Construct Plot 4: Global Active Power ~ Time
dev.off()
par(mfrow = c(2,2), pm = c(5,4), cex.axis = 0.75, cex.lab = 0.75, mar = c(4,4,2,3),
    oma = c(3,2,2,2))

# Graph 1
plot(DF$Time, DF$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)",
     xlab = "")
# Graph 2 
plot(DF$Time, DF$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")
# Graph 3 
plot(DF$Time, DF$Sub_metering_1, type = "l", ylab = "Energy sub metering",
     xlab = "", lwd = 1)
lines(DF$Time, DF$Sub_metering_2, col = "red")
lines(DF$Time, DF$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex = 0.5, bty = "n")
# Graph 4 
plot(DF$Time, DF$Global_reactive_power, ylab = "Global_reactive_power", 
     xlab = "datetime", type = "l")

# Save Plot 4 
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()