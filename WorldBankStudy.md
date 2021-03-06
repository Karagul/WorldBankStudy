# World Bank Study
Ramin Farhanian  
July 13, 2017  
# Introduction
 World bank has released the information about 190 countries in two files. We would like to analyze these files and extract some information about some countries.
 
# The files 
 The first file contains the data of Gross Domestic Product data for the 190 ranked countries 
 (https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv). It has information about the countries with their short names, ranking, an empty column, and Gross Domestic Product(https://en.wikipedia.org/wiki/Gross_domestic_product). There is also an additional detail data of these countries in a separate file (https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv). It consists of the following columns: 

1. CountryCode                                       
2. Long.Name                                         
3. Income.Group"                                     
4. Region                                            
5. Lending.category
6. Other.groups                                     
7. Currency.Unit                                     
8. Latest.population.census
9. Latest.household.survey                          
10. Special.Notes
11. National.accounts.base.year
12. National.accounts.reference.year                 
13. System.of.National.Accounts
14. SNA.price.valuation
15. Alternative.conversion.factor
16. PPP.survey.year
17. Balance.of.Payments.Manual.in.use
18. External.debt.Reporting.status
19. System.of.trade                                   
20. Government.Accounting.concept
21. IMF.data.dissemination.standard
22. Source.of.most.recent.Income.and.expenditure.data
23. Vital.registration.complete
24. Latest.agricultural.census
25. Latest.industrial.data                            
26. Latest.trade.data
27. Latest.water.withdrawal.data
28. X2.alpha.code
29. WB.2.code
30. Table.Name    



##Questions
 1. If we merge the country information by countryCode, how much additional detailed data do we have for 190 countries? 
 2. Which country has the lowest 13th ranking? 
 3. What are the average GDP rankings for the High income: OECD and High income nonOECD groups?
 4. What does the plot of the GDP for all of the countries look like if you use ggplot2 to color your plot by Income Group.
 5. If you cut the GDP ranking into 5 separate quantile groups, and make a table versus Income.Group, how many countries are Lower middle income but among the 38 nations with highest GDP?

# Setting working directory


```r
setwd("/Users/raminfarhanian/projects/R/WorldBankStudy")
```

# Required Packages
The required packages should be installed once before the rest of the code executes. 

```r
installLibrariesOnDemand <- function (packages)
{
  cat("Installing required libraries on demand:", packages , "\n")
  new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  cat("Missing libraries installation is complete.", "\n")
}
installLibrariesOnDemand(c("repmis", "RCurl", "tidyr", "ggplot2"))
```

```
## Installing required libraries on demand: repmis RCurl tidyr ggplot2 
## Missing libraries installation is complete.
```

# Downloading FGDP file


```r
library(repmis)
library(RCurl)
```

```
## Loading required package: bitops
```

```r
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "./fgdp.csv")
```

# Downloading Detail data file


```r
library(repmis)
library(RCurl)
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "./countryData.csv")
```

# GDP data cleaning steps
GDP data cannot be consumed without going through cleaning process. 
The first few lines are empty and contain invalid data. The header data is not correct and must be cleaned up.
Empty and invalid lines should be skipped. GDP values in some lines should be trimmed.
Invalid lines are in seven categories:

 1. Lines missing Gross Domestic Product value(line 197 to 220 in the original file).
 2. Some lines are empty (line 1, 2, 3, 4, 196, 221, 223, 237)
 3. Some lines comprise information about a region and not a country
 4. The GDP value of most of the lines cannot be used numbers.
 5. Some lines have an additonal invalid column (lines 67, 78, 100, 102, 119, 146)
 6. Line 104 country information(Ivory Coast) is in French. The file should be read in UTF-8 to avoid Internationalization issues.
 7. The ranking data should be transformed into Numeric.
 

```r
readGdpData <- function() {
  originalData= read.csv(file =  "./fgdp.csv" , header=TRUE, sep=",",fill = TRUE, quote = "\"", skipNul=TRUE, encoding = "UTF-8")
  return (originalData) 
}

cleanGdpData <- function() {
  gdpData_original= readGdpData()
  colnames(gdpData_original)<- c("CountryCode", "Ranking", "", "Country", "GDP", "removeableColumn")
  gdpData_cleansed <- subset(gdpData_original, select = c("CountryCode", "Ranking", "GDP"),  CountryCode!="" & Ranking!="")
  gdpData_cleansed$Ranking <- as.numeric(as.character(gdpData_cleansed$Ranking))
  gdpData_cleansed$GDP <-as.numeric(gsub("[^[:digit:]]","", gdpData_cleansed$GDP))
  return (gdpData_cleansed) 
}

gdpData<-cleanGdpData()
```

# Detail data  cleaning steps
Detail data contains invalid detail information that should be cleansed. The invalid lines are in two categories: 

 1. The lines that contain regional information. Lines 55(East Asia & Pacific) to 58("Europe & Central Asia"), 113(Latin America & Caribbean), 
119(Latin America & Caribbean (all income levels)),  136(middle east), 139(Middle Income), 144(Middle East and North Africa), 153(North America), 
182(South Asia), 193-194(Sub-Saharan Africa), 228(world)
 2. The lines that have income groups as country short names. Line 85(High income), 88(Heavily indebted poor countries) 120(Least developed countries: UN classification), 121(Low income), 124(Lower middle income), 125(Low & middle income), 160(High income: nonOECD), 164(High income: OECD), 218(Upper middle income)

They can be cleanse using "Income.Group" as invalid countries have no value for income group.


```r
readDetailedData <- function() {
  originalData= read.csv(file = "./countryData.csv", header=TRUE, sep=",", fill = TRUE, quote = "\"", skipNul=TRUE)
  return (originalData) 
}

cleanDetailData <- function() {
  originalData <-readDetailedData()
  colnames(originalData)
  cleansedDetailData <- subset(originalData,  Income.Group!="")
  return (cleansedDetailData) 
}

detailData<-cleanDetailData()
```

# Merging the data by country short code
If we merge the country information by countryCode, how much additional detailed data do we have for 190 countries? The answer is 189.


```r
mergeResult<-merge(gdpData,detailData, by="CountryCode")
firstAnswer<-NROW(mergeResult)
cat("Question 1: If we merge the country information by countryCode, how much additional detailed data do we have for 190 countries?" , firstAnswer, "\n")
```

```
## Question 1: If we merge the country information by countryCode, how much additional detailed data do we have for 190 countries? 189
```

# Sorting the data
Which country has the lowest 13th ranking? St. Kitts and Nevis.

```r
getRanking<-function(data, rankIndex){
  sortedData <- data[order(-data$Ranking),]
  return (as.character(sortedData$Long.Name[[rankIndex]]))
}
cat("Question 2: Which country has the lowest 13th ranking?  ", getRanking(mergeResult, 13), "\n")
```

```
## Question 2: Which country has the lowest 13th ranking?   St. Kitts and Nevis
```


# The average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups
The average GDP ranking for the "High income: OECD" is  33, and for "High income: nonOECD" is 92.

```r
getIncomeGroupAverageRanking<-function(incomeGroupName){
  subsetData <-subset(mergeResult, Income.Group == incomeGroupName)
  return (ceiling(mean(as.numeric(subsetData$Ranking))))
}
cat("Question 3-1: What is the average GDP rankings for the High income: OECD? ", getIncomeGroupAverageRanking("High income: OECD"), "\n")
```

```
## Question 3-1: What is the average GDP rankings for the High income: OECD?  33
```

```r
cat("Question 3-2: What is the average GDP rankings for the High income: nonOECD?", getIncomeGroupAverageRanking("High income: nonOECD"), "\n")
```

```
## Question 3-2: What is the average GDP rankings for the High income: nonOECD? 92
```

# GDP GGPlot
The plot of the GDP for all of the countries using ggplot2 to color your plot by Income Group.

```r
library(ggplot2)
library(scales)
getGdpGgPlot<-function()
{
  subsetData <-subset(mergeResult, Income.Group == "High income: OECD")
  data<-mergeResult
  Country<-mergeResult$Ranking
  GDP<-mergeResult$GDP
  IncomeGroup<-mergeResult$Income.Group
  gg <- ggplot(mergeResult, aes(x=Country, y=GDP,color=IncomeGroup)) + theme(axis.text.x =  element_blank(), axis.ticks = element_blank())
  gg<-gg + geom_point()
return (gg)
}

print(getGdpGgPlot())
```

![](WorldBankStudy_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

# 38 Richest Lower Middle Income Countries
If you cut the GDP ranking into 5 separate quantile groups, and make a table versus Income.Group, how many countries are Lower middle income but among the 38 nations with highest GDP? The answer is 5.

```r
library(tidyr)
```

```
## 
## Attaching package: 'tidyr'
```

```
## The following object is masked from 'package:RCurl':
## 
##     complete
```

```r
getNumberOfRichestLowerMiddleIncome <- function(data) {
  spreadResult<-spread(data, key = Income.Group, value = GDP)
  queryResult <-subset(spreadResult, !is.na(spreadResult$`Lower middle income`) & spreadResult$Ranking< 39)
  return (NROW(queryResult))
}
cat("Question 5: how many countries are Lower middle income but among the 38 nations with highest GDP?", getNumberOfRichestLowerMiddleIncome(mergeResult))
```

```
## Question 5: how many countries are Lower middle income but among the 38 nations with highest GDP? 5
```

# Conclusion
This study is a reproducible research that tries to answer some questions using world bank information. Using applied methods in this study, more analysis can be performed, and more questions can be answered. World Bank information has some additional information such as world and regional information that were ignored as they were beyond the scope of this study.  
