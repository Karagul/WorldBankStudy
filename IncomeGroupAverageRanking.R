incomeGroupAverageRanking<-function(incomeGroupName){
  subsetData <-subset(mergeResult, Income.Group == incomeGroupName)
  return (ceiling(mean(as.numeric(subsetData$Ranking))))
}
