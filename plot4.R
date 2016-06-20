# Data Reading Section

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

# Plot 4: 4 Line plots for the 1/2/2007 and 2/2/2007 no Main title
# 4A: in black of Global Active Power. No xlab. Ylab "Global Active Power (kilowatts)"
# 4B: in black of Voltage. Xlab datetime. Ylab Voltage
# 4C: of Sub_metering_1 (in black), Sub_metering_2 (in red), Sub_metering_3 (in Blue) no xlab. Ylab "Energy Sub Metering" and a legend in the top right  
# 4D: in black of Global reactive Power. xlab datetime. ylab Global_reactive_power
# 
# in a png file named plot4.png sized 480x480 (the default)


# setup the png device
png(filename ="plot4.png", width=480, height = 480)

# Setup page
par(mfrow=c(2,2))
# graph generation
with(housepower, 
     {
         #4A 
         plot(datetime,Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab="")
         #4B
         plot(datetime,Voltage,type = "l")
        #4C
         plot(datetime,Sub_metering_1,type = "l", ylab = "Energy sub metering", xlab="")
         points(datetime,Sub_metering_2,type = "l",col ="red")
         points(datetime,Sub_metering_3,type = "l",col ="blue")
         legend("topright", lty=1, col =c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
         #4D
         plot(datetime,Global_reactive_power,type = "l")
     })

# Close the png file
dev.off()