require(data.table)
data <- fread("household_power_consumption.txt", na.strings="?")

# get the data ready
subdata <- subset(data, Date== "1/2/2007"|Date== "2/2/2007", 
                  select = c(Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3))
#the columns have "character" as their class, so set that to numeric.
sub1 <- as.numeric(subdata$Sub_metering_1)
sub2 <- as.numeric(subdata$Sub_metering_2)
sub3 <- as.numeric(subdata$Sub_metering_3)
DateTime <- paste(subdata$Date, subdata$Time, sep= " ")# combine date and time
## Here, it works the best if I consider "factors" of DateTime and change class to numeric.
dt1 <- as.numeric(factor(DateTime))

png("plot3.png", height = 480, width = 480) # set the the dimension of the png image

# plot one sub1 against dt and later add sub2 and sub3
plot(dt1,sub1, xaxt= "n", type = "l",lwd = 1, ann= FALSE)
lines(sub2,xaxt= "n", type = "l",lwd = 1, ann= FALSE, col="red")
lines(sub3,xaxt= "n", type = "l",lwd = 1, ann= FALSE, col="blue")
axis(1,at=c(0,1441,2881), labels = c("Thu", "Fri", "Sat"))
title(ylab="Energy sub metering")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),
          col=c("black","red","blue"), lwd = c(1,1,1))
dev.off()