#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(later)
library(promises)

fluidPage(
  sliderInput(inputId = "age", label = "Enter the Age", min = 0, max = 100, value = 24),
  selectInput(inputId = "job", label = "Chooce a Job", choices = list("management", "blue-collar", "services", "technician", "entrepreneur", "unemployed", "self-employed", "unknown", "retired", "admin", "student", "housemaid"), multiple = FALSE),
  selectInput(inputId = "marital", label = "Select Marital Status", choices = list("single", "married", "divorced"), multiple = FALSE),
  selectInput(inputId = "education", label = "Select Education", choices = list("primary", "secondary", "tertiary", "unknown"), multiple = FALSE),
  selectInput(inputId = "default", label = "Was there any default ?", choices = list("yes", "no"), multiple = FALSE),
  numericInput(inputId = "balance", label = "Enter Bank Balance", value = 0),
  selectInput(inputId = "housing", label = "Housing ?", choices = list("yes", "no"), multiple = FALSE),
  selectInput(inputId = "loan", label = "Any Loan ?", choices = list("yes", "no"), multiple = FALSE),
  selectInput(inputId = "contact", label = "Contact mode", choices = list("cellular", "telephone", "unknown"), multiple = FALSE),
  numericInput(inputId = "day", label = "Enter the day of the month", value = 1),
  selectInput(inputId = "month", label = "Select Month", choices = list("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"), multiple = FALSE),
  numericInput(inputId = "duration", label = "Enter the duration", value = 1),
  numericInput(inputId = "campaign", label = "Campaign days", value = 1),
  numericInput(inputId = "pdays", label = "Enter the Pdays", value = -1),
  numericInput(inputId = "previous", label = "Enter Previous contact days", value = 1),
  selectInput(inputId = "poutcome", label = "Previous Outcome ?", choices = list("success", "failure", "other", "unknown"), multiple = FALSE),
  actionButton(inputId = "click", label = "Predict using Random Forest"),
  plotOutput("graphRF"),
  plotOutput("confusionRF"),
  dataTableOutput("testRec"),
  textOutput("predictionRF"),
  dataTableOutput("testPrediction"),

  actionButton(inputId = "click2", label = "Predict using Support Vector Machine"),
  plotOutput("graphSVM"),
  plotOutput("confusionSVM"),
  dataTableOutput("testRecSVM"),
  textOutput("predictionSVM"),
  dataTableOutput("testPredictionSVM")

)
