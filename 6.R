# For Quiz 3 Question 4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
set.seed(13234)

library(caret)
modFit <- train(chd~age+alcohol+obesity+tobacco+typea+ldl,method="glm",family="binomial",data=trainSA)
testP <- predict(modFit,testSA)
trainP <- predict(modFit,trainSA)
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

print("misclassfication rate fo Test data is :")
print(missClass(testSA$chd,testP))
print("misclassfication rate fo Train data is :")
print(missClass(trainSA$chd,trainP))