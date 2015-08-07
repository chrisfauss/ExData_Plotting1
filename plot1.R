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
str(dat)

## Select the subset 
dat1 <- dat[which(dat$Date == "2007-02-01" | dat$Date == "2007-02-02"), ]

#######
# Starting with plot1 
#######

## Create a histogram based on Global_active_power
setwd("..")
png("plot1.png")
hist(dat1$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()
