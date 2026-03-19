# Title: Old Faithful Geyser Explorer
# Description: Visualizes the Old Faithful geyser dataset with a ggplot histogram,
#              allowing users to select the variable and number of bins.
# Author: STAT 133
# Date: Spring 2025


# ===============================================
# Packages
# ===============================================
library(shiny)
library(tidyverse)

# Define UI
ui <- fluidPage(

    titlePanel("Old Faithful Geyser Explorer"),

    sidebarLayout(
        sidebarPanel(
            selectInput("variable",
                        "Variable to display:",
                        choices = c("Waiting Time" = "waiting",
                                    "Eruption Time" = "eruptions")),
            sliderInput("num_bins",
                        "Number of bins:",
                        min = 5,
                        max = 60,
                        value = 30),
        ),

        mainPanel(
            plotOutput("histPlot")
        )
    )
)

# Define server logic
server <- function(input, output) {

    output$histPlot <- renderPlot({
        
        x_label <- if (input$variable == "waiting") "Waiting Time (minutes)" else "Eruption Time (minutes)"
        
        faithful |>
            ggplot(aes(x = .data[[input$variable]])) +
            geom_histogram(bins = input$num_bins, fill = "steelblue", color = "white") +
            theme_minimal() +
            labs(x = x_label,
                 y = "Count",
                 title = paste("Distribution of", x_label))
    })
}

# Run the application
shinyApp(ui = ui, server = server)