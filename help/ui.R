shinyUI(fluidPage(
  titlePanel(""),
  h1 ("Revenue Prediction for Applications",  align = "center"),
  h1(),
  br(),
  sidebarLayout(
    sidebarPanel(helpText(   a("Launch The App",     href="http://52.10.44.49:3838/revenueapp/")
    ),helpText(   a("GitHub Repository",     href="https://github.com/ehsanealikhani/App-Prediction")
    )),
    mainPanel(

     p ("This is a Shiny web application to estimate the revenue trend, daily active users and average revenue per daily active use (ARPDAU) of a sample mobile game."),
     br(),
     strong("How to use this application? "),
     p("You have to setup the following inputs using sliders:"),
     p(),
     p("1- Average Daily Install for the mobile app over the first week, first month and estimated daily install of the year."),
     p("2-	Retention rate for day 1, day 5 and day 30. What percentage of users come back after 1 day, 5 or 30 days."),
     p("3-	Conversion rate for day 1, day 5 and day 30. What percentage of users has paid by day 1, day 5 and day 30."),
     p("4-	Life Time Value for day 1, day 5 and day 30. On average, how much",span("Paid", style = "color:blue"), "players have paid on day 1, day 5 and day 30."),
     p(),
     p("Done! The app will estimate all values and trends. Also, the app compares you with the similar games in your cluster and provides improvement suggestion. "),
     br(),
     strong("How does it work? "),
     p("Using three provided points, the backend model fits an exponential curve to conversion, lifetime value and retention. The model then estimates daily active users, daily revenue and arpdau of the game based on the provided data."),
     p(),
     p("Suggestions are based on a non-hierarchical k-mean clustering of the game data, combined with a dataset of 100 games data acquired form multiple sources. The clustering model defines the cluster of your game, and provides suggestion comparing with the average of the cluster.")
    )
  )
))
