library(shiny)
library(googlesheets) 
library(DT)
library(dplyr) 
library(shinyalert)

gs_auth(new_user = FALSE, gs_auth(token = "ttt.rds"))   


#Validation of email
isValidEmail <- function(x) {
  grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(x), 
        ignore.case=TRUE)
}



shinyServer(function(input,output,session){
  

  
  ##validation of Panel 1 and Jump to Next Panel
    observeEvent(input$gotoP1,{
      
    validate(
      need(input$fullname!="",
           paste("Please Input your fullname")),
      need(isValidEmail(input$email),
           paste("Please Input a valid E-mail address")),
      need(nchar(as.numeric(input$phno)) == 10 , 
           paste("Please Input a 10-digit-number only")),
      need(as.numeric(input$age),
           paste("Please Input you age in numeric format")) 
    )
    #Jump to next tab after validation
    updateTabsetPanel(session, "inTabset",
                      selected = "panel2")
  })
  
  #Display the validation
  
  output$panel1validatefullname <- renderDataTable({
    validate(
      need(input$fullname!="",
           "Please Input your fullname")
    )
    
  })
  
  output$panel1validateemail <- renderDataTable({
    validate(
      need(isValidEmail(input$email),
           paste("Please Input a valid E-mail address"))
      
    )
  })
  
  output$panel1validatephno <- renderDataTable({
    validate(
      need(nchar(as.numeric(input$phno)) == 10 ,
           paste("Please Input a 10-digit-number only"))
      
    )
  })
  
  
  
  
  output$panel1validateage <- renderDataTable({
    validate(
      need(as.numeric(input$age),
           paste("Please Input you age in numeric format"))
      
    )
  })
  
  ##Validation of Panel 2 and Jump to Next Panel
  
  observeEvent(input$gotoP2, {
    updateTabsetPanel(session, "inTabset",
                      selected = "panel3")
  }
  )
  
  

  # #validation of Panel3 and Jump to Next Panel
  observeEvent(input$gotoP3,{
    validate(
      need(input$b3!="",
           paste("Please don't leave empty"))
    )
      #Jump to next tab after validation
        updateTabsetPanel(session, "inTabset",
                          selected = "panel4")
      })


  #Display the validation 
  
  output$panel3validateadd<- renderDataTable({
    validate(
      need(input$b3!="",
           paste("Please don't leave empty"))
    )
  })

 
  
 
  ##Validation of Panel 4 and Jump to Next Panel

  

  observeEvent(input$gotoP4, {
    updateTabsetPanel(session, "inTabset",
                      selected = "panel5")
  }
  )
  
  ##Validation of Panel 5 and Jump to Next Panel

  observeEvent(input$gotoP5, {
    updateTabsetPanel(session, "inTabset",
                      selected = "panel6")
  }
  )
  
  
  
  
  
  ##Table Constructions
  
  Results <- reactive(
    c(as.character(Sys.Date()),as.character(input$fullname),as.character(input$email),as.character(input$phno),input$gender,input$age,input$a1,input$a2,input$a3,input$a4,input$a5,input$a6,input$a7,
      input$b1,as.character(input$b21),as.character(input$b22),as.character(input$b23),as.character(input$b24),as.character(input$b25),as.character(input$b3),
      input$c11,as.character(input$c12),input$c2,input$c3,
      input$d1,input$d2,
      input$e1,input$e2,as.character(input$e31),as.character(input$e32),as.character(input$e33),as.character(input$e34),as.character(input$e35)))

  ##Save to google sheet after clicking Submit
  
  observeEvent(input$submit, {
    
    Data <- Data %>%
     gs_add_row(ws = "Data", input =Results())
      
      # Show a modal when the button is pressed
      shinyalert("Success!", "Thank you for the submission", type = "success")
      session$reload() #Reload the session
    
    })
  
})
