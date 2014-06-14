source('src/removeZeroVariaceFeatures.R');
library(caret); data(iris);
iris <- iris[,-2]
inTrain <- createDataPartition(iris$Species, p=0.8, list=FALSE)
#will be used only for reporting model efficiency
testData <- iris[-inTrain, ]

#will use for training and refining algorithm
trainData <- iris[inTrain, ]
cvIndex <- createDataPartition(iris$Species, p=0.8, list=FALSE)

#actual training data
traindata <- trainData[cvIndex, ]

#cross validataion data will use to test our model and modify
cvdata <- trainData[-cvIndex, ]

model <- train(Species ~ .,
               data=traindata, 
               preProcess=c('center', 'scale'))

preds <- predict(model, cvdata)
confusionMatrix(preds, cvdata$Species)

varImp(model)



