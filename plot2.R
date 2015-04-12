library(dplyr)
library(lubridate)

#It creates a file connection and filtes the data that going to be represented.
conexion<-file("household_power_consumption.txt")
data<-readLines(con=conexion) %>% grep(pattern = "^1/2/2007|^2/2/2007|Date", value="TRUE")
close.connection(conexion)

#It saves the two-days-data-serie and reload it and creates a new column whith the formatted date
write(data,file="TwoDaysData.csv")
twoDaysSerie<-read.csv(file="TwoDaysData.csv",sep=";",stringsAsFactors =FALSE)
twoDaysSerie$Global_active_power<-as.double(twoDaysSerie$Global_active_power)
twoDaysSerie$Formatted_date<-dmy_hms(paste(twoDaysSerie$Date, twoDaysSerie$Time))

#It creates a new png device
png(filename = "plot2.png",width = 480, height = 480)
with(twoDaysSerie,
     {plot(twoDaysSerie$fecha,Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab = "")
        lines(twoDaysSerie$fecha,twoDaysSerie$Global_active_power,)
     }
     )

dev.off()

