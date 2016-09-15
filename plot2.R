## Read RDS Files
setwd("./R/data")

if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make
## a plot answering this question.

## Subset data on FIPS code
baltimore <- subset(NEI, fips=="24510")

## aggregate total emissions by year
plotdata <- aggregate(Emissions ~ year,baltimore, sum)

## plot as basic x,y
with(plotdata,plot(year,Emissions,pch=15, col="blue",xlim=c(1999,2008), xlab="Year of Reading", ylab="Total PM2.5 Emissions in Tons"))
title(main="Plot 2 - Total PM2.5 for Baltimore")

## copy screen device to png file device
dev.copy(png, file="./plot2.png", width=480, height=480)
dev.off()

