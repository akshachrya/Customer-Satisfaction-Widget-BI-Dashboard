library(googlesheets)
library(dplyr)


shiny_token <- gs_auth()
saveRDS(shiny_token, "shiny_app_token.rds")
