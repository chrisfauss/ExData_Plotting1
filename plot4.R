library(chron)

## directory needs to be set as in the folder exdata_data_household_power_consumption")

## Loading in the data from source data file. The right working directory needs to be set.
dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

## Change the column Date into proper dates
dat$Date <- strptime(dat$Date, "%d/%m/%Y")
dat$Date <- as.Date(dat$Date)

## Change the column Time into proper times
dat$Time <- strptime(dat$Time, format = "%H:%M:%S")
dat$Time <- format(dat$Time, "%H:%M:%S")
dat$Time <- chron(times = dat$Time)

## Further adaptions on the classes: Make every column numeric except Date and Time
dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power))
dat$Global_reactive_power <- as.numeric(as.character(dat$Global_reactive_power))
dat$Voltage <- as.numeric(as.character(dat$Voltage))
dat$Global_intensity <- as.numeric(as.character(dat$Global_intensity))
dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))
dat$Sub_metering_3 <- as.numeric(as.character(dat$Sub_metering_3))

## Select the subset 
dat1 <- dat[which(dat$Date == "2007-02-01" | dat$Date == "2007-02-02"), ]

# Create another variable combining date and time
dat1$Date_Time <- as.POSIXct(paste(dat1$Date, dat1$Time), format="%Y-%m-%d %H:%M:%S")
# Set the Time setting in english
Sys.setlocale("LC_TIME", "English")

#######
# Starting with plot4 
#######

## Create 4 different charts and sort them
setwd("..")
png("plot4.png")

par(mfrow = c(2,2))

## Plot 1

plot(dat1$Date_Time, dat1$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", pch = "")

## Plot 2
plot(dat1$Date_Time, dat1$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", pch = "")

## Plot 3
plot(dat1$Date_Time, dat1$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", pch = "")
lines(dat1$Date_Time, dat1$Sub_metering_1)
lines(dat1$Date_Time, dat1$Sub_metering_2, col="red")
lines(dat1$Date_Time, dat1$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3") ,lty=c(1,1), lwd=c(2.5,2.5,2.5), col = c("Black", "Red", "Blue"),bty = "n" )

## Plot 4
plot(dat1$Date_Time, dat1$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", pch = "", las = 2)
axis(2, at=c(1:6), labels = c("0.0","0.1","0.2","0.3","0.4","0.5"))

dev.off()

