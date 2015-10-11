require(data.table)
data <- fread("household_power_consumption.txt", na.strings="?")
subdata <- subset(data, Date== "1/2/2007"|Date== "2/2/2007" )

subdata$Global_active_power <- as.numeric(subdata$Global_active_power)

png("plot1.png", height = 480, width = 480) # set the the dimension of the png image
hist(subdata$Global_active_power, col="red", border = "black",
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()