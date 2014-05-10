############################################
#plot1.R
#
#plots a histogram for 2 days worth of 
#Global Active Power data
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

#plot the histogram to the screen
hist(
    powerData$Global_active_power, col="red", 
    xlim = c(0,6), ylim = c(0,1200),
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    #switch off the auto axes as we'll set the axes manually below
    axes=FALSE
    )

#set the axes manually to get the specified tick mark separation
axis(1, at=c(0,2,4,6), labels=NULL)
axis(2, at=c(0,200,400,600,800,1000,1200), labels=NULL)

#open a png file device in the working directory
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

#replot the histogram, this time to the png device
hist(
    powerData$Global_active_power, col="red", 
    xlim = c(0,6), ylim = c(0,1200),
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    axes=FALSE
)

axis(1, at=c(0,2,4,6), labels=NULL)
axis(2, at=c(0,200,400,600,800,1000,1200), labels=NULL)

#close the png file device
dev.off() 


