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

## Subset SCC for coal combustion
coalcomb <- SCC[grepl("Coal", SCC$Short.Name) & grepl("Comb",SCC$SCC.Level.One),]
NEIcoalcomb <- NEI[NEI$SCC %in% coalcomb$SCC,]

## Load ggplot2 
library(ggplot2)

## plot using ggplot2 
gplot <- ggplot(NEIcoalcomb, aes(x = factor(year), y = Emissions)) + geom_bar(stat= "identity", width = .4, fill="blue") + xlab("Year") + ylab("Total PM2.5 Emissions") + ggtitle("Total Coal Combustion-Related PM2.5 Emissions")

## copy screen device to png file device
dev.copy(png, file="./plot4.png", width=480, height=480)

print(gplot)
dev.off()

