library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData <- data.frame(diagnosis,predictors)
inTrain <- createDataPartition(adData$diagnosis, p=0.75)[[1]]
training <- adData[inTrain,]
testing <- adData[-inTrain,]

IL_cols <- grepl("^IL",colnames(training))
training_IL <- training[,c(IL_cols)]

preObj <- preProcess(training_IL,method=c("pca"),thresh = 0.8)