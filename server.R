
source("helpers2.R")
source("helpers3.R")

shinyServer(function(input, output){
        output$densityPlot <- renderPlot({
       
                act <- input$action 
                sigma <- input$sigma
                Number.of.Observation <- input$Number.of.Observation
                L <- reactive({data.gen(Number.of.Observation, alpha = 0.25, beta = 0.125, Number.of.Simulations=100,
                                           sigma=sigma, exp.u=0, sim=act)})
                
                
                type <- reactive({switch(input$select, 
                               "Einzeln" = "einzeln",
                               "Gemeinsam" = "alle")})
                
                select <- input$pick
                
                          
                dichte <- reactive({input$checkbox}) 
                
                calcul(L=L(), alpha = 0.25, beta=0.125, Number.of.Simulations=100,
                       type=type(),dichte=dichte(), select=select)
                
                output$downloadPlot <- downloadHandler(
                    filename = function() { paste("plot", '.jpeg', sep='') },
                    content = function(file) {
                        jpeg(file,width = 1000, height = 600)
                        print(calcul(L=L(), alpha = 0.25, beta=0.125, Number.of.Simulations=100,
                                     type=type(),dichte=dichte(), select=select))
                        dev.off()
                    })
                          
                
        })
})























