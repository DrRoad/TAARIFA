require(dplyr)
require(magrittr)


### Remove redundant variables
remove_redundant <- function(data){
  data %>% select(-region_code, -recorded_by, -extraction_type, -extraction_type_group, -source_type,
                  -quality_group, -quantity, -source_class, -waterpoint_type_group, -payment)
}

train <- remove_redundant(train)
test <- remove_redundant(test)


### Format date field
train$date_recorded <- as.Date(as.character(train$date_recorded), format = "%Y-%m-%d")
test$date_recorded <- as.Date(as.character(test$date_recorded), format = "%Y-%m-%d")

train$scheme_management[train$scheme_management=="None"] <- "Other"
train$scheme_management <- droplevels(train$scheme_management)
