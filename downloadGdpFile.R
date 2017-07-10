library(repmis)
library(RCurl)
gdpData_source <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdpData_destination <- "./datasets/fgdp.csv"
download.file(url = gdpData_source, destfile = gdpData_destination)
