# World Bank Information Analysis 

# Author: Ramin Farhanian

Date: July 13, 2017 

# Introduction:
World bank has released the information about 190 countries in separate files. We would like to analyze and extract information from these files. 

# Description

World bank has released the information about 190 countries in two files. The first file contains the data of Gross Domestic Product data for the 190 ranked countries 
(https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv). It has 
information about the countries with their short names, ranking, and Gross Domestic Product(https://en.wikipedia.org/wiki/Gross_domestic_product). 
We also have additional detail data of these countries(https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv). It consists  
of name of the countries, the income group, regional information, currency, latest population census, latest household survery, source of most recent income and expenditure data,
IMF data dissemination standard, latest trade data, latest water withdrawal data.

# Questions
 1. If we merge the country information by countryCode, how much additional detailed data do we have for 190 countries? 
 2. Which country has the lowest 13th ranking? 
 3. What are the average GDP rankings for the High income: OECD and High income nonOECD groups?
 4. What does the plot of the GDP for all of the countries look like if you use ggplot2 to color your plot by Income Group?
 5. If you cut the GDP ranking into 5 separate quantile groups, and make a table versus Income.Group, how many countries are Lower middle income but among the 38 nations with highest GDP?
 
 
#Instructions
Deliverable: Markdown file uploaded to GitHub containing the following:

a. Introduction to the project. The introduction should not start with For my project I .

b. The introduction needs to be written as if you are presenting the work to someone who has given you the data to analyze and wants to understand the result. In other words, pretend its not a case study for a course. Pretend its a presentation for a client.

c. Brief explanations of the purpose of the code. The explanations should appear as a sentence or two before or after the code chunk. Even though you will not be hiding the code chunks (so that I can see the code), you need to pretend that the client cant see them.

d. Code to answer the seven questions above (plus the answers) in the same R Markdown file.

e. Clear answers to the questions. Just the code to answer the questions is not enough, even if the code is correct and gives the correct answer. You must state the answer in a complete sentence outside the code chunk.

f. Conclusion to the project. Summarize your findings from this exercise. The file must be readable in GitHub. In other words, dont forget to keep the md file!! Note R Markdown files often do not render graphics and output from R Markdown chunks in GitHub. Keep the MD (markdown) file and upload it along with the R Markdown file.