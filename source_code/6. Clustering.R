
library(tidyverse)
library(lubridate)
library(plotly)


mental_health <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/mental health CAN 02-22.csv") %>%
  mutate(Year = (REF_DATE))


depression_trend <- mental_health %>%
  filter(Indicators == "Major depressive episode, life",
         Characteristics == "Percent") %>%
  group_by(Year, Gender) %>%
  summarise(Avg_Percent = mean(VALUE, na.rm = TRUE), .groups = "drop")


ggplotly(
  ggplot(depression_trend, aes(x = Year, y = Avg_Percent, color = Gender)) +
    geom_line(linewidth = 1) +
    geom_point(size = 2) +
    labs(title = "Depression Trends (2002-2022)",
         y = "Percentage", x = "Year") +
    theme_minimal() +
    scale_color_brewer(palette = "Set1")
)

# 2. Demographic Heatmap 
cannabis_use_matrix <- mental_health %>%
  filter(Indicators == "Cannabis use, life",
         Characteristics == "Percent") %>%
  group_by(Year, `Age.group`) %>%
  summarise(Usage_Percent = mean(VALUE, na.rm = TRUE), .groups = "drop") %>%
  complete(Year, `Age.group`, fill = list(Usage_Percent = NA))

ggplot(cannabis_use_matrix, aes(x = Year, y = `Age.group`, fill = Usage_Percent)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(name = "Usage %", option = "magma") +
  labs(title = "Cannabis Use Patterns by Age Group",
       x = "Year", y = "Age Group") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 3. Faceted Violin Plots
mental_health %>%
  filter(grepl("Suicidal thoughts", Indicators),
         Characteristics == "Percent") %>%
  ggplot(aes(x = Gender, y = VALUE, fill = Gender)) +
  geom_violin(alpha = 0.7) +
  geom_boxplot(width = 0.1, fill = "white") +
  facet_grid(Indicators ~ `Age.group`, scales = "free_y") +
  labs(title = "Suicidal Thoughts Distribution by Demographic Groups",
       y = "Percentage", x = "") +
  theme_bw() +
  theme(legend.position = "bottom")

# 4. Animated Bubble Chart 
library(gganimate)

mental_health %>%
  filter(Characteristics == "Percent",
         Indicators %in% c("Major depressive episode, life",
                           "Cannabis use, life")) %>%
  group_by(Year, Indicators, `Age.group`) %>%
  summarise(Avg_Percent = mean(VALUE, na.rm = TRUE), .groups = "drop") %>%
  ggplot(aes(x = `Age.group`, y = Avg_Percent, 
             size = Avg_Percent, color = Indicators)) +
  geom_point(alpha = 0.7) +
  scale_size(range = c(3, 12)) +
  scale_color_brewer(palette = "Dark2") +
  labs(title = "Year: {frame_time}", 
       x = "Age Group", y = "Percentage") +
  theme_minimal() +
  transition_time(Year) +
  ease_aes("linear")

# 5. Streamgraph for Composition
library(ggstream)

mental_health %>%
  filter(Indicators == "Perceived mental health, very good or excellent",
         Characteristics == "Percent") %>%
  group_by(Year, Gender) %>%
  summarise(Percent = mean(VALUE, na.rm = TRUE), .groups = "drop") %>%
  ggplot(aes(x = Year, y = Percent, fill = Gender)) +
  geom_stream(type = "proportional") +
  labs(title = "Changing Composition of Mental Health Perceptions",
       x = "Year", y = "Proportion") +
  scale_fill_brewer(palette = "Pastel1") +
  theme_minimal()

# For better performance with large datasets:
library(data.table)
setDT(mental_health) # Convert to data.table

mental_health[, .(Avg_Percent = mean(VALUE, na.rm = TRUE)), 
              by = .(Year, Gender, Indicators)]


