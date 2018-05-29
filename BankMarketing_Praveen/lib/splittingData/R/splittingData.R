#' Function to split data into Train and Test
#' @title Splits an object(data frame) with training(70%) and testing data(30%)
#' @param The actual File in data frame type
#' @return Train and Test Data set
#' @export


library("caret")
library("ModelMetrics")
library("ddalpha")
library('DEoptimR')
library('dimRed')
library('gower')
library('prodlim')
splitFile <- function(x) {
  set.seed(100) #can provide any number for seed
  nall = nrow(x) #total number of rows in data
  print(nall)

  ntrain = floor(0.70 * nall) # number of rows for train,70%
  print(ntrain)

  ntest = floor(0.30* nall) # number of rows for test, 30%
  index = seq(1:nall)
  print(index)

  trainIndex = sample(index, ntrain) #train data set
  train = bank_data[trainIndex,]

  testIndex = index[-trainIndex]
  test = bank_data[testIndex,]
  return(test)

}
