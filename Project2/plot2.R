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

#Total emissions in Baltimore from 1999 to 2008.
te<-tapply(NEI[NEI$fips %in% "24510",]$Emission, list(NEI[NEI$fips %in% "24510", ]$year),sum)

#Plot of te using base system
barplot(te,main="Total emissions in Baltimore, in tons",xlab="Year",ylab=expression(PM[2.5]))

#Save plot
dev.copy(png,"plots/plot2.png",units="px",height=480,width=480)
dev.off()
