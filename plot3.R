## Read RDS Files
setwd("./R/data")

if (!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}


## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
## Which have seen increases in emissions from 1999 2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

## Subset data on FIPS code

baltimore <- subset(NEI, fips=="24510")

## aggregate total emissions by year
plotdata <- aggregate(Emissions ~ year,baltimore, sum)

## Load ggplot2 
library(ggplot2)

## plot using ggplot2 
gplot <- ggplot(plotdata, aes(year, Emissions, color = type))
gplot <- gplot + geom_line() +
        xlab("Year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total PM2.5 Emissions in Baltimore City by Year')

## copy screen device to png file device
dev.copy(png, file="./plot3.png", width=480, height=480)

print(gplot)
dev.off()

