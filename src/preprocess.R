source('src/removeZeroVariaceFeatures.R');
source('src/getPcaObj.R')
source('src/sample.R')
source('src/metric.R')
library(caret);
rawdataT <- read.csv('data/dd.csv')
samples <- mysample(rawdataT)
sampledData <- rawdataT[samples, ]

#rawdata <- as.data.frame(lapply(sampledData[,-ncol(rawdataT)], as.numeric))
#rawdata$class <- sampledData[,ncol(rawdata)]
rawdata <- sampledData

# check for near zero variance varibles
nsv <- nearZeroVar(rawdata,saveMetrics=TRUE)
zvf <- rownames(nsv[nsv$zeroVar,])
l <- which(names(rawdata) %in% zvf)
if(length(l) != 0){
    rawdata <- (rawdata[,-l])    
}

inTrain <- createDataPartition(rawdata$class, p=0.8, list=FALSE)
#will be used only for reporting model efficiency
testData <- rawdata[-inTrain, ]

#will use for training and refining algorithm
trainData <- rawdata[inTrain, ]
cvIndex <- createDataPartition(trainData$class, p=0.01, list=FALSE)

#actual training data
traindata <- trainData[cvIndex, ]


#cross validataion data will use to test our model and modify
cvdata <- trainData[-cvIndex, ]

models <- c('rpart', 'knn', 'nnet')
a <- sapply(models, metric, rawdata, cvdata)
barplot(a[1,], ylab='accuracy', xlab='model type')

#check the importance of varibles
varImp(model)
