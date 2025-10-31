#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(datasets)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Chick Weights"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         # add sidebar elements here  
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("chickPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$chickPlot <- renderPlot({
     # add code to generate the plot here
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

