
server <- function(input, output) {
        
        train_rct <- reactive({
                data <- diamonds
                set.seed(123)
                part <- createDataPartition(data$price, p = (input$train_lm_in)/100, list=FALSE)                
                train <- data[part,]
                return(train)
        })
        
        test_rct <- reactive({
                data <- diamonds
                set.seed(123)
                part <- createDataPartition(data$price, p = (input$train_lm_in)/100, list=FALSE)                
                test <- data[-part,]
                return(test)
        })
        
        output$summary <- renderPrint({
                summary(diamonds[,input$col])
        })
        
        output$train_lm_R <- renderPrint({
                train <- train_rct()
                fit <- train(price ~., data = train, method = "lm")
                summary(fit)$r.squared
        })
        
        output$test_lm_R <- renderPrint({
                train <- train_rct()
                test <- test_rct()
                fit <- train(price ~., data = train, method = "lm")
                pred <- predict(fit, test)
                df <- data.frame(obs = test$price, pred = pred) 
                defaultSummary(df)[[2]]
        })
        
        output$train_lm_out <- renderPrint({
                train <- train_rct()
                dim(train)
        })
        
        output$train_lm_out_model <- renderPrint({
                train <- train_rct()
                dim(train)
                fit <- train(price ~., data = train, method = "lm")
                summary(fit)
        })
        
        output$test_lm_out <- renderPrint({
                test <- test_rct()
                dim(test)
        })
        
        output$str <- renderPrint({
                str(diamonds)
        })
        
        output$table <- renderDataTable({
                data <- diamonds
                if (input$carat != "All"){
                        data <- data[data$carat == input$carat,]
                }
                if (input$cut != "All"){
                        data <- data[data$cut == input$cut,]
                }
                if (input$price != "All"){
                        data <- data[data$price == input$price,]
                }
                data
        })
        
        output$graph_train <- renderPlot({
                train <- train_rct()
                fit <- train(price ~., data = train, method = "lm")
                pred <- predict(fit, train)
                df <- data.frame(Actual = train$price, Predicted = pred) 
                p <- ggplot(df, aes(x = Predicted, y = Actual)) +
                        geom_point() +
                        geom_line(data = data.frame(Predicted = c(0,20000), Actual = c(0,20000)),
                                  aes = aes(x = Predicted, y = Actual), colour = "red")
                p
        })
        
        output$graph_test <- renderPlot({
                train <- train_rct()
                test <- test_rct()
                fit <- train(price ~., data = train, method = "lm")
                pred <- predict(fit, test)
                df <- data.frame(Actual = test$price, Predicted = pred) 
                p <- ggplot(df, aes(x = Predicted, y = Actual)) +
                        geom_point() +
                        geom_line(data = data.frame(Predicted = c(0,20000), Actual = c(0,20000)),
                                  aes = aes(x = Predicted, y = Actual), colour = "red")
                p
        })
}

