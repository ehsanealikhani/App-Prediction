
shinyUI(fluidPage(theme = "bootstrap.css",

  title = "Revenue Prediction Model",
  h3("App's Revenue Estimation using Key Metrics",span(   a("( *documentation*)",     href="http://52.10.44.49:3838/help/"), style = "font-family: 'times'; font-si11pt"), align = "center"),
 

fluidRow(
  column(4, align="auto",
    plotOutput('Plot1',height = 260)
   ),
column(4, align="auto",
    plotOutput('Plot2',height = 260)
   ),
column(4, align="auto",
    plotOutput('Plot3',height = 260)
   )
   ),

  #plotOutput('Plot1',height = 250, width = 'auto'),
  #plotOutput('Plot2',height = 250, width = 'auto'),
#  fluidRow(
#column(12, align="center",
#    plotOutput('suggestion',height = 160)
#   )
#   ),




  #plotOutput('Plot3',height = 250, width = 'auto'),
  #tableOutput('suggestion'),

  fluidRow(
    column(2,offset = 0,
      h3("Acquisition"),
      sliderInput("w1install", label = h5("First Week, Ave Daily Install"), min = 50000, max = 200000, value = 120000,step = 500, round = TRUE),
      sliderInput("m1install", label = h5("Week 2-4, Ave Daily Install"), min = 5000, max = 100000, value = 10000,step = 500, round = TRUE),
      sliderInput("y1install", label = h5("Month 2-12 Average Daily Install"), min = 2000, max = 15000, value = 4500,step = 500, round = TRUE)
    ),
    
    column(2,offset = 0,
      h3("Retention"),
     sliderInput("d1reten", label = h5("D1 Retention"), value = 24, min = 0, max = 60,step = 0.1),
    sliderInput("d5reten", label = h5("D5  Retention"), value = 10, min = 0, max = 30,step = 0.1),
    sliderInput("d30reten", label = h5("D30 Retention"), value = 4.3, min = 0, max = 30,step = 0.1)
    ),

    column(2,offset = 0,
      h3("Conversion"),
     sliderInput("d1conversion", label = h5("D1 Conversion"), value = 1.1, min = 0, max = 5,step = 0.1),
  sliderInput("d5conversion", label = h5("D5  Conversion"), value = 1.5, min = 0, max = 10,step = 0.1),
  sliderInput("d30conversion", label = h5("D30 Conversion"), value = 3.9, min = 0, max = 15,step = 0.1)
    ),

  column(2, offset = 0,
      h3("Revenue"),
      sliderInput("d1ltv", label = h5("D1 LTV"), value = 10,step = 2, min = 0, max = 60),
      sliderInput("d5ltv", label = h5("D5  LTV"), value = 20,step = 2, min = 0, max = 60),
      sliderInput("d30ltv", label = h5("D30 LTV"), value = 35,step = 2, min = 0, max = 200)
    ),

column(4, offset = 0,
      h3("*****************************",align="center"),
      plotOutput('suggestion')
    )

  )
))

