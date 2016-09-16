## Project 2 - Question 6

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
NEI.vehicles  <- NEI[NEI$SCC %in% SCC.vehiclesb,]


## Subset for the two cities 
NEI.vehicles.BC <- NEI.vehicles[NEI.vehicles$fips=="24510",]
NEI.vehicles.BC$City <- "Baltimore"

NEI.vehicles.LA <- NEI.vehicles[NEI.vehicles$fips=="06037",]
NEI.vehicles.LA$City <- "Los Angeles"

NEI.both <- rbind(NEI.vehicles.BC, NEI.vehicles.LA)

## Load ggplot2 
library(ggplot2)

## plot using ggplot2 
gplot <- ggplot(NEI.both, aes(x=factor(year), y=Emissions, fill=City)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~City) +
        guides(fill=FALSE) + theme_bw() +
        labs(x="year", y=expression("Total PM"[2.5]*" Emissions")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA"))

print(gplot)

## copy screen device to png file device
dev.copy(png, file="./plot6.png", width=480, height=480)

dev.off()
