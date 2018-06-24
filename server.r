#server.r

library(shiny)
library(proxy)
library(tm)
library(XML)
library(SnowballC)

source("tse.r")

shinyServer(
  function(input,output){
    
    output$table<-renderTable({
      tse(input$query)
    })
  }
)