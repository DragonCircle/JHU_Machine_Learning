library(AppliedPredictiveModeling)
library(caret)
data(concrete)
set.seed(1000)
inTrain <- createDataPartition(mixtures$CompressiveStrength,p=0.75)[[1]]
training <- mixtures[inTrain,]
testing <- mixtures[-inTrain,]