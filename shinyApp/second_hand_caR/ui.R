library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Second hand caR"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderAge", label = "Age", min = 0, max = 100, value = c(0,100)),
      sliderInput("sliderHP", label = "Horsepower", min = 10, max = 1000, value = c(10,1000)),
      sliderInput("sliderKM", label = "Kilometers driven", min = 0, max = 150000, value = c(0,150000)),
      checkboxGroupInput("fuelType", label = "Fuel Type", choices = c("Petrol", "Diesel"), selected = "Petrol"),
      checkboxGroupInput("transmissionType", label = "Transmission type", choices = c("Manual", "Automatic"), selected = "Manual"),
      checkboxGroupInput("vehicleType", label = "Vehicle type", choices = c("compact","coupe","cabrio","suv"), selected = "compact")
    ),
    
    mainPanel(
      plotOutput("carPlot"),
      selectInput("graphList", "Select horizontal axis", c("Age","Horsepower","Kilometers"), selected = "Age"),
      h4("Mean price:"),
      textOutput("meanprice"),
      h4("A bit of documentation"),
      p("Second hand caR is a web app that outputs the mean asking price of second hand cars, given a set of boundary conditions. Also, a graph is displayed, containing all datapoints on which the calculation is based plus a linear model fit. The dataset is applicable for Germany, and the price is in euros."),
      p("The app user can set the boundary conditions on the data set by using the sliders (for kilometers driven, horsepower and age) and the checkboxes (on fuel type, transmission type and car body type) on the left panel."),
      p("Furthermore, the app user can set the contents of the horizontal axis of the graph."),
      a(href="https://www.kaggle.com/orgesleka/used-cars-database", "Original data set")
    )
  )
))