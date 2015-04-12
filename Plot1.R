library(dplyr)

#It creates a file connection and filtes the data that going to be represented.
conexion<-file("household_power_consumption.txt")
data<-readLines(con=conexion) %>% grep(pattern = "^1/2/2007|^2/2/2007|Date", value="TRUE")
close.connection(conexion)
#It saves the two-days-data-serie and reload it.
write(data,file="TwoDaysData.csv")
twoDaysSerie<-read.csv(file="TwoDaysData.csv",sep=";",stringsAsFactors =FALSE)
twoDaysSerie$Global_active_power<-as.double(twoDaysSerie$Global_active_power)
#It creates a new png device
png(filename = "plot1.png",width = 480, height = 480)
with(twoDaysSerie,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()