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


## creates plot2

par(mar = c(2, 2, 2, 2), oma = c(1, 1, 1, 1), mex = 1, mgp = c(3, 0.5, 0), tcl = -0.3)
with(Epower, plot(Global_active_power, type = "l", ylab = "", xlab = "", xaxt = "n", cex.axis = 0.75, cex.lab = .75))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"), line = 0, cex.axis = 0.75)
mtext("Global Active Power (kilowatts)", side = 2, line = 1.5, cex = 1)

## copy/save to png

dev.copy(png, file = "plot2.png")
dev.off()

