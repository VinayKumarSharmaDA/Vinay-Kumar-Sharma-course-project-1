Load and clean data

vny <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
vny$Date <- as.Date(vny$Date, "%d/%m/%Y")
  
## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
vny <- subset(vny,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
vny <- vny[complete.cases(vny),]

## Combine Date and Time column
vnydt <- paste(vny$Date, vny$Time)
  
## Name the vector
vnydt <- setNames(vnydt, "DateTime")
  
## Remove Date and Time column
vny <- vny[ ,!(names(vny) %in% c("Date","Time"))]
  
## Add DateTime column
vny <- cbind(vnydt, vny)
  
## Format dateTime Column
vny$vnydt <- as.POSIXct(vnydt)




#############################################  plot4.R

  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  with(vny, {
    plot(Global_active_power~vnydt, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~vnydt, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~vnydt, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~vnydt,col='Red')
    lines(Sub_metering_3~vnydt,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~vnydt, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
  })

############################################  saved png file for plot4 and device off

 dev.copy(png,"plot4.png", width=480, height=480)
 dev.off()