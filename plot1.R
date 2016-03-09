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


#Plot1: Frequency count of  Global Active Power

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

#create histogram
mfrow=c(1,1) 
hist(PowerConsumption$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowats)' )

# save histogram as .png file in the working directory

dev.copy(png, file='Plot1.png', width = 480, height = 480, units = "px")
dev.off()


