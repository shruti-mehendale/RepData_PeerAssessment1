require(data.table)
data <- fread("household_power_consumption.txt", na.strings="?")
#subset the data
subdata <- subset(data, Date== "1/2/2007"|Date== "2/2/2007")
#the columns have "character" as their class, so set that to numeric.
Power <- as.numeric(subdata$Global_active_power)
PowerR <- as.numeric(subdata$Global_reactive_power)
sub1 <- as.numeric(subdata$Sub_metering_1)
sub2 <- as.numeric(subdata$Sub_metering_2)
sub3 <- as.numeric(subdata$Sub_metering_3)
Voltage <- as.numeric(subdata$Voltage)
DateTime <- paste(subdata$Date, subdata$Time, sep= " ")# combine date and time
dt <- strptime(DateTime, " %d/%m/%Y %H:%M:%S", tz="Europe/Berlin")

## For bottomleft plot, it works the best if I consider "factors" of DateTime.  
dt1 <- as.numeric(factor(DateTime)) 



## start plotting 

png("plot4.png", height = 504, width = 504) # set the the dimension of the png image

par(mfcol=c(2,2)) # set the layout

# topleft plot
plot(dt,Power, xaxt= "n", type = "l", lwd = 1, ann= FALSE)
axis.POSIXct(side=1, at=c("2007-02-01", "2007-02-02", "2007-02-03"), format="%a")
title(ylab="Global Active Power (kilowatts)")


# bottomleft plot

plot(dt1,sub1, xaxt= "n", type = "l",lwd = 1, ann= FALSE)
lines(sub2,xaxt= "n", type = "l",lwd = 1, ann= FALSE, col="red")
lines(sub3,xaxt= "n", type = "l",lwd = 1, ann= FALSE, col="blue")
axis(1,at=c(1,1441,2881), labels = c("Thu", "Fri", "Sat")) 
title(ylab="Energy sub metering")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),
       col=c("black","red","blue"), lwd = c(1,1,1), bty= "n")



# topright plot
plot(dt,Voltage, xaxt= "n", type = "l",lwd = 1, ann= FALSE)
axis.POSIXct(side=1, at=c("2007-02-01", "2007-02-02", "2007-02-03"), format="%a")
title(ylab="Voltage", xlab = "datetime")


# bottomright plot

plot(dt,PowerR, xaxt= "n", type = "l",lwd = 1, ann= FALSE)
axis.POSIXct(side=1, at=c("2007-02-01", "2007-02-02", "2007-02-03"), format="%a")
title(ylab="Global_reactive_power", xlab = "datetime")


dev.off()