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

#Total emissions for motor vehicles in Baltimore from 1999 to 2008.
# Accroding to Page 11 from the report, 
# http://www.epa.gov/ttn/chief/net/2008report.pdf 
# all motor vehicles are represented by the type ON-ROAD in NEI dataset
te<-tapply(NEI[NEI$type=="ON-ROAD" & NEI$fips=="24510",]$Emission, list(NEI[NEI$type=="ON-ROAD" & NEI$fips=="24510", ]$year),sum)

#Plot of te using base system
barplot(te, 
        main="Emissions from motor vehicles\nin Baltimore, in tons",
        xlab="Year",
        ylab=expression(PM[2.5]))

#Save plot
dev.copy(png,"plots/plot5.png",units="px",height=480,width=480)
dev.off()
