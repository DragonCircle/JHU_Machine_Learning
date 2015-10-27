library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

IL_cols <- grepl("^IL",colnames(training))
training_IL <- cbind(training[,c(IL_cols)],diagnosis=training[,1])
testing_IL <- cbind(testing[,c(IL_cols)],diagnosis=testing[,1])
#preObj <- preProcess(training_IL,method=c("pca"),thresh = 0.8)
# proProcess with PCA method, Use 7 comp to cover 80% variance
preProc <- preProcess(training_IL[,-13],method="pca",pcaComp=7) 
trainPC <- predict(preProc,training_IL[,-13])
modelFit <- train(training_IL$diagnosis~.,method="glm",data=trainPC)
testPC <- predict(preProc,testing_IL[,-13])
confusionMatrix(testing_IL$diagnosis,predict(modelFit,testPC)) #0.7195 Accuracy
#without PCA method
modelFit_NPC <- train(training_IL$diagnosis~.,method="glm",data=training_IL)
confusionMatrix(testing_IL$diagnosis,predict(modelFit_NPC,testing_IL)) #0.6463 Accuracy