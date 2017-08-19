## Read the data with special dates.
## Note: You should put data file in the current folder.
data <- read.table(
    "household_power_consumption.txt",
    sep = ";",
    col.names = c(
        "Date",
        "Time",
        "Global_active_power",
        "Global_reactive_power",
        "Voltage",
        "Global_intensity",
        "Sub_metering_1",
        "Sub_metering_2",
        "Sub_metering_3"
    ),
    na.strings = "?",
    colClasses = c(rep("character", 2), rep("numeric", 7)),
    skip = grep("^1/2/2007",
                readLines("household_power_consumption.txt")) - 1,
    nrows = 2880
)

## Create DateTime object from 1st and 2nd columns.
data$DateAndTime <-
    strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

## Making plots.
## Open a graphic device.
png("plot3.png", 480, 480)

## Draw three lines and add legend.
plot(
    data$DateAndTime,
    data$Sub_metering_1,
    xlab = "",
    ylab = "Energy sub metering",
    type = "l"
)

lines(
    data$DateAndTime,
    data$Sub_metering_2,
    type = "l",
    col = "Red"
)

lines(
    data$DateAndTime,
    data$Sub_metering_3,
    type = "l",
    col = "Blue"
)

legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = 1,
    col = c("Black", "Red", "Blue")
)

## Close.
dev.off()

