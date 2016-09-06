# Random Forest Prelim Model
# 1. Fit random forest model
# 2. Examine variable importance in preparation for
#     creating logistic regression

library(dplyr)

# Read data in
setwd("F:\\Data Science\\TAARIFA Water Pump")
df.labels <- read.csv("train_labels.csv")
df.values  <- read.csv("train_values.csv")

# Join datasets
train <- left_join(df.values, df.labels, by="id")

train.rf <- select(df, status_group,
       amount_tsh, longitude, latitude,
       basin, region, region_code, district_code,
       population, public_meeting, 
       scheme_management, permit, construction_year,
       extraction_type_class,
       management, management_group, payment,
       water_quality, quantity,
       source_type, waterpoint_type)


# Random Forest
library(randomForest)

fit = randomForest(as.factor(status_group) ~ ., data=df.rf)

varImpPlot(fit)

# Test values
test <- read.csv("test.csv")

test.rf <- select(test, id,
                  amount_tsh, longitude, latitude,
                  basin, region, region_code, district_code,
                  population, public_meeting, 
                  -scheme_management, permit, construction_year,
                  extraction_type_class,
                  management, management_group, payment,
                  water_quality, quantity,
                  source_type, waterpoint_type)

# Correcting for Factor level error!
# http://stackoverflow.com/questions/24829674/r-random-forest-error-type-of-predictors-in-new-data-do-not-match
levels(test.rf$scheme_management) <-  levels(df.rf$scheme_management)

test$status_group <- predict(fit, test.rf)



# # Assigning numeric values to the labels
# df.labels$status_group <- as.character(df.labels$status_group)
# 
# df.labels %>%
#   mutate(status_group = replace(status_group, status_group=="functional", 2),
#          status_group = replace(status_group, status_group=="non functional", 0),
#          status_group = replace(status_group, status_group=="functional needs repair", 1)
#          )