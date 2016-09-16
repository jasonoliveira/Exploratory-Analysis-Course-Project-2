## Project 2 - Question 5

## Read RDS Files
setwd("./R/data")

if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

library(plyr)

## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Subset data on FIPS code
baltimore <- subset(NEI, fips=="24510")


## Subset SCC for mobile on road vehicles
SCC.vehiclesa <- grepl("Vehicles", SCC$EI.Sector, ignore.case=TRUE)
SCC.vehiclesb <- SCC[SCC.vehiclesa,]$SCC

## Subset NEI data for motor vehicles
NEI.vehicles  <- baltimore[baltimore$SCC %in% SCC.vehiclesb,]


## Load ggplot2 
library(ggplot2)

## plot using ggplot2 
gplot <- ggplot(NEI.vehicles, aes(x = factor(year), y = Emissions)) + geom_bar(stat= "identity", width = .4, fill="blue") + xlab("Year") + ylab("Total PM2.5 Emissions") + ggtitle("Total Vehicle-Related PM2.5 Emissions in Baltimore")

print(gplot)

## copy screen device to png file device
dev.copy(png, file="./plot5.png", width=480, height=480)

dev.off()

