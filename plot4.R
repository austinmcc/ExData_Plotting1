############################################
#plot4.R
#
#plots 4 graphs for 2 days worth of 
#data for global active power, voltage, 
#submetering and global reactive power
############################################

#Read in the data file from the working directory
powerData<-read.table("household_power_consumption.txt",header=TRUE, sep=";")

#Set the Date column as a factor and trim the dataframe to the two days
#of interest -"1/2/2007", "2/2/2007"
powerData$Date<-as.factor(powerData$Date)
powerData<-subset(powerData,powerData$Date %in% c("1/2/2007", "2/2/2007"))

#Set the Date column to be of Date tye
powerData$Date<- as.Date(powerData$Date,format = "%d/%m/%Y")

#For each of the numeric data columns:
#replace any "?"s with NAs and convert to numeric type
for (i in 3:9) {
    col <- powerData[, i]
    col[grep("\\?", col)] <- NA
    powerData[, i] <- as.numeric(as.character(col))
    }

#plot the graph to the screen

dateTime<-strptime(paste(powerData$Date,powerData$Time),format ="%Y-%m-%d %H:%M:%S" )  

par(mfrow = c(2, 2))
par(cex = 0.8)
with(powerData,{
    #plot top left
    plot(dateTime,Global_active_power,
         type="l",
         main = "",
         xlab = "",
         ylab = "Global Active Power")
    
    #plot top right
    plot(dateTime,Voltage,
         type="l",
         main = "",
         xlab = "datetime",
         ylab = "Voltage")
    
    #plot bottom left
    plot(dateTime,Sub_metering_1,
         type="l",
         main = "",
         xlab = "",
         ylab = "Energy sub metering")
    
    lines(dateTime,Sub_metering_2, type="l",  col="red")
    
    lines(dateTime,Sub_metering_3, type="l",  col="blue")
    
    legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
           col=c("black","red","blue"),  lty=1, bty = "n", cex = 0.9)
    
    #plot bottom right
    plot(dateTime,Global_reactive_power,
         type="l",
         main = "",
         xlab = "datetime"
    )
})

#open a png file device in the working directory
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

#replot the graph, this time to the png device
par(mfrow = c(2, 2))
par(cex = 0.8)
with(powerData,{
    #plot top left
    plot(dateTime,Global_active_power,
         type="l",
         main = "",
         xlab = "",
         ylab = "Global Active Power")
    
    #plot top right
    plot(dateTime,Voltage,
         type="l",
         main = "",
         xlab = "datetime",
         ylab = "Voltage")
    
    #plot bottom left
    plot(dateTime,Sub_metering_1,
         type="l",
         main = "",
         xlab = "",
         ylab = "Energy sub metering")
    
    lines(dateTime,Sub_metering_2, type="l",  col="red")
    
    lines(dateTime,Sub_metering_3, type="l",  col="blue")
    
    legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
           col=c("black","red","blue"),  lty=1, bty = "n", cex = 0.9)
    
    #plot bottom right
    plot(dateTime,Global_reactive_power,
         type="l",
         main = "",
         xlab = "datetime"
    )
})

#close the png file device
dev.off() 


