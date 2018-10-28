library(shiny)
library(ggplot2)
library(gridExtra)
library(caret)

shinyUI(fluidPage(
  
  titlePanel("Make Your Own Model"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Purpose of This App"),
      p("This app helps the user build their own model to predict the Miles Per Gallon (MPG) variable in the mtcars dataset. 
         First, select the type of algorithm you would like to use to predict MPG.
         Then, select which variables you would like to include in the model to help predict the MPG outcome.
         Once you click Submit, the app outputs two plots and a calculation to help you assess the accuracy of the model you created."),
      selectInput("modeltype", h3("Type of Algorithm"),
                          choices = list("Linear Regression" = "lm", "Generalized Linear Model" = "glm", "Regression Trees" = "rpart")),
      checkboxGroupInput("predictors", h3("Predictors to Include"),
                         choices = list("Number of Cylinders"= "cyl", "Displacement" = "disp", "Gross Horsepower" = "hp", 
                                        "Rear Axle Ratio" = "drat", "Weight (1000lbs)" = "wt", "Quarter Mile Time" = "qsec", 
                                        "V/S" = "vs", "Transmission (0 = automatic, 1 = manual)" = "am", "Number of Forward Gears" = "gear",
                                        "Number of Carburetors" = "carb"),
                         selected = list("Number of Cylinders"= "cyl", "Displacement" = "disp", "Gross Horsepower" = "hp", 
                                         "Rear Axle Ratio" = "drat", "Weight (1000lbs)" = "wt", "Quarter Mile Time" = "qsec", 
                                         "V/S" = "vs", "Transmission (0 = automatic, 1 = manual)" = "am", "Number of Forward Gears" = "gear",
                                         "Number of Carburetors" = "carb")),
      submitButton("Submit")
    ),
    
    mainPanel(
      h3("Plots to Assess Model Fit"),
      p("The plot on the left is of the predicted MPG values versus the actual MPG values. The red line represents if all of the actual values
         were exactly equal to the predicted ones. So the closer the points are to the red line, the better the fit."),
      p("The plot on the right is that of the residuals. Recall that the residuals are a measure of the difference between 
        the predicted MPG value and the actual MPG value. Here the blue line represents residual of zero. The residuals should be centered 
        on zero for each predicted value, fall in a somewhat symmetrical pattern and constant spread."),
      plotOutput("plot"),
      h3("Root Mean Squared Error (RMSE)"),
      p("The root mean squared error is the standard deviation of the residuals. It indicates the absolute fit of the model to the data, or
         how close the observed data points are to the model's predicted values. The lower the RMSE, the better the fit."),
      p("Here is the RMSE for your model:"),
      textOutput("rsme")

    )
  )
))

