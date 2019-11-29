library("shiny")
library("googlesheets")
library("DT")
library("shinythemes")
library("shinyalert")


shinyUI(
  fluidPage(theme=shinytheme("united"),
    headerPanel(title=""),
    sidebarLayout(
      sidebarPanel(
        tabsetPanel(type="tabs",id="inTabset",
                    tabPanel("Introduction",value="panel1",br(),
                             textInput("fullname","Full Name",placeholder = "Input your fullname"),
                             textInput("email","Email Address",placeholder = "Input a valid E-mail address"),
                             textInput("phno","Cell Number(10 digits)",placeholder = "Input a 10-digit-number"),
                             radioButtons("gender","Gender",choices=c("Male","Female"),inline=T),
                             textInput("age","Age",placeholder = "Input your age (numeric)"),
                             dataTableOutput("panel1validatefullname"),br(),
                             dataTableOutput("panel1validateemail"),br(),
                             dataTableOutput("panel1validatephno"),br(),
                             dataTableOutput("panel1validateage"),br(),br(),
                             actionButton("gotoP1","Next")
                             
                            
                    ),
                   
                    tabPanel("Service Quality",value="panel2",br(),
                             strong("How satisfied were you with the service quality on the basis of the below parameters?"),br(),br(),
                             radioButtons("a1","Quality of Service",choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             radioButtons("a2","Process of getting problem resolved",choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             radioButtons("a3","Quality of customer service representative",choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             radioButtons("a4","Time taken by customer service representative to solve my issue",choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             radioButtons("a5","Knowledge of customer service representative",choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             radioButtons("a6","Wait time for my question to be answered",choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             strong("I would recommend this application to an associate"),br(),br(),
                             radioButtons("a7","Posibility",choices=c("Very Unlikely","Unlikely","Neutral","Likely","Likely"),inline=T,selected="Neutral"),
                             actionButton('gotoP2', 'Next')
                            
            
                    ),
                    tabPanel("Product Feature",value="panel3",br(),
                             radioButtons("b1","Are you satisfied with the product features?",choices=c("Yes","No","Don't"),inline=T),br(),
                             strong("Which of the product features do you use?"),
                             checkboxInput("b21","Property Management",value=F),
                             checkboxInput("b22","Security Managment",value=F),
                             checkboxInput("b23","Communication",value=F),
                             checkboxInput("b24","Online Payments",value=F),
                             checkboxInput("b25","Management of Tenant lease",value = F),
                             h6("*Multiple Choices are allowed"),br(),
                             textInput("b3","What additional products do you think should be added in the product?",placeholder ="Don't leave empty"),
                             dataTableOutput("panel3validateadd"),br(),br(),
                             actionButton("gotoP3","Next")
                             
                    ),
                    tabPanel("Information and User Interfaces",value="panel4",br(),
                             
                             radioButtons("c11","Were you able to find information you were looking for?",
                                          choices=c("Yes","No"),inline=T),
                             textInput("c12","Other",placeholder="Other Option"),br(),
                             radioButtons("c2","How satisfied are you with the literature we provide to describe our products and services",
                                          choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             selectInput("c3","How easy is it to navigate our website?",
                                         choices=c("Very Easy","Easy","Regular","Difficult","Very Difficult"),
                                         multiple=F),
                             actionButton("gotoP4","Next")
              
                    ),
                    tabPanel("Comfort in using the product",value="panel5",br(),
                             radioButtons("d1","How satisfied are you with the delivery of our products or services?",
                                          choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             radioButtons("d2","How do you rate the comfortableness of using the product?",
                                          choices=c("Highly Uncomfortable","Uncomfortable","Neutral","Comfortable","Highly Comfortable"),inline=T,selected="Neutral"),
                             actionButton("gotoP5","Next")
                             
                             
                    ),
                    tabPanel("Interaction Management",value="panel6",br(),
                             radioButtons("e1","How satisfied are you with the level of customer support we provide?",
                                          choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             radioButtons("e2","How satisfied are you with our company's efforts to meet your communication needs?",
                                          choices=c("Very Unsatisfied","Unsatisfied","Neutral","Satisfied","Very Satisfied"),inline=T,selected="Neutral"),br(),
                             strong("What methods do you prefer in interacting with the organization?"),
                             checkboxInput("e31","Phone",value=F),
                             checkboxInput("e32","Email",value=F),
                             checkboxInput("e33","Social Media",value=F),
                             checkboxInput("e34","VOIP Applications",value=F),
                             h6("*Multiple Choices are allowed"),
                             textInput("e35","Other",placeholder ="Other Option"),
                             useShinyalert(), # Set up shinyalert
                             actionButton("submit","Submit"),tags$hr()
                    )
        )
        
      ), #end of sidebarPanel
      mainPanel(
        fluidPage(
        # dataTableOutput('mytable')
        )
       
      
        
      )#end of mainPanel
    )#end of sidebar Layout
  ) #end of Main Fluidpage
) #end of ShinyUI