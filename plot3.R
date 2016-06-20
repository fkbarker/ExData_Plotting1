# Data Reading section

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

# Plot 3: Line plot of Sub_metering_1 (in black), Sub_metering_2 (in red), Sub_metering_3 (in Blue) for the 1/2/2007 and 2/2/2007 no Main title or xlab. Ylab "Energy Sub Metering" and a legend in the top right 
# in a png file named plot3.png sized 480x480 (the default)


# setup the png device
png(filename ="plot3.png", width=480, height = 480)

# graph generation
with(housepower, 
     {plot(datetime,Sub_metering_1,type = "l", ylab = "Energy sub metering", xlab="")
     points(datetime,Sub_metering_2,type = "l",col ="red")
     points(datetime,Sub_metering_3,type = "l",col ="blue")
     })
legend("topright", lty=1, col =c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

# Close the png file
dev.off()