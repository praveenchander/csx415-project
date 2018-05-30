Formal Problem Statement - Describes the goal and approach to be followed for the project execution (Assignment 1)
<Available in the main folder and reports>


Model Performance Statement - Calculating the model performance with Random Forest, Gradient Linear Model & Decesion Tree using test data. 
Also, Identifying the Features that has more impact on the outcomes (Assignment 2)
<Available in the main folder and reports>


Data File - bank.csv
<Available in the Data folder, the folder path has to be changed in 2 places
1. server.R in the deploy folder, 2. caretModels_bankMarketing.Rmd in src folder> 


Shiny R Code - 
In order to facilitate end user to key-in record and predict the out come, ui.R & server.R are available.
<server.R - data file path for bank.csv has to be updated after deployment [MANDATORY]>


Final - caretModel Evaluation -
This markdown document will provide the final model Random Forest performance plot and confusion matrix with that of Support Vector Model 
<HTML document is available in the main folder and reports>
<caretModels_bankMarketing.Rmd - data file path for bank.csv has to be updated after deployment [MANDATORY]>


Package -
Developed a package called splittingData, this is used to genetrate random test data with 30 Percent of the original training data available
<Available in the lib folder - this has to be installed using the DEV tools wherever the program is being deployed[MANDATORY]>


Deployed Application - Bank Marketing Application deployed to Shinny cloud for prediction - https://praveentestapps.shinyapps.io/bankMarketing/
