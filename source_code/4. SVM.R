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