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

#Total emissions across the US from 1999 to 2008 by type.
  #Find the SCC numbers that contain the word coal in it
coalSCC<-SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE) | grepl("coal", SCC$EI.Sector, ignore.case=TRUE), ]

te<-tapply(NEI[NEI$SCC %in% coalSCC$SCC,]$Emission, list(NEI[NEI$SCC %in% coalSCC$SCC, ]$year),sum)

#Plot of te using base system
barplot(te, 
        main="Emissions from coal combustion related sources\nacross the US, in tons",
        xlab="Year",
        ylab=expression(PM[2.5]))

#Save plot
dev.copy(png,"plots/plot4.png",units="px",height=480,width=480)
dev.off()
