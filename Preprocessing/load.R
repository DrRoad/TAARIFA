require(dplyr)
require(magrittr)

### Load and format training data and test data

# Load training data
train_labels <- read.csv("./data/train_labels.csv")
train_values <- read.csv("./data/train_values.csv")
train <- inner_join(train_labels, train_values, by = 'id')
rm(train_labels, train_values)

# Load testing data
test <- read.csv("./data/test_values.csv")
