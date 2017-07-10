################
# Makefile
# Ramin Farhanian
# Updated 9 July 2017
################

## Introduction to Case Study 1 project

##Setting working directory
cat("Changing working directory.\nCurrent working directory: ", getwd(), "\n")
setwd("/Users/raminfarhanian/projects/R/caseStudyOne")
cat("working directory is changed to: ", getwd(), "\n")

## Libraries required
list.of.packages <- c("repmis", "RCurl", "ggplot2")
cat("Installing required libraries is missing:", list.of.packages , "\n")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
cat("Missing libraries installation is complete.", "\n")

## Part 1: Introduction to the problem
## The data of Gross Domestic Product data for the 190 ranked countries coming from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
## should be merged with the educational data coming from https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Here are the questions we can ask after the merge:
# If we merge the data based on the country shortcode, how many of ids match?
# If we sort the data frame in ascending order by GDP, what will be the 13th country in the resulting data frame?
# What are the average GDP rankings for the High income: OECD and High income nonOECD groups?
# What does the plot of the GDP for all of the countries look like if you use ggplot2 to color your plot by Income Group.
# If you cut the GDP ranking into 5 separate quantile groups, and make a table versus Income.Group, how many countries are Lower middle income but among the 38 nations with highest GDP?


## Part 2: Downloading required files
## Part 2-1: Downloading FGDP file
cat("Downloading GDP file:", "\n")
source("downloadGdpFile.R")
cat("GDP File is downloaded successfully.", "\n")

## Part 2-2: Downloading Educational data file
cat("Downloading Educational data file:", "\n")
source("downloadCountryFile.R")
cat("Educational data file is downloaded successfully.", "\n")


# Part 3: Reading and cleaning the data
# After doing an initial review, I figured that some clean ups have to be made before merging process. 
#GDP data
# The header data is not correct and must be cleaned up
# Empty lines should be skipped.
#

# Country data file
# Country data file contains invalid country information that should be cleaned up. The invalid lines are in two categories.
# 1-There are some lines that contain region information(Lines 55(East Asia & Pacific) to 58("Europe & Central Asia"), 113(Latin America & Caribbean), 
#119(Latin America & Caribbean (all income levels)),  136(middle east), 139(Middle Income), 144(Middle East and North Africa), 153(North America), 
#182(South Asia), 193-194(Sub-Saharan Africa), 228(world)

# Line 85(High income), 88(Heavily indebted poor countries)  
# 120(Least developed countries: UN classification), 121(Low income), 124(Lower middle income), 125(Low & middle income), 160(High income: nonOECD),
# 164(High income: OECD), 218(Upper middle income)
#dat <- readLines("./datasets/countryData.csv", n = 5)
#tt <- gsub("\\\\","\\",dat)
#zz <- textConnection(tt)
#myData <- read.csv(zz,header=TRUE,quote="\"")
#close(zz)
gdpData_content= read.csv(file =  "./datasets/fgdp.csv", header=TRUE, sep=",",fill = TRUE, quote = "", skipNul=TRUE)

countryData_content= read.csv(file = "./datasets/countryData.csv", header=TRUE, sep=",", fill = TRUE, quote = "\"", skipNul=TRUE)
print(countryData_content)



