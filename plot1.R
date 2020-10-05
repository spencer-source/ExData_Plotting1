## loads data

library(readr)
library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="econsumption.zip",method="curl",mode="wb")
unzip(zipfile = "econsumption.zip")
summary(Epower)
Epower <- read_delim("household_power_consumption.txt", delim = ";", quote = "\"", 
                     col_names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                                   "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                     col_types = list(col_date(format = "%d/%m/%Y"), col_time(format = "%T"), col_number(), col_number(), col_number(), col_number(), col_number(), col_number(), col_number()), 
                     na = c("?", " ", NA)) %>% 
        filter(Date == "2007-02-02" | Date == "2007-02-01") %>% data.frame()




## creates plot1

with(Epower, hist(Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)"))

## copy/save to png

dev.copy(png, file = "plot1.png")
dev.off()
