
library(tidyverse)
library(dplyr)
library(tidyr)

mental_health <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/mental health CAN 02-22.csv")


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
      Age_Group == "Total, 15 years and over" ~ "Total 15++ Years",
      Age_Group == "15 to 24 years" ~ "15-24 Years",
      Age_Group == "25 to 64 years" ~ "25-64 Years",
      TRUE ~ Age_Group
    )
  )

str(mental_health)
unique(mental_health$Indicators)


key_indicators <- c("Major depressive episode, life",
                    "Bipolar disorder, life",
                    "Any mood disorder, life",
                    "Generalized anxiety disorder, life",
                    "Social phobia, life",
                    "PTSD (Current diagnosis)",
                    "Schizophrenia or psychosis, ever received diagnosis",
                    "Eating disorder, current diagnosed condition",
                    "ADHD (Current diagnosis)",
                    "Suicidal thoughts, 12 months",
                    "Suicidal thoughts, life")

filtered_mental_health <- mental_health %>% filter(Indicators %in% key_indicators)
na_count <- colSums(is.na(filtered_mental_health))
print(na_count)


filtered_mental_health <- filtered_mental_health %>% select(c(-SYMBOL, - TERMINATED, -VALUE))
rows_with_na <- filtered_mental_health[apply(is.na(filtered_mental_health), 1, any), ]

filtered_mental_health <- filtered_mental_health%>%
  filter(Characteristics != "Statistically different from previous reference period")


filtered_mental_health <- filtered_mental_health %>% select(c(-Unit, -VECTOR, -STATUS ,-COORDINATE, - DECIMALS, -UOM_ID, -SCALAR_FACTOR, -SCALAR_ID ))

pivoted_data <- filtered_mental_health %>%
  pivot_wider(
    names_from = Characteristics,  
    values_from = Value,           
    names_glue = "{Characteristics}" 
  )

print(pivoted_data)

write.csv(pivoted_data, "pivoted_filtered_mental_health.csv", row.names = FALSE)
print("CSV file written successfully!")