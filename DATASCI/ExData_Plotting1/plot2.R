require(data.table)
data <- fread("household_power_consumption.txt", na.strings="?")

#Get the data ready for plotting 
subdata <- subset(data, Date== "1/2/2007"|Date== "2/2/2007", 
                  select = c(Date,Time,Global_active_power))
Power <- as.numeric(subdata$Global_active_power)
DateTime <- paste(subdata$Date, subdata$Time, sep= " ")# combine date and time
dt <- strptime(DateTime, " %d/%m/%Y %H:%M:%S", tz="Europe/Berlin")  

##-----------------------------------------------------------------------------------
## Plot  

png("plot2.png", height = 480, width = 480) # set the the dimension of the png image

plot(dt,Power, xaxt= "n", type = "l", lwd = 1, ann= FALSE)
axis.POSIXct(side=1, at=c("2007-02-01", "2007-02-02", "2007-02-03"), format="%a")
title(ylab="Global Active Power (kilowatts)")

dev.off()