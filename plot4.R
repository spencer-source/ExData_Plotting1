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


## creates 4 plots


par(mfrow = c(2, 2), mar = c(2, 2, 2, 2), oma = c(3, 1, 3, 1), mex = 1, mgp = c(3, 0.5, 0), tcl = -0.3)
with(Epower, {
        plot(Global_active_power, type = "l", ylab = "", xlab = "", xaxt = "n", cex = 0.75, cex.axis = 0.75, lwd = 0.75)
        axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"), line = 0, cex = 0.75, cex.axis = 0.75)
        mtext("Global Active Power", side = 2, line = 1.5, cex = 0.75)
        
        plot(Voltage, type = "l", ylab = "", xlab = "", xaxt = "n", cex.axis = 0.75, cex.lab = 0.75, lwd = 0.75)
        axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"), line = 0, cex = 0.75, cex.axis = 0.75, cex.lab = 0.75)
        mtext("datetime", side = 1, line = 1.5, cex = 0.75)
        mtext("Voltage", side = 2, line = 1.5, cex = 0.75)
        
        plot(Sub_metering_1, type = "l", col = "black", ylab = "", xlab = "", xaxt = "n", cex.axis = 0.75, cex.lab = 0.75, lwd = 0.75)
        axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"), line = 0, cex.axis = 0.75)
        mtext("Energy sub metering", side = 2, line = 1.5, cex = 0.75)
        with(Epower, lines(Sub_metering_2, type = "l", col = "red", lwd = 0.75))
        with(Epower, lines(Sub_metering_3, type = "l", col = "blue", lwd = 0.75))
        legend("topright", col = c('black','red','blue'), 
               legend = c("Sub_metering_1", 
                          "Sub_metering_2", 
                          "Sub_metering_3"), lty = 1, lwd = 0.5, bty = "n", adj = c(0, 0.5), cex = 0.5, ncol = 1, y.intersp = 0.5)
        
        plot(Global_reactive_power, type = "l", ylab = "", xlab = "", xaxt = "n", cex.axis = 0.75, cex.lab = .75, lwd = 0.75)
        axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"), line = 0, cex = 0.75, cex = 0.75, cex.axis = 0.75)
        mtext("datetime", side = 1, line = 1.5, cex = 0.75)
        mtext("Global_reactive_power", side = 2, line = 1.5, cex = 0.75)
})

## copy/save to png

dev.copy(png, file = "plot4.png")
dev.off()
