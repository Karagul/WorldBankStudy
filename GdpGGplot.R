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