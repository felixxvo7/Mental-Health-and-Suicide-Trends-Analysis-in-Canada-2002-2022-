
library(tidyverse)
library(dplyr)
library(tidyr)
library(readxl)

Inflation <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/Inflation.csv", header=TRUE)
CPI <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/CPI.csv")
suicide_rate <- read_excel("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/suicide rate raww.xlsx")


library(tidyverse)
library(dplyr)
library(tidyr)
library(readxl)

Inflation <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/Inflation.csv", header=TRUE)
CPI <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/CPI.csv")
suicide_rate <- read_excel("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/suicide rate raww.xlsx")

Inflation_long <- Inflation %>%
  pivot_longer(cols = starts_with("X"), names_to = "Year", values_to = "Value_Measurement") %>%
  mutate(Year = str_remove(Year, "X") %>% as.integer())  # Remove "X" and convert to integer
# Convert Year to integer

CPI_long <- CPI %>%
  pivot_longer(cols = starts_with("X"), names_to = "Year", values_to = "Value_Measurement") %>%
  mutate(Year = str_remove(Year, "X") %>% as.integer())

merged_df <- CPI_long %>%
  left_join(Inflation_long, by = c("Geo", "Year"))

merged_df <- merged_df %>%
  rename(CPI= Value_Measurement.x) %>%
  rename(Inflation_rate = Value_Measurement.y)

merged_df
write.csv(merged_df, "CPI_inflation.csv", row.names = FALSE)
print("CSV file written successfully!")
