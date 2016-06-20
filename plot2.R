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

# Plot 2: Line plot in black of Global Active Power for the 1/2/2007 and 2/2/2007 no Main title or xlab. Ylab "Global Active Power (kilowatts)" 
# in a png file named plot2.png sized 480x480 (the default)


# setup the png device
png(filename ="plot2.png", width=480, height = 480)

# Line Plot generation
plot(housepower$datetime,housepower$Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab="")

# Close the png file
dev.off()