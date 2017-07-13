library(tidyr)
getNumberOfRichestLowerMiddleIncome <- function(data) {
  spreadResult<-spread(data, key = Income.Group, value = GDP)
  queryResult <-subset(spreadResult, !is.na(spreadResult$`Lower middle income`) & spreadResult$Ranking< 39)
  return (NROW(queryResult))
}