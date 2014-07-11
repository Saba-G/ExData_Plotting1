library(sqldf) 
sub1 <- read.csv2.sql("household_power_consumption.txt",sql="SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'",sep=";",na.strings="?" )
datetime <- paste(sub1$Date, sub1$Time, sep= " ")
x <- strptime(datetime, format= "%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png", width=480, height=480)
par(mfrow=c(2,2))
par(mar=c(5,5,4,1))

with(sub1, {
        plot(x, sub1$Global_active_power, type="l", xlab="", ylab="Global_active_power")
        plot(x, sub1$Voltage, type="l", xlab="datetime", ylab="Voltage")
                
        with(sub1, {
                y <- sub1$Sub_metering_1
                plot(x, y, xlab="", ylab= "Energy sub metering", type= "n")
                with(sub1, lines(x,sub1$Sub_metering_1))
                with(sub1, lines(x,sub1$Sub_metering_2, col= "red"))
                with(sub1, lines(x,sub1$Sub_metering_3, col= "blue"))
                legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
        })
        
        plot(x, sub1$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})

dev.off()
