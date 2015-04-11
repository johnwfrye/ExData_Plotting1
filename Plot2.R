##Reading the data into R
library(data.table)

##Read in zip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption"
download.file(url, file, method = "curl")
unzip(file, exdir = "/Data/Coursera/Exploratory Data Analysis")

##Creates the "household_power_consumption.txt" file!
data <- fread("household_power_consumption.txt")

##Clean the data
## Data and time variables are characters
## Change the format of Date variable
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

##Subset the data for the two dates of interest
data_subset <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

##Convert data subset to a data frame
data_subset <- data.frame(data_subset)

##Convert columns to numeric
for(i in c(3:9)) {data_subset[,i] <- as.numeric(as.character(data_subset[,i]))}

##Create Date_Time variable
data_subset$Date_Time <- paste(data_subset$Date, data_subset$Time)

##Convert Date_Time variable to proper format
data_subset$Date_Time <- strptime(data_subset$Date_Time, format="%Y-%m-%d %H:%M:%S")

##Plot2
plot(data_subset$Date_Time, data_subset$Global_active_power,
     ylab="Global Active Power (kilowatts)", type="n")
lines(data_subset$Date_Time, data_subset$Global_active_power)
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
