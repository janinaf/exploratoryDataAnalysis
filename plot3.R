# This file contains code for Assignment1 in Coursera Exploratory Data Analysis
# To run the code, load sqldf package


# This assignment uses data from the UC Irvine Machine Learning Repository, a
# popular repository for machine learning datasets. In particular, we will be
# using the “Individual household electric power consumption Data Set” 
# 
# Dataset: Electric power consumption [20Mb] Description: Measurements of
# electric power consumption in one household with a one-minute sampling rate
# over a period of almost 4 years. Different electrical quantities and some
# sub-metering values are available. The following descriptions of the 9
# variables in the dataset are taken from the UCI web site:
# 
# Date: Date in format dd/mm/yyyy 
# Time: time in format hh:mm:ss 
# Global_active_power: household global minute-averaged active power (in
        ## kilowatt) 
# Global_reactive_power: household global minute-averaged reactive
        ## power (in kilowatt) 
# Voltage: minute-averaged voltage (in volt) 
# Global_intensity: household global minute-averaged current intensity (in
        ## ampere) 
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active
        ##energy). It corresponds to the kitchen, containing mainly a dishwasher, an
        ## oven and a microwave (hot plates are not electric but gas powered). 
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It
        ## corresponds to the laundry room, containing a washing-machine, a tumble-drier,
        ## a refrigerator and a light. 
# Sub_metering_3: energy sub-metering No. 3 (in
        ## watt-hour of active energy). It corresponds to an electric water-heater and an
        ## air-conditioner.


#Plot3: Energy sub metering on Thu, Fri, Sat

fileURL<-"https://www.dropbox.com/s/sp1ufm0tma9yzsb/household_power_consumption.txt?dl=0"

#load only data for 1 and 2 February, 2007 in one data frame, PowerConsumption

PowerConsumption1 <-
        read.csv2.sql(
                './ElectricPowerConsumption.csv', sql = "select * from file where Date=='1/2/2007'  ", header =
                        TRUE, sep = ';', quote = '', na.strings = '?'
        )
PowerConsumption2 <-
        read.csv2.sql(
                './ElectricPowerConsumption.csv', sql = "select * from file where Date=='2/2/2007'  ", header =
                        TRUE, sep = ';', quote = '', na.strings = '?'
        )
PowerConsumption<-rbind(PowerConsumption1, PowerConsumption2)

#transform Date and Time into minutes

x <- paste(PowerConsumption$Date, PowerConsumption$Time)
z<-strptime(x, "%d/%m/%Y %H:%M:%S")

# each data point is associated with a day of the week
day<-weekdays.POSIXt(z)

# find the maximum of Y axis
maxY<- max(range(PowerConsumption$Sub_metering_1), range(PowerConsumption$Sub_metering_2),range(PowerConsumption$Sub_metering_3))

# call device driver to avoid having the plot cut off to the right
png(file='Plot3.png', width = 480, height = 480, units = "px")

#start the graph without x and y axes or lines; then add x & y axis; then add the lines representing the graph itself
plot(
        1:length(PowerConsumption$Sub_metering_1), PowerConsumption$Sub_metering_1, 
        type = 'n',xaxt = 'n', yaxt = 'n', xlab = "", ylab = 'Energy sub metering'
)
axis(
        side = 1, at = c(0,length(PowerConsumption$Sub_metering_1) / 2, length(PowerConsumption$Sub_metering_1) ), 
        labels = c('Thu', 'Fri', 'Sat' )   )
axis(   side = 2, at = c(0, 10, 20, 30),
        labels = c('0', '10', '20', '30' )  )

lines(1:length(PowerConsumption$Sub_metering_1), PowerConsumption$Sub_metering_1, col='black')
lines(1:length(PowerConsumption$Sub_metering_2), PowerConsumption$Sub_metering_2, col='red')
lines(1:length(PowerConsumption$Sub_metering_3), PowerConsumption$Sub_metering_3, col='blue')

legend('topright', legend =c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), xjust=0 , lwd=c(2,2), col=c('black', 'red', 'blue') )



dev.off()


