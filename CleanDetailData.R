readDetailedData <- function() {
  originalData= read.csv(file = "./datasets/countryData.csv", header=TRUE, sep=",", fill = TRUE, quote = "\"", skipNul=TRUE)
  return (originalData) 
}

cleanDetailData <- function() {
  originalData <-readDetailedData()
  colnames(originalData)
  cleansedDetailData <- subset(originalData,  Income.Group!="")
  return (cleansedDetailData) 
}

detailData<-cleanDetailData()
