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



############################################### plot1.R

hist(vny$Global_active_power,  main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

############################################## saved Png file and device off

  dev.copy(png,"plot1.png", width=480, height=480)
  dev.off()

