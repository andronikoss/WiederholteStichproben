source("helpers1.R")
source("helpers2.R")

shinyServer(function(input, output){
        output$densityPlot <- renderPlot({
       
                act <- input$action 
                sigma <- input$sigma
                Number.of.Observation <- input$Number.of.Observation
                L <- reactive({data.gen(Number.of.Observation, alpha = 0.2,
                                        beta = 0.13, Number.of.Simulations = 100,
                                           sigma = sigma, exp.u = 0, sim = act)})
                
                
                type <- reactive({switch(input$select, 
                               "Einzeln" = "einzeln",
                               "Gemeinsam" = "alle")})
                
                select <- input$pick
                
#                 # Zeitangabe
#                 output$time <- renderPrint({
#                   t <- gsub("-", ".",Sys.time() )
#                   t <- gsub(" ", ", ", t) 
#                   cat("Stand:", t)
#                 })
                          
                dichte <- reactive({input$checkbox}) 
                
                calcul(L = L(), alpha = 0.2, beta = 0.13, Number.of.Simulations = 100,
                       type = type(),dichte = dichte(), select = select)
                
                output$downloadPlot <- downloadHandler(
                    filename = function() { paste("plot", '.jpeg', sep = '') },
                    content = function(file) {
                        jpeg(file,width = 1000, height = 600)
                        print(calcul(L = L(), alpha = 0.2, beta = 0.13,
                                     Number.of.Simulations = 100,
                                     type = type(), dichte = dichte(),
                                     select = select))
                        dev.off()
                    })
                          
                
        })
})























