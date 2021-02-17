# Exploratory Data Analysis - Coursera/JHU
# Week 1 Assignment
# 
# Plot 1
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

# draw the plot
png("plot1.png")
par(bg = "transparent")
hist(df$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()

# Oustanding issue:
# All black elements - text, axis and values, bar outlines - have a raised
# or halo effect that can be observed when placed over a dark canvas
