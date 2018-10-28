library(shiny)
library(ggplot2)
library(gridExtra)
library(caret)

shinyServer(function(input, output) {
  
  set.seed(1234)
  inTrain <- createDataPartition(y = mtcars$mpg, p = 0.7, list = FALSE)
  training <- mtcars[inTrain,]
  testing <- mtcars[-inTrain,]
  
  model <- reactive({
    modelInput <- toString(input$modeltype)
    train(as.formula(paste("mpg ~ ",paste0(input$predictors,collapse="+"))), data = training, method = modelInput)
  })
  
  pred <- reactive({
    predict(model(), testing)
  })

  output$plot <- renderPlot({
    validate(
      need(input$predictors, 'Check at least one predictor!')
    )
    res <- testing$mpg - pred()
    p1 <- ggplot(data = testing, aes(x = pred(), y = mpg), pch = 16) +  
          geom_point() + 
          labs(title = "Predicted vs Actuals MPG Values", x = "Predicted", y = "Actual") + 
          geom_abline(intercept = 0, slope = 1, col = "red") + 
          scale_y_continuous(limit = c(5, 40)) + scale_x_continuous(limit = c(5, 40))
    p2 <- ggplot(data = testing, aes(x = pred(), y = res), pch = 16) +
          geom_point() + 
          labs(title = "Predicted Values vs Residuals", x = "Predicted", y = "Residuals") +
          geom_abline(intercept = 0, slope = 0, col = "blue") + 
          scale_y_continuous(limit = c(-4, 4)) + scale_x_continuous(limit = c(5, 40))
          
    grid.arrange(p1, p2, ncol = 2)
  })


  output$rsme <- renderText({
    validate(
      need(input$predictors, 'Check at least one predictor!')
    )
    res <- testing$mpg - pred()
    sqrt(mean(res*res))
  })

})


