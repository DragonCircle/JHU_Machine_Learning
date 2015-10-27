data <- read.csv("pml-training.csv")

training <- read.csv("pml-training.csv")
testing <- read.csv("pml-testing.csv")
nsv <- nearZeroVar(training)
names(training)[nsv]
training2 <- training[,-nsv]
training3 <- training2[,c(-1,-3,-4,-5,-6)]
training4 <- training3[,colSums(is.na(training3))==0]
testing2 <- testing[,-nsv]
testing3 <- testing2[,c(-1,-3,-4,-5,-6)]
testing4 <- testing3[,colSums(is.na(testing3))==0]
library(caret)
#modFit <- train(classe~.,method="rf",data=training4)
#trainP <- predict(modFit,training4)
#predict(modFit,testing4)
#confusionMatrix(trainP,training4$classe)
  
  