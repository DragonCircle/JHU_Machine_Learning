library(caret)
data <- read.csv("pml-training.csv")
data <- data[-c(1:7)]
nzv <- nearZeroVar(data)
data <- data[,-nzv]  # removing near Zero covariates
data <- data[,colSums(is.na(data))==0] # removing columns that include NA values



print(dim(data)) # now we remains 53 predictors
test_final <- read.csv("pml-testing.csv")
test_final <- test_final[,colnames(data)[-53]]

inTrain <- createDataPartition(data$classe,p=0.75,list=FALSE)
training <- data[inTrain,]
testing <- data[-inTrain,]
preObj <- preProcess(training[,-53],method="pca",thresh=0.8)
print(preObj) # Shows that We Need 12 compoments to capture 80% of the variance
trainPC <- predict(preObj,training)
testPC <- predict(preObj,testing)
test_finalPC <- predict(preObj,test_final)

library(doMC)
registerDoMC(cores=8)
modelFit <- train(classe~.,method="rf",data=trainPC) # Random Forest with PCA

pred <- predict(modelFit,testPC)
confusionMatrix(pred,testing$classe)

pred_final <- predict(modelFit,test_finalPC)