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

#Total emissions for motor vehicles in Baltimore and LA by year
a<-NEI$fips %in% c("24510","06037")
onroad<-NEI$type=="ON-ROAD"

te<-tapply(NEI[a & onroad,]$Emission, 
           list(NEI[a & onroad,]$year,NEI[a & onroad,]$fips),sum)

#Relative(percentage) changes in total emissions for motor vehicles 
#in Baltimore and LA by year, base year is 1999
relativeChanges<-rbind(c(0,0),(te[-1,]-te[-4,])/te[-4,]*100)
colnames(relativeChanges)<-c("LA","Baltimore")
rownames(relativeChanges)<-rownames(te)

#Plot of relativeChanges using base system
barplot(t(relativeChanges),main="Relative changes in total emisisons from\nmotor vehicles in Baltimore vs. LA,\nin %, base year is 1999",
        xlab="Year",
        ylab="%",
        ylim=c(-80,20),
        beside=TRUE,
        legend=colnames(relativeChanges),
        args.legend = list(title = "City", x = "bottomright"),
        cex.main=1
        )

#Save plot
dev.copy(png,"plots/plot6.png",units="px",height=480,width=480)
dev.off()
