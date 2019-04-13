## Exploratory Data Analysis Project 1: Plot 2

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

# Construct Plot 2: Global Active Power ~ Time
dev.off()
par(pty = "s", cex.axis = 0.75, cex.lab = 0.75)
plot(DF$Time, DF$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)",
     xlab = "")

# Save Plot 2 
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()