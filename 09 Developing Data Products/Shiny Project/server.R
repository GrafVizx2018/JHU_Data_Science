library(shiny)

# Define server logic required to plot
# 1 a normal distribution
# 2 a vertical line indicate the score
# Define server logic required to report a p value

shinyServer(
  function(input,output){
    
    
    output$distPlot <- renderPlot({
    # generate an rnorm distribution and plot it
      x <- seq(-4,4,by = 0.01)
      y <- dnorm(x,mean=mean(x),sd=sd(x)) 
      xl <- rep(input$score,301)
      yl <- seq(0,0.3,by = 0.001)
      plot(x, y, type = "l",col="black", lwd=2,ylab = "Pr(X=x)")
      lines(xl,yl,col="red",lwd=2)
    })
    
    lower <- reactive({
      switch(input$lo,
             "lower" = T,
             "upper" = F)
    })
    
    output$pvalue <- renderPrint({
      pnorm(input$score, 0,1, lower.tail = lower())
    })
    }
  )