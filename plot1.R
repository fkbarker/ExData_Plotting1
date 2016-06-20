# Data reading Section

# date read function
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
# read the table data
bighousepower<-read.table("household_power_consumption.txt", sep =";", header = TRUE,colClasses = c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.strings="?")
#subset the data for the dates that we are interested in
housepower<-subset(bighousepower,Date=="2007-02-02"|Date=="2007-02-01")
# add a combined datetime column to the data frame
datetime<-as.POSIXlt(paste(housepower$Date,housepower$Time))
housepower<-data.frame(datetime,housepower)

# Plotting Section

# plot 1: Histogram of Global active power for 1/2/2007 and 2/2/2007 in red with Title of "Global Active Power" and labels of Frequency and Global Active POwer (kilowatts)
# in a png file named plot1.png sized 480x480 (the default)

# setup the png device
png(filename ="plot1.png", width=480, height = 480)

# Histogram generation
hist(housepower$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close the png file
dev.off()