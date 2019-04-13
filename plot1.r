## Exploratory Data Analysis Project 1: Plot 1 

# Files used:
# Files created: 

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
data2 <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

# Convert cols 3:9 to numeric
num <- 3:9
data2[num] <- lapply(data2[num], as.numeric)

# Construct Plot 1: Frequency ~ Global Active Power 
dev.off()
par(pty = "s", cex.axis = 0.75, cex.lab = 0.75)
hist(data2$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red", ylim = c(0,1200))

# Save Plot 1 
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()