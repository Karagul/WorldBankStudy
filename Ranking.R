getRanking<-function(data, rankIndex){
  sortedData <- data[order(-data$Ranking),]
  return (as.character(sortedData$Long.Name[[rankIndex]]))
}
