
ui <- fluidPage(
        titlePanel("Predicting Prices of Diamonds using ML"),
        sidebarLayout(
                sidebarPanel(
                        h4("Description"),
                        fluidRow(column(12,
                                        "A dataset diamonds containing the prices and 
                                        other attributes of almost 54,000 diamonds."
                        )),
                        br(),
                        h4("Details"),
                        p(em("price: price in US dollars ($326–$18,823)")),
                        p(em("carat: weight of the diamond (0.2–5.01)")),
                        p(em("cut: quality of the cut (Fair, Good, Very Good, Premium, Ideal)")),
                        p(em("colour: diamond colour, from J (worst) to D (best)")),
                        p(em("clarity: a measurement of how clear the diamond is (I1 (worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF (best))")),
                        p(em("x: length in mm (0–10.74)")),
                        p(em("y: width in mm (0–58.9)")),
                        p(em("z: depth in mm (0–31.8)")),
                        p(em("depth: total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43–79)")),
                        p(em("table: width of top of diamond relative to widest point (43–95)")),
                        hr()
                        ),
                mainPanel( 
                        navbarPage(title = "My Application",
                                   tabPanel("Data",
                                            fluidRow(column(4, 
                                                            selectInput("carat", 
                                                                        "Weight of the diamond (carat):", 
                                                                        c("All", 
                                                                          unique(as.character(diamonds$carat))))
                                            ),
                                            column(4, 
                                                   selectInput("cut", 
                                                               "Quality of the cut:", 
                                                               c("All", 
                                                                 unique(as.character(diamonds$cut))))
                                            ),
                                            column(4, 
                                                   selectInput("price", 
                                                               "Price (US dollars):", 
                                                               c("All", 
                                                                 unique(as.character(diamonds$price))))
                                            )),
                                            fluidRow(dataTableOutput(outputId = "table")
                                            )
                                   ), 
                                   tabPanel("Summary Statistics", 
                                            br(),
                                            fluidRow(column(4, 
                                                            p(code("str(diamonds)"))
                                            )),
                                            fluidRow(column(12,
                                                            verbatimTextOutput(outputId = "str")
                                            )),
                                            hr(),
                                            fluidRow(column(12,
                                                            selectInput("col", 
                                                                        "Select a column for summary table", 
                                                                        c(unique(
                                                                                as.character(
                                                                                        names(diamonds)
                                                                                )
                                                                        )
                                                                        ),
                                                                        names(diamonds)[1]
                                                            )
                                            )),
                                            hr(),
                                            fluidRow(column(12,
                                                            verbatimTextOutput(outputId = "summary")
                                            ))
                                   ),
                                   navbarMenu(title = "Models",
                                              tabPanel("LM", 
                                                       h6("Please note: it takes about a minute or so to build a model. Please wait."),
                                                       br(),
                                                       h4("TRAIN THE MODEL"),
                                                       h5("Choose a size of a training dataset (the rest 
                                                          will go the test data):"),
                                                       fluidRow(column(4, 
                                                                       sliderInput("train_lm_in", 
                                                                                   "", 
                                                                                   max = 100, min = 0, value = 60)
                                                       )),
                                                       h5("Dimension of the training dataset (rows x columns):"),
                                                       fluidRow(column(4, 
                                                                       verbatimTextOutput(outputId = "train_lm_out")
                                                       )),
                                                       h5("R-squared:"),
                                                       fluidRow(column(4, 
                                                                       verbatimTextOutput(outputId = "train_lm_R")
                                                       )),
                                                       h5("Predicted vs Actual:"),
                                                       fluidRow(column(12, 
                                                                       plotOutput(outputId = "graph_train")
                                                       )),
                                                       h5("The Model bult on training dataset:"),
                                                       fluidRow(column(12, 
                                                                       verbatimTextOutput(outputId = "train_lm_out_model")
                                                       )),
                                                       hr(),
                                                       h4("TEST THE MODEL"),
                                                       h5("Dimension of the testing dataset (rows x columns):"),
                                                       fluidRow(column(4, 
                                                                       verbatimTextOutput(outputId = "test_lm_out")
                                                       )),
                                                       h5("R-squared:"),
                                                       fluidRow(column(4, 
                                                                       verbatimTextOutput(outputId = "test_lm_R")
                                                       )),
                                                       h5("Predicted vs Actual:"),
                                                       fluidRow(column(12, 
                                                                       plotOutput(outputId = "graph_test")
                                                       ))
                                              )
                                              #                                               ,
                                              #                                               tabPanel("GLM", 
                                              #                                                        "Test here"
                                              #                                               )
                ),
                tabPanel("About", 
                         h4("Developing Data Products - Coursera - Course Project"),
                         p(em("Alexey Pronin")),
                         p(em("09/24/2015")),
                         br(),
                         fluidRow(column(12,
                                         "The goal of this project is to demonstrate the power of Rshiny,
                                         explore the diamonds dataset, and 
                                         offer a ML method to predict the price of a diamond."
                         ))
                         )
                         ) # end of navbarPage
                )
                )
)

