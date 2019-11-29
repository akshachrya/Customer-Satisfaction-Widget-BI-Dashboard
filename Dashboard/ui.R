library(shiny)
library(shinydashboard)
library(googlesheets)
library(ggplot2)
library(plotly)
library(dplyr)
library(DT)



shinyUI(
  
  
  dashboardPage(title="Dashboard",skin="blue",
    dashboardHeader(title="Customer Satisfaction Survey"
      
    ), #end of dashboard header
    dashboardSidebar(
      actionButton("refresh", "Refresh"),
      sidebarMenu(
        menuItem("Main Dashboard",tabName="dashboard",icon=icon("dashboard")),
        #menuSubItem("Survey Analysis",tabName = "dashboard1",icon = icon("poll")),
        menuSubItem("Quality Of Service",tabName = "dashboard2",icon=icon("stopwatch")),
        menuSubItem("Product Features",tabName = "dashboard3",icon = icon("suitcase")),
        menuSubItem("Information and User Interface",tabName = "dashboard4",icon = icon("tv")),
        menuSubItem("Interaction Management",tabName = "dashboard5",icon = icon("users")),
        menuSubItem("Survey Data",tabName = "dashboard6",icon = icon("database"))
        
        
        
      )
    ), #end of dashboard siderbar
    dashboardBody(
      tabItems(
        tabItem(tabName ="dashboard",
                box(h1("Statistics of Customer Satisfaction Survey",align="center"),width=12),br(),
                fluidRow(
                  box(infoBoxOutput("TotalSurvey"),
                  infoBoxOutput("TotalMale"),
                  infoBoxOutput("TotalFemale"),width=12),
                  
                  
                  box(plotOutput("etnow1"),width =8),
                  box(plotOutput("agegroup"),width=4),
                  box(plotOutput("swtpf1"),width=4),
                  box(plotOutput("rcoup1"),width=8),
                  box(plotOutput("catfi1"),width=4)
                
                         
                         
                  )
               
                
                ),
        
        tabItem(tabName = "dashboard1",
                box(h1("Survey Statistics By Day",align="center"),width=12),br(),
                fluidRow(
                   
                ),
                h1("This is Dashboard1")
        ),
        tabItem(tabName = "dashboard2",
                box(h1("Customer Satisfaction with Service Quality on Basis of Parameter",align="center"),width=12),br(),
                  fluidPage(
                    
                    box(plotOutput("qos"),width=6),
                    box(plotOutput('pogpr'),width=6),
                    box(plotOutput("qocsr"),width=6),
                    box(plotOutput("ttbcsrtsmi"),width=6),
                    box(plotOutput("posibility"),width=6),
                    box(plotOutput("kocsr"),width=6),
                    box(width=6,plotOutput("wtfmqtba"))
                  
                )
                        
                ),
        tabItem(tabName = "dashboard3",
               box(h1("Product Features",align="center"),width =12) ,br(),
                fluidPage(
                  box(plotOutput("swtpf"),width=4),
                  box(plotOutput("pmu"),width=4),
                  box(plotOutput("smu"),width=4),
                  box(plotOutput("commu"),width=4),
                  box(plotOutput("opu"),width=4),
                  box(plotOutput("motlu"),width=4),
                  box(h3("Additional Suggested Product",align="center"),dataTableOutput("sap"),width=6),
                  dataTableOutput("users1")
                  
                )
                  
                
        ),
      
        tabItem(tabName = "dashboard4",
                box(h1("Information and User Interface",align="center"),width=12),br(),
                fluidPage(
                  box(plotOutput("catfi"),width=4),
                  box(plotOutput("swltdpas"),width = 8),
                  box(h3("Customer Query while Finding Information",align="center"),dataTableOutput("atfiuwlfo"),width=5),
                  box(plotOutput("etnow"),width = 7),br(),
                  
                  fluidPage(
                    box(h1("Comfort in Using Product",align="center"),width=12),br(),
                    box(plotOutput("swdopos"),width=6),
                    box(plotOutput("rcoup"),width=6)
                    
                    
                  )
                 
                  
                  
                )
               
                  
                
                
                
        ),
        tabItem(tabName = "dashboard6",
                fluidPage(
                  box(width=12,dataTableOutput('mytable')),br(),
                  box(width=12,actionButton("download","Download"))
                )
                
                )
        
        
        
      ) #end of tabItems
      
      
    )#end of dashboard body
  ) #end of dashboard page
) #end of shiny UI