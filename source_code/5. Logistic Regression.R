library(caret)
library(dplyr)
library(readr)
library(ggplot2)

mental_health_data <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/merged_suicide_mental_health_data.csv")
economic_data <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/CPI_inflation.csv")

mental_health_indicators <- c("Major depressive episode, life", 
                              "Eating disorder, current diagnosed condition",
                              "Social phobia, life", 
                              "Generalized anxiety disorder, life",
                              "Bipolar disorder, life")

target <- "Suicidal thoughts, life"

mental_health_filtered <- mental_health_data %>%
  filter(Indicators %in% c(mental_health_indicators, target)) %>%
  select(Year, Geography, Age_Group, Gender, Indicators, Percentage)

mental_health_wide <- mental_health_filtered %>%
  tidyr::pivot_wider(names_from = Indicators, values_from = Percentage) %>%
  drop_na()

merged_data <- merge(mental_health_wide, economic_data, by.x = c("Year", "Geography"), by.y = c("Year", "Geo"), all.x = TRUE)

for (col in c("CPI", "Inflation_rate")) {
  merged_data[[col]][is.na(merged_data[[col]])] <- median(merged_data[[col]], na.rm = TRUE)
}

features <- c(mental_health_indicators, "CPI", "Inflation_rate")
X <- merged_data[, features]
y <- merged_data[[target]]

y <- ifelse(y > median(y, na.rm = TRUE), 1, 0)

X_scaled <- scale(X)

cv_folds <- trainControl(method = "cv", number = 5)

logistic_model <- train(as.factor(y) ~ ., 
                        data = data.frame(X_scaled, y = as.factor(y)),
                        method = "glm",
                        family = "binomial",
                        trControl = cv_folds)

cat("Cross-Validation Accuracy:", mean(logistic_model$results$Accuracy))