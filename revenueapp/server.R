shinyServer(function(input, output) {
  

  output$Plot1 <- renderPlot({ 
           dau <- list(rep(0, 365))
           dau <- dau[[1]]
           #######
           d1reten <- input$d1reten
           d5reten <- input$d5reten
           d30reten <- input$d30reten
           w1install <- input$w1install
           m1install <- input$m1install
           y1install <- input$y1install
           install <- c(list(rep(w1install, 7))[[1]], list(rep(m1install, 23))[[1]], list(rep(y1install, 335))[[1]])
          #Retention Data
          xdata = c(1,5,30)
          retendata = c(d1reten,d5reten,d30reten)
          f1 <- function(x, a, b) {
              a * log(x) + b
          }
          fit1 = nls(log(retendata) ~ f1(xdata, a,b), start=list(a=2, b = 1))
          retention <- predict(fit1,newdata=data.frame(xdata = seq(1,365,len=365)))
          retention = exp(1) ^ retention
           #Add to base dau lisr
           for (i in 1:365 ) {
            produced_dau = retention * install[i]/100
            q = 1
            for (j in i:365 ) {
              dau[j] <- dau[j] + produced_dau[q]
              q = q + 1
            }}
           
          x = max(dau[1:365])/1000
          y2 = dau[360]
          y1 = dau[100]


           options("scipen"=100, "digits"=10)
           plot(dau,
            main=paste("Max Daily Active Users = ",toString(format(round(x, 0), nsmall = 0)),'K players', sep = ""),
            ylab="Daily Active users",
            col = c("darkblue"),
            cex.main=1.3,,xlab="Days",type = 'h')
           text(100, 1.2 * y1, paste(toString(format(round(y1, -3), nsmall = 0)),sep = ""), cex=1.2)
           text(340, 1.3 * y2, paste(toString(format(round(y2, -3), nsmall = 0)),sep = ""), cex=1.2,col=c("black"))

     })

  output$downloadData <- downloadHandler(
    filename = function() { 'DAU.csv' },
    content = function(file) {
      dau <- list(rep(0, 365))
           dau <- dau[[1]]
           #######
           d1reten <- input$d1reten
           d5reten <- input$d5reten
           d30reten <- input$d30reten
           w1install <- input$w1install
           m1install <- input$m1install
           y1install <- input$y1install
           install <- c(list(rep(w1install, 7))[[1]], list(rep(m1install, 23))[[1]], list(rep(y1install, 335))[[1]])
          #Retention Data
          xdata = c(1,5,30)
          retendata = c(d1reten,d5reten,d30reten)
          f1 <- function(x, a, b) {
              a * log(x) + b
          }
          fit1 = nls(log(retendata) ~ f1(xdata, a,b), start=list(a=2, b = 1))
          retention <- predict(fit1,newdata=data.frame(xdata = seq(1,365,len=365)))
          retention = exp(1) ^ retention
           #Add to base dau lisr
           for (i in 1:365 ) {
            produced_dau = retention * install[i]/100
            q = 1
            for (j in i:365 ) {
              dau[j] <- dau[j] + produced_dau[q]
              q = q + 1
            }}
      dau = as.integer(dau)
      write.csv(dau, file)
    }
    )


  output$downloadData2 <- downloadHandler(
    filename = function() { 'Revenue_Trend.csv' },
    content = function(file) {
                dailyrevenue <- list(rep(0, 365))
           dailyrevenue <- dailyrevenue[[1]]
           dailypayers <- list(rep(0, 365))
           dailypayers <- dailypayers[[1]]
           d1ltv <- input$d1ltv
           d5ltv <- input$d5ltv
           d30ltv <- input$d30ltv
           #######
           d1conversion <- input$d1conversion
           d5conversion <- input$d5conversion
           d30conversion <- input$d30conversion
           #######
           w1install <- input$w1install
           m1install <- input$m1install
           y1install <- input$y1install
           install <- c(list(rep(w1install, 7))[[1]], list(rep(m1install, 23))[[1]], list(rep(y1install, 335))[[1]])
          #Retention Data
          xdata = c(1,5,30)
          ltvdata = c(d1ltv,d5ltv,d30ltv)
          conversiondata = c(d1conversion,d5conversion,d30conversion)
          #Predicting retention
          f2 <- function(x, a, b) {
              a * x + b
          }
          fit2 = nls(ltvdata ~ f2(log(xdata), a,b), start=list(a=20, b = 50))
          ltv <- predict(fit2,newdata=data.frame(xdata = seq(1,365,len=365)))
          ###
          fit3 = nls(conversiondata ~ f2(log(xdata), a,b), start=list(a=0.5, b = 2))
          conversion <- predict(fit3,newdata=data.frame(xdata = seq(1,365,len=365)))
          ###Comulative
          conv <- list(rep(0, 365))
          conv <- conv[[1]]
          for (i in 2:365 ) {conv[i] <- conversion[i] - conversion[i-1] }
          conv <- c(c(conversion[1]),conv[2:365])
          #
          lt <- list(rep(0, 365))
          lt <- lt[[1]]
          for (i in 2:365 ) {lt[i] <- ltv[i] - ltv[i-1] }
          lt <- c(c(ltv[1]),lt[2:365])


           #Calculate First Time Daily Payers
          for (i in 1:365 ) {
            prodeced_payer = conv * install[i]/100
            q = 1
            for (j in i:365 ) {
              dailypayers[j] <- dailypayers[j] + prodeced_payer[q]
              q = q + 1
            }
          }

          for (i in 1:365 ) {
            produced_revenue = lt * dailypayers[i]
            q = 1
            for (j in i:365 ) {
              dailyrevenue[j] <- dailyrevenue[j] + produced_revenue[q]
              q = q + 1
            }

          }
      dailyrevenue = as.integer(dailyrevenue)
      write.csv(dailyrevenue, file)
    }
    )





  output$Plot2 <- renderPlot({ 
           dailyrevenue <- list(rep(0, 365))
           dailyrevenue <- dailyrevenue[[1]]
           dailypayers <- list(rep(0, 365))
           dailypayers <- dailypayers[[1]]
           d1ltv <- input$d1ltv
           d5ltv <- input$d5ltv
           d30ltv <- input$d30ltv
           #######
           d1conversion <- input$d1conversion
           d5conversion <- input$d5conversion
           d30conversion <- input$d30conversion
           #######
           w1install <- input$w1install
           m1install <- input$m1install
           y1install <- input$y1install
           install <- c(list(rep(w1install, 7))[[1]], list(rep(m1install, 23))[[1]], list(rep(y1install, 335))[[1]])
          #Retention Data
          xdata = c(1,5,30)
          ltvdata = c(d1ltv,d5ltv,d30ltv)
          conversiondata = c(d1conversion,d5conversion,d30conversion)
          #Predicting retention
          f2 <- function(x, a, b) {
              a * x + b
          }
          fit2 = nls(ltvdata ~ f2(log(xdata), a,b), start=list(a=20, b = 50))
          ltv <- predict(fit2,newdata=data.frame(xdata = seq(1,365,len=365)))
          ###
          fit3 = nls(conversiondata ~ f2(log(xdata), a,b), start=list(a=0.5, b = 2))
          conversion <- predict(fit3,newdata=data.frame(xdata = seq(1,365,len=365)))
          ###Comulative
          conv <- list(rep(0, 365))
          conv <- conv[[1]]
          for (i in 2:365 ) {conv[i] <- conversion[i] - conversion[i-1] }
          conv <- c(c(conversion[1]),conv[2:365])
          #
          lt <- list(rep(0, 365))
          lt <- lt[[1]]
          for (i in 2:365 ) {lt[i] <- ltv[i] - ltv[i-1] }
          lt <- c(c(ltv[1]),lt[2:365])


           #Calculate First Time Daily Payers
          for (i in 1:365 ) {
            prodeced_payer = conv * install[i]/100
            q = 1
            for (j in i:365 ) {
              dailypayers[j] <- dailypayers[j] + prodeced_payer[q]
              q = q + 1
            }
          }

          for (i in 1:365 ) {
            produced_revenue = lt * dailypayers[i]
            q = 1
            for (j in i:365 ) {
              dailyrevenue[j] <- dailyrevenue[j] + produced_revenue[q]
              q = q + 1
            }

          }

          x = sum(dailyrevenue[1:365])/1000000
          y1 = dailyrevenue[360]
          y2 = dailyrevenue[100]


           options("scipen"=100, "digits"=10)
           plot(dailyrevenue,
            main=paste("Total Year Revenue = ",toString(format(round(x, 1), nsmall = 1)), 'Million Dollar'),
            ylab="Daily Revenue",
            col=c("purple"),
            cex.main=1.5,,xlab="Days",type = 'h', col.main = "darkred")
           text(340, 2 * y1, paste('$',toString(format(round(y1, -2), nsmall = 0)),sep = ""), cex=1.2)
           text(100, 2 * y2, paste('$',toString(format(round(y2, -2), nsmall = 0)),sep = ""), cex=1.2)


     })

  output$Plot3 <- renderPlot({ 
           dailyrevenue <- list(rep(0, 365))
           dailyrevenue <- dailyrevenue[[1]]
           dailypayers <- list(rep(0, 365))
           dailypayers <- dailypayers[[1]]
           d1ltv <- input$d1ltv
           d5ltv <- input$d5ltv
           d30ltv <- input$d30ltv
           #######
           d1conversion <- input$d1conversion
           d5conversion <- input$d5conversion
           d30conversion <- input$d30conversion
           #######
           w1install <- input$w1install
           m1install <- input$m1install
           y1install <- input$y1install
           install <- c(list(rep(w1install, 7))[[1]], list(rep(m1install, 23))[[1]], list(rep(y1install, 335))[[1]])
           #######
           ########
           ######
           #####
           #####
           dau <- list(rep(0, 365))
           dau <- dau[[1]]
           #######
           d1reten <- input$d1reten
           d5reten <- input$d5reten
           d30reten <- input$d30reten
           w1install <- input$w1install
           m1install <- input$m1install
           y1install <- input$y1install
           install <- c(list(rep(w1install, 7))[[1]], list(rep(m1install, 23))[[1]], list(rep(y1install, 335))[[1]])
          #Retention Data
          xdata = c(1,5,30)
          retendata = c(d1reten,d5reten,d30reten)
          f1 <- function(x, a, b) {
              a * log(x) + b
          }
          fit1 = nls(log(retendata) ~ f1(xdata, a,b), start=list(a=2, b = 1))
          retention <- predict(fit1,newdata=data.frame(xdata = seq(1,365,len=365)))
          retention <- exp(1) ^ retention
           #Add to base dau lisr
           for (i in 1:365 ) {
            produced_dau = retention * install[i]/100
            q = 1
            for (j in i:365 ) {
              dau[j] <- dau[j] + produced_dau[q]
              q = q + 1
            }}
            ######
            ######
            ######
            ######
          #Retention Data
          xdata = c(1,5,30)
          ltvdata = c(d1ltv,d5ltv,d30ltv)
          conversiondata = c(d1conversion,d5conversion,d30conversion)
          #Predicting retention
          f2 <- function(x, a, b) {
              a * x + b
          }
          fit2 = nls(ltvdata ~ f2(log(xdata), a,b), start=list(a=20, b = 50))
          ltv <- predict(fit2,newdata=data.frame(xdata = seq(1,365,len=365)))
          ###
          fit3 = nls(conversiondata ~ f2(log(xdata), a,b), start=list(a=0.5, b = 2))
          conversion <- predict(fit3,newdata=data.frame(xdata = seq(1,365,len=365)))
          ###Comulative
          conv <- list(rep(0, 365))
          conv <- conv[[1]]
          for (i in 2:365 ) {conv[i] <- conversion[i] - conversion[i-1] }
          conv <- c(c(conversion[1]),conv[2:365])
          #
          lt <- list(rep(0, 365))
          lt <- lt[[1]]
          for (i in 2:365 ) {lt[i] <- ltv[i] - ltv[i-1] }
          lt <- c(c(ltv[1]),lt[2:365])


           #Calculate First Time Daily Payers
          for (i in 1:365 ) {
            prodeced_payer = conv * install[i]/100
            q = 1
            for (j in i:365 ) {
              dailypayers[j] <- dailypayers[j] + prodeced_payer[q]
              q = q + 1
            }
          }

          for (i in 1:365 ) {
            produced_revenue = lt * dailypayers[i]
            q = 1
            for (j in i:365 ) {
              dailyrevenue[j] <- dailyrevenue[j] + produced_revenue[q]
              q = q + 1
            }

          }

          ARPDAU <- dailyrevenue/dau
          x = ARPDAU[350]
          x2 = ARPDAU[100]


           options("scipen"=100, "digits"=10)
           plot(ARPDAU,
            main=paste("ARPDAU After a Year = ",paste('$',toString(format(round(x, 2), nsmall = 2))), sep = ""),
            ylab="ARPDAU",
            xlab="Days",
            col=c("black"),
            cex.main=1.3,
            type = 'l', lwd = 4)
           text(340, 1.1 * x, paste('$',toString(format(round(x, 2), nsmall = 2)), sep = ""), cex=1.2)
           text(100, 1.1 * x2, paste('$',toString(format(round(x2, 2), nsmall = 2)), sep = ""), cex=1.2)

     })


  output$suggestion <- renderPlot ({
    a <- read.csv("/var/shiny-server/www/revenueapp/gamedata.csv", header = TRUE, sep = ",", quote = "\"")
    ltv <- input$d30ltv
    install <- input$y1install
    conv <- input$d30conversion
    reten <- input$d1reten
    loc <- nrow(a) + 1
    a <- rbind(a,c(install, ltv, reten, conv))
    clusters <- kmeans(a,4)
    cluster <- as.integer(clusters$cluster[loc])
    means <- data.frame(clusters$centers)
    simila_games <- means[cluster:cluster,]
    simila_games <- rbind(simila_games, c(install, ltv, reten, conv))
    simila_games <- data.frame(t(simila_games))
    simila_games$V3 <- (simila_games[2] - simila_games[1])/simila_games[1]
    final =simila_games[3]
    sorted = final[order(final$V3), , drop = FALSE][1:1,]
    value = sorted[1,1]
    suggest = rownames(sorted)
    if (value < 0)
    out <- paste('Improve \n',suggest,'\n of the Game by \n', paste('%',toString(format(round(-100 * value, 0), nsmall = 0)), sep = ""), sep = "")
    else 
    out <- paste('You Are\n The Best Game\n in your Cluster')
    plot(c(1:5), col=c("white"), ylab="",xlab="",cex.main=1.3, main = 'Tip',xaxt='n', yaxt='n')
    text(3, 3, out, cex=1.8)

    })



})

