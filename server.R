library(shiny)
library(xtable)
# Load data ----
mdata<-read.csv("ddprod-pr.csv", header=TRUE)
mdata[,1]<-as.character(mdata[,1])  # preprocess data

hdi <- function(countryNow, countryFuture, gender) { 
        
        my.now<-mdata[grep(countryNow,mdata$country),]
        my.fut<-mdata[grep(countryFuture,mdata$country),]
        country.n<-my.now[,1]
        country.f<-my.fut[,1]
        
        m<-c(2,3,5,6,8,10,11,12,13,14,15,16)   # remove country name
        f<-c(2,3,4,6,7,9,11,12,13,14,15,16)
        
        if(gender=="Male"){                      
                data.now<-my.now[,m] 
                data.fut<-my.fut[,m] 
                
        } else {
                data.now<-my.now[,f]
                data.fut<-my.fut[,f] 
        }
        
        names(data.now)[3] <- "hdi"
        names(data.fut)[3] <- "hdi"
        names(data.now)[5] <- "le"
        names(data.fut)[5] <- "le"
        names(data.now)[6] <- "gni"
        names(data.fut)[6] <- "gni"
        
        data.result<-data.now-data.fut
#        data.result$hdi.gii<-data.result$hdi.gii*-1
        data.result$hdi<-data.result$hdi*-1
        data.result$hdi.r<-data.result$hdi.r*-1
        data.result$le<-data.result$le*-1
        data.result$gni<-data.result$gni*-1
        data.result$sat<-data.result$sat*-1
        data.result$free<-data.result$free*-1
        data.result$trust<-data.result$trust*-1
        
        give.result<-data.result
        yy<-(data.result/data.now)*100
        data.result[,2:6]<-yy[,2:6] # convert all to percentages
        data.result[,8]<-yy[,8]
        data.result<-round(data.result,1)
        
        for (i in 1:12)
        {
                if (give.result[i]<0) {give.result[i] = "Worse"}
                else{give.result[i] ="BETTER!"}
        }            
        
        
        youresult<-rbind(data.result,give.result)      
        
        
        if (countryNow==countryFuture) {
                ymessage <- "Sorry , You do not seem to be relocation outside of your current country"
        } else {
                ymessage <- "Here is what awaits you: "
        } 
        
        
        return(youresult)
        
}


shinyServer( 
       
        function(input, output) { 
                
                
                
                
                
                output$ocountryn <- renderPrint({input$countryNow})
                output$ocountryf <- renderPrint({input$countryFuture})
                output$ogender <- renderPrint({input$gender}) 
                
                output$ohdi1 <- renderPrint({hdi(input$countryNow, input$countryFuture, input$gender)}[24])
                output$ohdi2<-renderTable({hdi(input$countryNow, input$countryFuture, input$gender)}[,2:12])
                output$rank<-renderPrint({hdi(input$countryNow, input$countryFuture, input$gender)[,1]})
                output$myPlot <- renderPlot({
                        
                        x<-as.numeric({hdi(input$countryNow, input$countryFuture, input$gender)}[1,])
                        colo <- c("red", "green")[(x>0)+1]
                        colo1<-colo[2:12]
                                                
                        barplot(as.numeric({hdi(input$countryNow, input$countryFuture, input$gender)}[1,2:12]),
                                col=colo1,names=c("A","B","C","D","E","F","G","H","I","J","K"),
                                ylab="% Change",xlab="Indicators")
                        
                        })
    
                
        } 
) 
