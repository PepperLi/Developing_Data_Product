library(shiny)
library(ggplot2)
library(knitr)

shinyServer(function(input, output){
    
    dataset <- mtcars
    
    output$plot <- reactivePlot(function() {
        
        p <- ggplot(dataset, aes_string(x=input$x, y=input$y)) + geom_point()
        
        if(input$color != 'None')
            p <- p + aes_string(color=input$color)
        
        facets <- paste(input$facet_row, '~', input$facet_col)
        #facets <- input$facet_row
        if(facets != '. ~ .')
            p <- p + facet_grid(facets)
        
        if(input$jitter)
            p <- p + geom_jitter()
        if(input$smooth)
            p <- p + geom_smooth()
        
        print(p)
        
    }, height=500)
    
    #output$table <- renderPrint(head(dataset))
    
})