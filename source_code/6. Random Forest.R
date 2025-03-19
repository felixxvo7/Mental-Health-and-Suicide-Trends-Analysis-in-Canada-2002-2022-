library(caret)
library(dplyr)
library(readr)
library(ggplot2)
library(randomForest)
library(tidyverse)


mental_health_data <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/merged_suicide_mental_health_data.csv")
economic_data <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/CPI_inflation.csv")

mental_health_indicators <- c("Major depressive episode, life", "Eating disorder, current diagnosed condition",
                              "Social phobia, life", "Generalized anxiety disorder, life", "Bipolar disorder, life")
target <- "Suicidal thoughts, life"

merged_data <- mental_health_data %>%
  filter(Indicators %in% c(mental_health_indicators, target)) %>%
  select(Year, Geography, Age_Group, Gender, Indicators, Percentage) %>%
  pivot_wider(names_from = Indicators, values_from = Percentage) %>%
  drop_na() %>%
  merge(economic_data, by.x = c("Year", "Geography"), by.y = c("Year", "Geo"), all.x = TRUE)

merged_data[c("CPI", "Inflation_rate")][is.na(merged_data[c("CPI", "Inflation_rate")])] <- apply(merged_data[c("CPI", "Inflation_rate")], 2, median, na.rm = TRUE)

X <- merged_data[, c(mental_health_indicators, "CPI", "Inflation_rate")]
y <- ifelse(merged_data[[target]] > median(merged_data[[target]], na.rm = TRUE), 1, 0)

cv_folds <- trainControl(method = "cv", number = 10, sampling = "up", search = "grid")

tune_grid <- expand.grid(mtry = seq(2, ncol(X), by = 1))

rf_model <- train(as.factor(y) ~ ., data = data.frame(scale(X), y = as.factor(y)),
                  method = "rf", trControl = cv_folds, tuneGrid = tune_grid, ntree = 500)

cat("Optimized Cross-Validation Accuracy (Random Forest):", mean(rf_model$results$Accuracy))