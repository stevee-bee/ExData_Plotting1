# Exploratory Data Analysis - Coursera/JHU
# Week 1 Assignment
# 
# Plot 3
# 


uciDataFile <- "household_power_consumption.txt"

# check for UCI's data file in the working directory
if (!file.exists(uciDataFile)) {
        uciZipFile <- "exdata_data_household_power_consumption.zip"
        
        # check for UCI's zip file in the working directory
        if (!file.exists(uciZipFile)) {
                uciDatasetURL <- "https://d396qusza40orc.cloudfront.net/exdata_data_household_power_consumption.zip"
                
                # download file
                download.file(uciDatasetURL, uciZipFile, mode = "wb")
        }
        
        # unzip data file
        unzip(uciZipFile)
}

# read enough to include 2007-02-01 and 2007-02-02
library(readr)
df <- read_delim(uciDataFile, 
                 ";", 
                 n_max = 70000, 
                 na = c("?"), 
                 col_types = cols(Date = col_character(), 
                                  Time = col_character(), 
                                  .default = col_double()))

# drop everything else but the two days of interest
df <- df[df$Date %in% c("1/2/2007", "2/2/2007"), ]

# create a new POSIXlt variable that combines Date and Time
df$datetime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# draw the plot
png("plot3.png")
par(bg = "transparent")
with(df, {
        plot(datetime, 
             Sub_metering_1, 
             type = "l", 
             col = "black", 
             xlab = "", 
             ylab = "Energy sub metering")
        points(datetime, 
               Sub_metering_2, 
               type = "l", 
               col = "red") # same as lines(datetime, Sub_metering_2, col = "red")
        points(datetime, 
               Sub_metering_3, 
               type = "l", 
               col = "blue")
        legend("topright", 
               colnames(df[,7:9]), 
               col = c("black", "red", "blue"), 
               lty = 1, 
               lwd = 1)
})
dev.off()
