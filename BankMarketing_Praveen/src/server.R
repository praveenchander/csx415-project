library(shiny)
library("caret")
library("ModelMetrics")
library("ddalpha")
library('DEoptimR')
library('dimRed')
library('gower')
library('prodlim')

function(input, output, session) {
  ## To make sure our JS-created textInput works:
  #output$txt2Test <- renderText({ input$txt2 })
  bank_data<-read.csv('C:\\Users\\PraveenChander\\Desktop\\pySparking\\Class 2 - Data Science Principles and Practice\\practice\\bank-sample.csv',header = T,sep = ';')

  set.seed(100) #can provide any number for seed
  nall = nrow(bank_data) #total number of rows in data

  ntrain = floor(0.70 * nall) # number of rows for train,70%
  print(ntrain)

  ntest = floor(0.30* nall) # number of rows for test, 30%
  index = seq(1:nall)
  print(index)

  trainIndex = sample(index, ntrain) #train data set
  train = bank_data[trainIndex,]

  testIndex = index[-trainIndex]
  test = bank_data[testIndex,]

  fit_rf_mod<-train(y ~ age + job + marital + education + default + balance + housing + loan + contact + day + month + duration + campaign + pdays + previous + poutcome,data=train,method="rf", trControl=trainControl(method="cv",number=5), prox=TRUE,allowParallel=TRUE)

  print(fit_rf_mod)
  output$graphRF <- renderPlot({
    title <- "Plot for Random Forest"
    plot((fit_rf_mod), main = title)
  })

  predictions_rf <- predict(object=fit_rf_mod, test)
  print(predictions_rf)
  confusionRF <- confusionMatrix(predictions_rf, test$y)
  ctable_rf <- as.table(matrix(c(confusionRF), nrow = 2, byrow = TRUE))

  fourfoldplot(ctable_rf, color = c("#CC6666", "#99CC99"),
               conf.level = 0, margin = 1, main = "Confusion Matrix")

  output$confusionRF <- renderPlot({
    title <- "Confusion Matrix for Random Forest"
    fourfoldplot(ctable_rf, color = c("#CC6666", "#99CC99"),
                 conf.level = 0, margin = 1, main = "Confusion Matrix for Random Forest")
  })

  # SVM Model

  fitControl <- trainControl(method = "repeatedcv",
                             number = 10,
                             repeats = 10,
                             ## Estimate class probabilities
                             classProbs = TRUE,
                             ## Evaluate performance using
                             ## the following function
                             summaryFunction = twoClassSummary)
  set.seed(825)
  svmFit <- train(y ~ age + job + marital + education + default + balance + housing + loan + contact + day + month + duration + campaign + pdays + previous + poutcome, data = train,
                  method = "svmRadial",
                  trControl = fitControl,
                  preProc = c("center", "scale"),
                  tuneLength = 8,
                  metric = "ROC")
  svmFit
  output$graphSVM <- renderPlot({
    title <- "Plot for Support Vector Machine"
    plot((svmFit), main = title)
  })

  # Prediction for SVM
  predictions_svm <- predict(object=svmFit, test)
  print(predictions_svm)

  # Confusion Matrix for SVM
  confusionSVM <- confusionMatrix(predictions_svm, test$y)
  ctable_svm <- as.table(matrix(c(confusionSVM), nrow = 2, byrow = TRUE))

  output$confusionSVM <- renderPlot({
    title <- "Confusion Matrix for Random Forest"
    fourfoldplot(ctable_svm, color = c("#CC6666", "#99CC99"),
                 conf.level = 0, margin = 1, main = "Confusion Matrix for Support Vector Machine")
  })

  test_rec = data.frame()
  output$testRec <- renderDataTable({
  test_rec <- data.frame(
    age = c (input$age),
    job = c(input$job),
    marital = c(input$marital),
    education = c(input$education),
    default = c(input$default),
    balance = c(input$balance),
    housing = c(input$housing),
    loan = c(input$loan),
    contact = c(input$contact),
    day = c(input$day),
    month = c(input$month),
    duration = c(input$duration),
    campaign = c(input$campaign),
    pdays = c(input$pdays),
    previous = c(input$previous),
    poutcome = c(input$poutcome),
    stringsAsFactors = FALSE
  )
  print(test_rec)

  observeEvent(input$click, {
    predictions_rf2 <- predict(object=fit_rf_mod, test_rec)
    print(predictions_rf2)
    if (tail(predictions_rf2, n=1) == "no") {X="RF: Not a Potential Customer"} else {X="RF: Potential Customer"}
    output$predictionRF <- renderText({X})
    }, ignoreInit = TRUE, once = TRUE)

  observeEvent(input$click2, {
    predictions_svm2 <- predict(object=svmFit, test_rec)
    print(predictions_svm2)
    if (tail(predictions_svm2, n=1) == "no") {X="SVM: Not a Potential Customer"} else {X="SVM: Potential Customer"}
    output$predictionSVM <- renderText({X})
  }, ignoreInit = TRUE, once = TRUE)

})

}
