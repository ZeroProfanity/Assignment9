library(shiny)
library(ggplot2)
df.input <- read.csv("./tidy.csv")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  df.plot <- reactive({
    fuelType <- ifelse(input$fuelType=="Petrol","benzin","diesel")
    transmissionType <- ifelse(input$transmissionType=="Manual", "manuell", "automatik")
    df.temp <- df.input[(df.input$age >= input$sliderAge[1]) & (df.input$age <= input$sliderAge[2]),]
    df.temp <- df.temp[(df.temp$powerPS >= input$sliderHP[1]) & (df.temp$powerPS <= input$sliderHP[2]),]
    df.temp <- df.temp[(df.temp$kilometer >= input$sliderKM[1]) & (df.temp$kilometer <= input$sliderKM[2]),]
    df.temp <- df.temp[(df.temp$fuelType %in% fuelType),]
    df.temp <- df.temp[(df.temp$gearbox %in% transmissionType),]
    df.temp <- df.temp[(df.temp$vehicleType %in% input$vehicleType),]
    df.temp
  })
  
  output$meanprice <- renderText({
    round(mean(df.plot()$price),0)
    })
  
  output$carPlot <- renderPlot({
    if(input$graphList == "Age"){
      #plot(price ~ age, data = df.plot(), xlim = c(0,60), ylim = c(0,100000))
      g <- ggplot(aes(y=price, x=age), data = df.plot()) + 
           geom_point(alpha = 0.4, aes(color = vehicleType, shape = fuelType), size = 2) +
           geom_smooth(method = "lm") +
           coord_cartesian(xlim = c(0, 60), ylim = c(0,30000)) + 
           ggtitle("Vehicle prices")
      #qplot(x = age, y = price, data = df.plot(), geom = "point")
    }
    if(input$graphList == "Kilometers"){
      #plot(price ~ kilometer, data = df.plot(), xlim = c(0,150000), ylim = c(0,100000))
      g <- ggplot(aes(y=price, x=kilometer), data = df.plot()) + 
           geom_point(alpha = 0.4, aes(color = vehicleType, shape = fuelType), size = 2) +
           geom_smooth(method = "lm") +
           coord_cartesian(xlim = c(0, 150000), ylim = c(0,30000))  + 
           ggtitle("Vehicle prices")
    }
    if(input$graphList == "Horsepower"){
      g <- ggplot(aes(y=price, x=powerPS), data = df.plot()) +
           geom_point(alpha = 0.4, aes(color = vehicleType, shape = fuelType), size = 2) +
           geom_smooth(method = "lm") +
           coord_cartesian(xlim = c(0, 1000), ylim = c(0,30000))  + 
           ggtitle("Vehicle prices")
    }
    g
  })
  
})
