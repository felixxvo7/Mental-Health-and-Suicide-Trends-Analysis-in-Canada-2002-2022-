# Load necessary libraries
library(e1071)  # For SVM
library(tidyverse)
library(caret)  # For evaluation metrics

# Load the dataset
df <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/pivoted_filtered_mental_health.csv")

# Remove rows with missing values
df_clean <- na.omit(df)

###_____________________REGRESSION________________________
# Train an SVM regression model
svm_reg <- svm(Percent ~ Year + Age_Group + Gender + Geography, 
               data = df_clean, kernel = "radial")

# Model summary
summary(svm_reg)

# Predict on the dataset
df_clean$Predicted_Percent <- predict(svm_reg, df_clean)

# Plot actual vs. predicted values
ggplot(df_clean, aes(x = Percent, y = Predicted_Percent)) +
  geom_point(color = "blue", alpha = 0.5) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Actual vs. Predicted Mental Health Percentage",
       x = "Actual Percent", y = "Predicted Percent") +
  theme_minimal()

###_____________________EVALUATION________________________
# Calculate evaluation metrics
actual <- df_clean$Percent
predicted <- df_clean$Predicted_Percent

# 1. Root Mean Squared Error (RMSE)
rmse <- sqrt(mean((actual - predicted)^2))
print(paste("RMSE:", rmse))

# 2. Mean Absolute Error (MAE)
mae <- mean(abs(actual - predicted))
print(paste("MAE:", mae))

# 3. R-squared (Coefficient of Determination)
ss_total <- sum((actual - mean(actual))^2)
ss_residual <- sum((actual - predicted)^2)
r_squared <- 1 - (ss_residual / ss_total)
print(paste("R-squared:", r_squared))

# 4. Residuals Plot (to check for patterns)
residuals <- actual - predicted
ggplot(data = df_clean, aes(x = predicted, y = residuals)) +
  geom_point(color = "blue", alpha = 0.5) +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Residuals vs. Predicted Values",
       x = "Predicted Percent", y = "Residuals") +
  theme_minimal()


# Load necessary libraries
library(e1071)  # For SVM
library(caret)  # For model evaluation

# Load dataset
df <- read.csv("pivoted_filtered_mental_health.csv")

# Remove missing values
df_clean <- na.omit(df)

# Convert Percent into a categorical variable: High vs. Low
median_percent <- median(df_clean$Percent, na.rm = TRUE)
df_clean$RiskLevel <- ifelse(df_clean$Percent > median_percent, "High", "Low")
df_clean$RiskLevel <- as.factor(df_clean$RiskLevel)  # Convert to factor

# Train an SVM model
svm_model <- svm(RiskLevel ~ Year + Age_Group + Gender + Geography, 
                 data = df_clean, kernel = "radial")

# Model summary
summary(svm_model)

# Predict on the dataset
df_clean$Predicted <- predict(svm_model, df_clean)

# Confusion Matrix (Model Performance)
confusionMatrix(df_clean$Predicted, df_clean$RiskLevel)


# R Code: SVM for Classification

# Convert Percent into a categorical variable: High vs. Low
median_percent <- median(df_clean$Percent, na.rm = TRUE)
df_clean$RiskLevel <- ifelse(df_clean$Percent > median_percent, "High", "Low")
df_clean$RiskLevel <- as.factor(df_clean$RiskLevel)  # Convert to factor

# Train an SVM model
svm_model <- svm(RiskLevel ~ Year + Age_Group + Gender + Geography, 
                 data = df_clean, kernel = "radial")

# Model summary
#### summary(svm_model)

# Predict on the dataset
df_clean$Predicted <- predict(svm_model, df_clean)

# Confusion Matrix (Model Performance)
conf_matrix <- confusionMatrix(df_clean$Predicted, df_clean$RiskLevel)
print(conf_matrix)

# Extract key metrics
accuracy <- conf_matrix$overall["Accuracy"]
precision <- conf_matrix$byClass["Pos Pred Value"]
recall <- conf_matrix$byClass["Sensitivity"]
f1_score <- conf_matrix$byClass["F1"]

# Print key metrics
print(paste("Accuracy:", accuracy))
print(paste("Precision:", precision))
print(paste("Recall:", recall))
print(paste("F1 Score:", f1_score))

# Plot the confusion matrix
ggplot(as.data.frame(conf_matrix$table), aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), color = "white", size = 6) +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(title = "Confusion Matrix",
       x = "Actual Risk Level",
       y = "Predicted Risk Level") +
  theme_minimal()