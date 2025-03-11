
# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggthemes)
library(corrplot)


df <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/pivoted_filtered_mental_health.csv")

# Check structure and missing values
str(df)
summary(df)
colSums(is.na(df))  

# ---- 2. Handling Missing Data ----
df_clean <- df %>% drop_na(Percent)  # Remove rows where Percent is NA

# ---- 3. Univariate Analysis ----
# Histogram of Percent
ggplot(df_clean, aes(x = Percent)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black", alpha = 0.7) +
  geom_density(aes(y = ..density.. * 30), color = "red", size = 1) +
  labs(title = "Distribution of Mental Health Percentages", x = "Percent", y = "Frequency") +
  theme_minimal()

# Boxplot of Percent by Gender
ggplot(df_clean, aes(x = Gender, y = Percent, fill = Gender)) +
  geom_boxplot() +
  labs(title = "Comparison of Mental Health Issues by Gender", x = "Gender", y = "Percent") +
  theme_minimal()



# Scatter Plot: Number of Persons vs. Percent
ggplot(df_clean, aes(x = `Number.of.persons`, y = Percent)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Relationship Between Number of Persons and Percent", x = "Number of Persons", y = "Percent") +
  theme_minimal()

# ---- 5. Multivariate Analysis ----
# Trend Over Time
df_clean %>%
  group_by(Year) %>%
  summarise(Average_Percent = mean(Percent, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = Average_Percent)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 2) +
  labs(title = "Trend of Mental Health Issues Over Time", x = "Year", y = "Average Percentage Affected") +
  theme_minimal()

# Age Group Trends
df_clean %>%
  group_by(Year, Age_Group) %>%
  summarise(Average_Percent = mean(Percent, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = Average_Percent, color = Age_Group)) +
  geom_line(size = 1) +
  facet_wrap(~ Age_Group, scales = "free_y") +
  labs(title = "Trend of Mental Health Issues Over Time by Age Group", x = "Year", y = "Average Percentage") +
  theme_minimal()
