#Download and unzip data 
if(!file.exists("data.zip")){
  print("Downloading data")
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url,"data.zip",method="curl")
  unzip("data.zip")
}

#Read data in
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Total emissions by year 1999,2002,2005, and 2008.
te<-tapply(NEI$Emission, list(NEI$year),sum)

#Plot of te using base system
barplot(te,main="Total emisisons, in tons",xlab="Year",ylab=expression(PM[2.5]))

#Save plot
dev.copy(png,"plots/plot1.png",units="px",height=480,width=480)
dev.off()
