library(repmis)
library(RCurl)
countryData_source <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
countryData_destination <- "./datasets/countryData.csv"
download.file(url = countryData_source, destfile = countryData_destination)
