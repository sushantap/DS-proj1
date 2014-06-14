metric <- function(model, traindata, testdata){
    model <- train(class ~ ., method=model, data=traindata)
    preds <- predict(model, testdata)
    cm <- confusionMatrix(preds, testdata$class)
    cm$overall
}