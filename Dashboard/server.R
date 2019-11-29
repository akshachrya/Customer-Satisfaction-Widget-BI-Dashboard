library(shiny)
library(shinydashboard)
library(googlesheets)
library(DT)
library(dplyr)
library(ggplot2)







shinyServer(function(input,output,session){
  googlesheets::gs_auth(token = "shiny_app_token.rds")
  sheet_key <- "1KU9v9lca1CkVN5yZ5FcZTIDgEwGLFBBKsDnzIiY5VWg"
  
  data <- googlesheets::gs_key(sheet_key) %>%
    gs_read(ws = "Data", range = cell_rows(1:100)) 


  observeEvent(input$refresh,{
    session$reload()
    
  })
  
  ###Main Dashboard
  
  
  output$TotalSurvey <- renderInfoBox({
    infoBox("Total Number of Survey",count(data),icon = icon("bullhorn"))
  
      
  })
  
  output$TotalMale <- renderInfoBox({
    dat <- data.frame(table(data$Gender))
    colnames(dat) <- c("Gender","Count")
    infoBox("Male Survey",dat$Count[2],icon = icon("male"))
    
  })
  output$TotalFemale <- renderInfoBox({
    dat <- data.frame(table(data$Gender))
    colnames(dat) <- c("Gender","Count")
    infoBox("Female Survey",dat$Count[1],icon = icon("female"))
    
  })
  
  
  output$etnow1 <- renderPlot({
    dat <- data.frame(table(data$`Easy to navigate our website`))
    colnames(dat) <- c("Scale", "Count")
    p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
      geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count), vjust=-0.5, position = position_dodge(width = 1), size = 4)
    p <- p+ labs(x="",y="",title = "Easy to Navigate Website")
    p<- p + theme_bw()+theme(legend.position="bottom")
    p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
    p <- p + theme(axis.text.x=element_blank(),
                   plot.title = element_text(color="black", size=15, face="bold"),
                   axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                   axis.title.y=element_text(colour="grey20", face="bold", size=12))
    p <- p+scale_fill_manual(values=c("Very Difficult"="dark red","Difficult"="red","Regular"="pink","Easy"="green","Very Easy"="dark green"))
    p
    
    
  })
  

  output$agegroup <- renderPlot({
    data$AgeGroup <- data$Age
    data$AgeGroup <-ifelse((data$Age<25),"Below25",data$AgeGroup)
    data$AgeGroup <-ifelse((data$Age>=25 & data$Age<=40),"25-40",data$AgeGroup)
    data$AgeGroup <-ifelse((data$Age>40),"Above 40",data$AgeGroup)
    data$AgeGroup <- as.factor(data$AgeGroup)
    dat <- data.frame(table(data$AgeGroup))
    colnames(dat) <- c("AgeGroup","Frequency")
    p <- ggplot(data=dat,aes(x=AgeGroup,y=Frequency))+geom_bar(width=1,stat="identity",aes(fill=AgeGroup))+ geom_text(aes(label=Frequency),vjust=-0.5, position = position_dodge(width = 1), size = 4)
    p <- p+ labs(x="",y="",title = "Ovearall Survey (Age Group)")
    p<- p + theme_bw()+theme(legend.position="bottom")
    p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
    p <- p + theme(axis.text.x=element_blank(),
                   plot.title = element_text(color="black", size=15, face="bold"),
                   axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                   axis.title.y=element_text(colour="grey20", face="bold", size=12))
    p <- p+scale_fill_manual(values=c("pink", "green", "orange"))
    p
    
  })
  
  output$swtpf1 <- renderPlot({
    dat <- data.frame(table(data$`Satisfy with the product features`))
    colnames(dat) <- c("Scale", "Count")
    p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
      geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4 )
    p <- p+ labs(x="",y="",title = "Satisfy with the Product Features")
    p<- p + theme_bw()+theme(legend.position="bottom")
    p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
    p <- p + theme(axis.text.x=element_blank(),
                   plot.title = element_text(color="black", size=15, face="bold"),
                   axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                   axis.title.y=element_text(colour="grey20", face="bold", size=12))
    p <- p+scale_fill_manual(values=c("No"="dark red","Yes"="dark green","Don't"="pink"))
    p
    
  })
  

 
  
  output$rcoup1 <- renderPlot({
    dat <- data.frame(table(data$`Rate the comfortableness of using the product`))
    colnames(dat) <- c("Scale", "Count")
    p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
      geom_bar(stat = "identity",aes(fill=Scale))+geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
    p <- p+ labs(x="",y="",title = "Rate the comfortableness of using the product")
    p<- p + theme_bw()+theme(legend.position="bottom")
    p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
    p <- p + theme(axis.text.x=element_blank(),
                   plot.title = element_text(color="black", size=15, face="bold"),
                   axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                   axis.title.y=element_text(colour="grey20", face="bold", size=12))
    p <- p+scale_fill_manual(values=c("Highly Uncomfortable"="dark red","Uncomfortable"="red","Neutral"="pink","Comfortable"="green","Highly Comfortable"="dark green"))
    p
  })
  
  output$catfi1 <- renderPlot({
    dat <- data.frame(table(data$`Able to find information you were looking for`))
    colnames(dat) <- c("Scale", "Count")
    p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
      geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
    p <- p+ labs(x="",y="",title = "Customer Able To Find Information")
    p<- p + theme_bw()+theme(legend.position="bottom")
    p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
    p <- p + theme(axis.text.x=element_blank(),
                   plot.title = element_text(color="black", size=15, face="bold"),
                   axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                   axis.title.y=element_text(colour="grey20", face="bold", size=12))
    p <- p+scale_fill_manual(values=c("No"="dark red","Yes"="dark green"))
    p
  })
  
  
  ###Dashboard 1
  
 
 
  
  
  
  ##Dashboard 2
    output$qos <- renderPlot({
      dat <- data.frame(table(data$`Quality of Service`))
      colnames(dat) <- c("Scale", "Count")
      p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
        geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
      p <- p+ labs(x="",y="",title = "Quality of Service")
      p<- p + theme_bw()+theme(legend.position="bottom")
      p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
      p <- p + theme(axis.text.x=element_blank(),
                     plot.title = element_text(color="black", size=15, face="bold"),
                     axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                  
                      axis.title.y=element_text(colour="grey20", face="bold", size=12))
      p <- p+scale_fill_manual(values=c("Very Unsatisfied"="dark red","Unsatisfied"="red","Neutral"="pink","Satisfied"="green","Very Satisfied"="dark green"))
      p 
   })
   


   output$pogpr <- renderPlot({

     dat <- data.frame(table(data$`Process of getting problem resolved`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     # + geom_text(aes(label=Count))
     p <- p+ labs(x="",y="",title = "Process of getting problem resolved")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Unsatisfied"="dark red","Unsatisfied"="red","Neutral"="pink","Satisfied"="green","Very Satisfied"="dark green"))
     p
   })

   output$qocsr <- renderPlot({
     dat <- data.frame(table(data$`Quality of customer service representative`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Quality of Customer Service Representative")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Unsatisfied"="dark red","Unsatisfied"="red","Neutral"="pink","Satisfied"="green","Very Satisfied"="dark green"))
     p

   })

   output$ttbcsrtsmi <- renderPlot({

     dat <- data.frame(table(data$`Time taken by customer service representative to solve my issue`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Time taken by Customer Service Representative To Solve Customer's Issue")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                   
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Unsatisfied"="dark red","Unsatisfied"="red","Neutral"="pink","Satisfied"="green","Very Satisfied"="dark green"))
     p
   })
   
   
   output$posibility <- renderPlot({
     dat <- data.frame(table(data$Posibility))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Posibility")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Unlikely"="dark red","Unlikely"="red","Neutral"="pink","Likely"="green","Very Likely"="dark green"))
     p
   })

   output$kocsr <- renderPlot({
     dat <- data.frame(table(data$`Knowledge of customer service representative`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale, y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Knowledge of Customer Service Representative")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Unsatisfied"="dark red","Unsatisfied"="red","Neutral"="pink","Satisfied"="green","Very Satisfied"="dark green"))
     p
     

   })

   output$wtfmqtba <- renderPlot({
     dat <- data.frame(table(data$`Wait time for my question to be answered`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale, y=Count, group=1)) +
       geom_bar(stat = "identity",aes(fill=Scale))+geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Wait Time for Question to Be Answered")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Unsatisfied"="dark red","Unsatisfied"="red","Neutral"="pink","Satisfied"="green","Very Satisfied"="dark green"))
     p
     
     
   })
  
     

   
   
   ##Dashboard3 (Product Feature)
   output$swtpf <- renderPlot({
     dat <- data.frame(table(data$`Satisfy with the product features`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4 )
     p <- p+ labs(x="",y="",title = "Satisfy with the Product Features")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("No"="dark red","Yes"="dark green","Don't"="pink"))
     p
     
   })
   
   
   
   output$pmu <- renderPlot({
     dat <- data.frame(table(data$`Property Management Usage`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Property Management Users")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("FALSE"="dark red","TRUE"="dark green"))
     p
   })
   
   output$smu <- renderPlot({
     
     dat <- data.frame(table(data$`Security Managment Usage`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Security Management Users")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("FALSE"="dark red","TRUE"="dark green"))
     p
   })
   
   
   output$commu <- renderPlot({
     
     dat <- data.frame(table(data$`Communication Usage`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Communication Users")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("FALSE"="dark red","TRUE"="dark green"))
     p
   })
   
   
   output$opu <- renderPlot({
     
     dat <- data.frame(table(data$`Online Payments Usage`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title ="Online Payment User")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("FALSE"="dark red","TRUE"="dark green"))
     p
   })
   
   output$motlu <- renderPlot({
     dat <- data.frame(table(data$`Management of Tenant lease Usage`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Management of Tenant lease Users")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("FALSE"="dark red","TRUE"="dark green"))
     p
   })
   
   output$sap <- renderDataTable({
     dat <- data.frame(table(data$`Additional products you think should be added in the product`))
     colnames(dat) <- c("Suggested Product","Suggested by")
     dat <- dat[order(-dat$`Suggested by`),]
     })
   
   
   # #####Users
   # output$users1 <- renderDataTable({
   #   pmuusers <- cbind(data$`Full Name`,data$`Property Management Usage`)
   #   colnames(pmuusers) <-c("Full Name","Status")
   #   pmuusers <- pmuusers[which(pmuusers$`Status`=="TRUE")]
   # })
   
   ## Dashboard 4 (Information and User Interface)
   
   output$catfi <- renderPlot({
     dat <- data.frame(table(data$`Able to find information you were looking for`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Customer Able To Find Information")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("No"="dark red","Yes"="dark green"))
     p
   })
   
   output$swltdpas <- renderPlot({
     
     dat <- data.frame(table(data$`Satisfy with the literature to describe our products and services`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Satisfy with Literature to Describe Products & Services")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Unsatisfied"="dark red","Unsatisfied"="red","Neutral"="pink","Satisfied"="green","Very Satisfied"="dark green"))
    p
   })
   
   output$atfiuwlfo <- renderDataTable({
     dat <- cbind(data$`Full Name`,data$`Able to find information you were looking for(Other)`)
     colnames(dat) <-c("Query by","Query")
     dat <- na.omit(dat)
     dat
   })
   
   output$etnow <- renderPlot({
     dat <- data.frame(table(data$`Easy to navigate our website`))
     colnames(dat) <- c("Scale", "Count")
     p <- ggplot(data=dat, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+ geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Easy to Navigate Website")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Difficult"="dark red","Difficult"="red","Regular"="pink","Easy"="green","Very Easy"="dark green"))
     p
 
     
   })
   
   ## Dashboard 4 (Comfort in Using Product )
   output$swdopos <- renderPlot({
     dat2 <- data.frame(table(data$`Satisfy with the delivery of products or services`))
     colnames(dat2) <- c("Scale", "Count")
     p <- ggplot(data=dat2, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Satisfy with Delivery of Products or Services")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Very Unsatisfied"="dark red","Unsatisfied"="red","Neutral"="pink","Satisfied"="green","Very Satisfied"="dark green"))
     p
   })
   
   output$rcoup <- renderPlot({
     dat2 <- data.frame(table(data$`Rate the comfortableness of using the product`))
     colnames(dat2) <- c("Scale", "Count")
     p <- ggplot(data=dat2, aes(x=Scale,y=Count)) +
       geom_bar(stat = "identity",aes(fill=Scale))+geom_text(aes(label=Count),vjust=-0.5, position = position_dodge(width = 1), size = 4)
     p <- p+ labs(x="",y="",title = "Rate the comfortableness of using the product")
     p<- p + theme_bw()+theme(legend.position="bottom")
     p <- p+theme(legend.text=element_text(size=10), legend.title=element_text(size=14))
     p <- p + theme(axis.text.x=element_blank(),
                    plot.title = element_text(color="black", size=15, face="bold"),
                    axis.text.y=element_text(colour="grey20", face="bold", hjust=1, vjust=0.8, size=10),
                    axis.title.y=element_text(colour="grey20", face="bold", size=12))
     p <- p+scale_fill_manual(values=c("Highly Uncomfortable"="dark red","Uncomfortable"="red","Neutral"="pink","Comfortable"="green","Highly Comfortable"="dark green"))
     p
   })
   
   
   ###Dashboard 5 (Interaction Management)
   
   ###Final Dashboard (Survey Data)
   output$mytable =DT::renderDataTable({
     mytable <-data.frame(data)
     colnames(mytable) <-c("Time","Full Name", "Email", "Phone Number", "Gender","Age",
                      "Quality of Service","Process of getting problem resolved",
                      "Quality of customer service representative","Time taken by customer service representative to solve my issue",
                      "Knowledge of customer service representative",
                      "Wait time for my question to be answered","Posibility",
                      "Satisfy with the product features","Property Management Usage",
                      "Security Managment Usage","Communication Usage","Online Payments Usage",
                      "Management of Tenant lease Usage",
                      "Additional products you think should be added in the product",
                      "Able to find information you were looking for",
                      "Able to find information you were looking for(Other)",
                      "Satisfy with the literature to describe our products and services",
                      "Easy to navigate our website",
                      "Satisfy with the delivery of products or services",
                      "Rate the comfortableness of using the product",
                      "Satisfy with the level of customer support we provide",
                      "Satisfy with our company's efforts to meet your communication needs",
                      "Interacting with Phone","Interacting with Email","Interacting with Social Media","Interacting with VOIP Application",
                      "Methods prefer in interacting with the organization(Other)")
     mytable <- datatable(data=mytable,options=list(scrollX=T))
   })
  
   
   #Download Button
   output$download <- downloadHandler(
     
     filename = function(){"name.xlsx"},
     content = function(file)  {
       
       tempFile <- tempfile(fileext = ".xlsx")
       write.xlsx(mytable, tempFile)
       file.rename(tempFile, file)
       
     }
     
   )
   

   
})
