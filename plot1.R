## Read RDS Files
setwd("./R/data")

if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all
## sources for each of the years 1999, 2002, 2005, and 2008.

## aggregate total emissions by year
plotdata <- aggregate(Emissions ~ year,NEI, sum)

## Take log10 to make the scale more presentable
plotdata$Emissions <- log10(plotdata$Emissions) 

## plot as basic x,y
plot(plotdata,type="o",pch=15, col="tomato2",xlim=c(1999,2008), xlab="Year of Reading", ylab="Log10 of Total PM2.5 Emissions in Tons")


## copy screen device to png file device
dev.copy(png, file="./plot1.png", width=480, height=480)
dev.off()

