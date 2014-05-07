# Download and save data file as "data.zip"
if(!file.exists("data.zip")){
  print("Downloading data")
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,"data.zip", method="curl")
}

# Unzip file and read in train and test data sets
if(!file.exists("household_power_consumption.txt")){unzip("data.zip")}

# Read in data between 0/01/2007 and 02/01/2007
data<-read.table("household_power_consumption.txt", sep=";", skip=66637,nrow=2880)
names(data)<-strsplit(readLines("household_power_consumption.txt",n=1),";")[[1]]

# Convert date column in data into date format
data<-data.frame(Date_Time=0,data)
data$Date_Time<-paste(data$Date,data$Time,sep=" ")
data$Date<-as.Date(data$Date,tz="EST", format="%d/%m/%Y")
data$Date_Time<-strptime(data$Date_Time,format="%d/%m/%Y %H:%M:%S",tz="EST")

# Plot 2
with(data,plot(Date_Time,Global_active_power,type="l",lwd=1,
               xlab="",ylab="Global active power (kilowatts)"))

# Save plot to a png file
dev.copy(png,"plot2.png",units="px",height=480,width=480)
dev.off()