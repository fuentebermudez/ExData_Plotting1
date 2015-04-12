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

#It creates a new plot in a new png device 
png(filename = "plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))

plot(twoDaysSerie$Formatted_date,twoDaysSerie$Global_active_power,type="n",ylab="Global active power",xlab = "")
lines(twoDaysSerie$Formatted_date,twoDaysSerie$Global_active_power)
         
        
plot(twoDaysSerie$Formatted_date,twoDaysSerie$Sub_metering_1,type="n",ylab="Energy sub metering",xlab = "")
lines(twoDaysSerie$Formatted_date,twoDaysSerie$Sub_metering_1,col="black")
lines(twoDaysSerie$Formatted_date,twoDaysSerie$Sub_metering_2,col="red")
lines(twoDaysSerie$Formatted_date,twoDaysSerie$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering 1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(2.5,2.5),col=c("black","red","blue"))
        
plot(twoDaysSerie$Formatted_date,twoDaysSerie$Global_reactive_power,type="n",ylab="Global reactive power",xlab = "Datetime")
lines(twoDaysSerie$Formatted_date,twoDaysSerie$Global_reactive_power)

plot(twoDaysSerie$Formatted_date,twoDaysSerie$Voltage,type="n",ylab="Voltage",xlab = "Datetime")
lines(twoDaysSerie$Formatted_date,twoDaysSerie$Voltage)


 
        


dev.off()
