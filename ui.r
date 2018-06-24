#ui.r

library(shiny)
options(shiny.sanitize.errors = FALSE)

shinyUI(fluidPage(
  
  titlePanel(title = "TEXT SEARCH ENGINE"),
  sidebarLayout(
    sidebarPanel(("enter query"),
                 textInput("query","enter","")
                 ),
    mainPanel(("top 10 relevent pages"),
              tableOutput("table")
    )
  )
)
)
