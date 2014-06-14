removeZeroVarianceFeatures <- function(data){
    nsv <- nearZeroVar(data,saveMetrics=TRUE)
    zvf <- rownames(nsv[nsv$zeroVar,])
    l <- which(names(data) %in% zvf)
    data[,-l]
}