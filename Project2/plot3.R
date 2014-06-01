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

#Total emissions in Baltimore from 1999 to 2008 by type.
te<-tapply(NEI[NEI$fips %in% "24510",]$Emission, 
           list(NEI[NEI$fips %in% "24510", ]$year,NEI[NEI$fips %in% "24510", ]$type),sum)

#Plot of te using ggplot2 system
require(ggplot2)
require(reshape)

ggplot(melt(te),aes(X2,value,fill=factor(X1)))+
  geom_bar(stat="identity", position="dodge") +
  xlab("Type") + ylab(expression(PM[2.5])) + 
  labs(title="Emissions in Baltimore by type and year, in tons") +
  scale_fill_discrete(name="Year")+
  theme(plot.title=element_text(size=rel(1.4)))

#Save plot
dev.copy(png,"plots/plot3.png",units="px",height=480,width=480)
dev.off()
