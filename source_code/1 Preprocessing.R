
library(tidyverse)

mental_health <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/mental health CAN 02-22.csv")


# Handle missing values
mental_health <- mental_health %>%
  filter(!is.na(VALUE) & VALUE != "")

mental_health <- mental_health %>%
  rename(
    Year = REF_DATE,
    Geography = GEO,
    Age_Group = `Age.group`,
    Unit = UOM
  ) %>%
  mutate(
    Year = as.numeric(Year),
    Value = as.numeric(VALUE)
  )

mental_health <- mental_health %>%
  mutate(
    Age_Group = case_when(
      Age_Group == "Total, 15 years and over" ~ "15+ Years",
      Age_Group == "15 to 24 years" ~ "15-24 Years",
      Age_Group == "25 to 64 years" ~ "25-64 Years",
      TRUE ~ Age_Group
    )
  )

# Separate main values from confidence intervals
main_data <- mental_health %>%
  filter(!str_detect(Characteristics, "confidence interval"))

ci_data <- mental_health %>%
  filter(str_detect(Characteristics, "confidence interval")) %>%
  mutate(CI_Type = ifelse(
    str_detect(Characteristics, "Low"), "Low_CI", "High_CI")) %>%
  select(-Characteristics) %>%
  pivot_wider(names_from = CI_Type, values_from = Value)

main_data <- main_data %>%
  mutate(row_id = row_number())

ci_data <- ci_data %>%
  mutate(row_id = row_number())

final_data <- main_data %>%
  left_join(ci_data, by = c("Year", "Geography", "Age_Group", "Gender", "Indicators", "row_id")) %>%
  select(-row_id)



# 3. Modified visualization code
ggplot(final_data, aes(x = year, y = value, color = gender)) +
  geom_ribbon(aes(ymin = low_ci, ymax = high_ci, fill = gender), alpha = 0.1) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  facet_grid(indicators ~ Age_Group, scales = "free_y") + # Ensure match
  labs(title = "Mental Health Trends in Canada (2002-2022)",
       subtitle = "With 95% Confidence Intervals",
       y = "Percentage (%)",
       x = "Year") +
  scale_x_continuous(breaks = seq(2000, 2022, 5)) +
  theme_minimal()


library(dplyr)
library(tidyr)
filtered_mental_health <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/filtered_mental_health.csv")

#filtered_mental_health <- filtered_mental_health %>% select(c(-UOM_ID,-SCALAR_FACTOR,-SCALAR_ID))
# Sum of NA values by column
na_count <- colSums(is.na(filtered_mental_health))

print(na_count)
filtered_mental_health <- filtered_mental_health %>% select(c(-SYMBOL, - TERMINATED, -VALUE))

# Filter rows with any NA values
rows_with_na <- filtered_mental_health[apply(is.na(filtered_mental_health), 1, any), ]

filtered_mental_health <- filtered_mental_health%>%
  filter(Characteristics != "Statistically different from previous reference period")


write.csv(filtered_mental_health, "filtered_mental_health.csv", row.names = FALSE)
print("CSV file written successfully!")

filtered_mental_health <- filtered_mental_health %>% select(c(-Unit, -VECTOR, -STATUS ,-COORDINATE, - DECIMALS ))
# Now, pivot the data based on the Indicator and Characteristics columns
pivoted_data <- filtered_mental_health %>%
  pivot_wider(
    names_from = Characteristics,  # New column names will come from Characteristics
    values_from = Value,           # Values will come from the Value column
    names_glue = "{Characteristics}"  # Combine Characteristics and Unit for column names
  )

# View the reshaped data
print(pivoted_data)

write.csv(pivoted_data, "pivoted_filtered_mental_health", row.names = FALSE)
print("CSV file written successfully!")