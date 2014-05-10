############################################
#plot2.R
#
#plots a line chart of 2 Global Active Power 
#over two days
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


#plot the line chart to the screen
dateTime<-strptime(paste(powerData$Date,powerData$Time),format ="%Y-%m-%d %H:%M:%S" )  
plot(dateTime,powerData$Global_active_power,
     type="l",
     main = "",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#open a png file device in the working directory
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

#replot the line chart, this time to the png device
plot(dateTime,powerData$Global_active_power,
     type="l",
     main = "",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#close the png file device
dev.off() 


