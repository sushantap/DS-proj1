getPcaObj <- function(data, var){
    preProc <- preProcess(data,method="pca",tol=var)
}

