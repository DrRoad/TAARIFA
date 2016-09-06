require(dplyr)
require(magrittr)


### Refactor big categorical variables

find_top_20 <- function(field, data, data2){
  # Returns vector of top 20 responses of field across train and test

  responses <- c(as.character(data[,field]), as.character(data2[,field]))
  
  top_responses <- responses %>% 
    table() %>%
    sort(decreasing = T) %>% 
    head(20) %>% 
    names()
  
  return(top_responses)
}

refactor_20 <- function(data, field, top_responses){
  # Take dataframe and field as string
  # return with field factored to top 20 responses across both training and test
  
  feature <- data[,field] %>% as.character()
  
  # Assign all other responses to "Other/None", avoid merging with "Other" respones
  feature[!(feature %in% top_responses)] <- "Other/None"
  
  # Refactor
  feature <- as.factor(feature)
  data[,field] <- feature
  
  return(data)
}


large_factors <- c('funder', 'installer', 'wpt_name', 'subvillage', 'lga', 'ward', 'scheme_name')

for (f in large_factors){
  top20 <- find_top_20(f, train, test)
  
  train <- refactor_20(train, f, top20)
  test <- refactor_20(test, f, top20)
  
  # Check if factors match
  print(paste(f, ":", (sort(levels(train[,f])) == sort(levels(test[,f])))))
}

### Check all factors
all_factors <- test[,sapply(test, is.factor)] %>% names()
for (i in all_factors){
  print(i)
  print(levels(train[,i]) == levels(test[,i]))
}














