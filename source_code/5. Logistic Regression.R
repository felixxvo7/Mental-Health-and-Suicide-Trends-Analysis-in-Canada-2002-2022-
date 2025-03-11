# Load necessary libraries
library(caret)  # For data preprocessing & evaluation

# Load the dataset
df <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/pivoted_filtered_mental_health.csv")

# ---- 1. Data Preprocessing ----

# Remove missing values
df_clean <- na.omit(df)

# Convert 'Percent' into a categorical variable: "High" vs. "Low"
median_percent <- median(df_clean$Percent, na.rm = TRUE)
df_clean$RiskLevel <- ifelse(df_clean$Percent > median_percent, "High", "Low")
df_clean$RiskLevel <- as.factor(df_clean$RiskLevel)  # Convert to factor

# ---- 2. Train Logistic Regression Model ----

# Train a logistic regression model
log_model <- glm(RiskLevel ~ Year + Age_Group + Gender + Geography, 
                 data = df_clean, family = "binomial")

# Print summary of the model
summary(log_model)

# ---- 3. Model Evaluation ----

# Predict probabilities
df_clean$Predicted_Prob <- predict(log_model, type = "response")

# Convert probabilities to binary predictions (Threshold = 0.5)
df_clean$Predicted_Class <- ifelse(df_clean$Predicted_Prob > 0.5, "High", "Low")
df_clean$Predicted_Class <- as.factor(df_clean$Predicted_Class)

# Create a confusion matrix
conf_matrix <- confusionMatrix(df_clean$Predicted_Class, df_clean$RiskLevel)

# Print confusion matrix
print(conf_matrix)
