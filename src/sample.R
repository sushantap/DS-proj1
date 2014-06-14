mysample <- function(data){
    filter <- c()
    catogories <- unique(rawdataT$class)
    for(cat in catogories){
        indexes <- which(rawdataT$class == cat)[1:10]
        filter <- c(filter, indexes)
    }
    filter
}