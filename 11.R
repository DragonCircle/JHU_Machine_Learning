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

library(doMC)
registerDoMC(cores=8)
modelFit <- train(classe~.,method="rf",data=training) # Random Forest without PCA

pred <- predict(modelFit,testing)
confusionMatrix(pred,testing$classe)#0.9935 Accuracy
'Confusion Matrix and Statistics

Reference
Prediction    A    B    C    D    E
A 1394    4    0    0    0
B    1  943    3    0    0
C    0    2  845   11    1
D    0    0    7  793    3
E    0    0    0    0  897

Overall Statistics

Accuracy : 0.9935          
95% CI : (0.9908, 0.9955)
No Information Rate : 0.2845          
P-Value [Acc > NIR] : < 2.2e-16       

Kappa : 0.9917          
Mcnemars Test P-Value : NA              

Statistics by Class:

Class: A Class: B Class: C Class: D Class: E
Sensitivity            0.9993   0.9937   0.9883   0.9863   0.9956
Specificity            0.9989   0.9990   0.9965   0.9976   1.0000
Pos Pred Value         0.9971   0.9958   0.9837   0.9875   1.0000
Neg Pred Value         0.9997   0.9985   0.9975   0.9973   0.9990
Prevalence             0.2845   0.1935   0.1743   0.1639   0.1837
Detection Rate         0.2843   0.1923   0.1723   0.1617   0.1829
Detection Prevalence   0.2851   0.1931   0.1752   0.1637   0.1829
Balanced Accuracy      0.9991   0.9963   0.9924   0.9919   0.9978'
pred_final <- predict(modelFit,test_final)