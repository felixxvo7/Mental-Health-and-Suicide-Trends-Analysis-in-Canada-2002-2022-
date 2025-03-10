
library(tidyverse)
library(lubridate)
library(plotly)
library(data.table)
library(ggplot2)
library(dplyr)


mental_health <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/mental health CAN 02-22.csv") %>%
  mutate(Year = (REF_DATE))

# Clean and prepare data
processed_data <- mental_health %>%
  # Filter key indicators and remove confidence intervals
  filter(Indicators %in% c("Major depressive episode, life", "Cannabis use, life"),
         Characteristics == "Percent",
         Gender != "Total, gender of person") %>%
  # Convert year and values to numeric
  mutate(Year = as.numeric(REF_DATE),
         Value = as.numeric(VALUE)) %>%
  # Handle missing data
  filter(!is.na(Value)) %>%
  # Select relevant columns
  select(Year, Age.group = `Age.group`, Gender, Indicators, Value)

# Create visualization
ggplot(processed_data, aes(x = Year, y = Value, color = Gender)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  facet_grid(Indicators ~ Age.group, scales = "free_y") +
  labs(title = "Mental Health Trends in Canada (2002-2022)",
       subtitle = "Percentage of Population by Age Group and Gender",
       y = "Percentage (%)",
       x = "Year",
       color = "Gender") +
  scale_x_continuous(breaks = seq(2002, 2022, 5)) +
  scale_color_manual(values = c("Men+" = "#1f77b4", "Women+" = "#ff7f0e")) +
  theme_minimal() +
  theme(legend.position = "bottom",
        strip.text = element_text(size = 10, face = "bold"),
        axis.text.x = element_text(angle = 45, hjust = 1))