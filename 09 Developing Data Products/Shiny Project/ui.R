library(shiny)

# Define UI for application that plots standard normal density function and reports probability

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Standard Normal Density"),
  
  # Sidebar with a slider input for 
  sidebarPanel(
    p("This shiny app computes probability for a standard normal distribution."),
    p("To use this app user should choose a score by sliding the slide, and choose wheter you want a lower tail probability or a upper tail probability using the dropdown."),
    h3('Please choose score'),
    sliderInput("score", 
                "It could only be between -4 and 4:", 
                min = -4,
                max = 4, 
                value = 0,
                step = 0.01),
    h3('Please choose lower tail or upper tail'),
   
    selectInput("lo",
                " ", 
                choices = c("lower", "upper"),
                selected = "lower"
                )
    ),
        
  # show a normal distribution with score indicated as a red vertical line
  mainPanel(
    plotOutput("distPlot"),
    h3("The associated probability is"),
    verbatimTextOutput("pvalue")
    )
  ))
