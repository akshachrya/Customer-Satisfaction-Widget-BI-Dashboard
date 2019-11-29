library(googlesheets)
library(dplyr)

ttt <- gs_auth()

saveRDS(ttt,"ttt.rds")


Data <- gs_new("Data") %>% 
  gs_ws_rename(from = "Sheet1", to = "Data")   

Data <- Data %>% 
  gs_edit_cells(ws = "Data", input = cbind("Time","Full Name", "Email", "Phone Number", "Gender","Age",
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
                                           "Methods prefer in interacting with the organization(Other)" ),trim = T)  

