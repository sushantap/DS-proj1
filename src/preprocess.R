source('src/removeZeroVariaceFeatures.R');
source('src/getPcaObj.R')
library(caret);
rawdataT <- read.csv('data/dataset-har-PUC-Rio-ugulino 2.csv', sep=';')[1:1000,-1]
rawdata <- as.data.frame(lapply(rawdataT[,-ncol(rawdataT)], as.numeric))
rawdata$class <- rawdataT[,ncol(rawdata)]


# check for near zero variance varibles
nsv <- nearZeroVar(rawdata,saveMetrics=TRUE)
zvf <- rownames(nsv[nsv$zeroVar,])
l <- which(names(rawdata) %in% zvf)
rawdata <- (rawdata[,-l])


inTrain <- createDataPartition(rawdata$class, p=0.8, list=FALSE)
#will be used only for reporting model efficiency
testData <- rawdata[-inTrain, ]

#will use for training and refining algorithm
trainData <- rawdata[inTrain, ]
cvIndex <- createDataPartition(trainData$class, p=0.8, list=FALSE)

#actual training data
traindata <- trainData[cvIndex, ]


#cross validataion data will use to test our model and modify
cvdata <- trainData[-cvIndex, ]

model <- train(class ~ .,
               data=traindata,
               preProcess=c('center', 'scale'))

preds <- predict(model, cvdata)
confusionMatrix(preds, cvdata$class)

#check the importance of varibles
varImp(model)
