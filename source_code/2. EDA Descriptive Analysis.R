
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggthemes)
library(corrplot)
library(tidyverse)
library(readr)
library(reshape2)

df<- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/cleaned_mental_health_data.csv")

# How have mental health indicators changes across age, province, genders in 2002-2012-2022 ???

## BY AGE 
### Group data by year and age group
age_trends <- df %>%
  filter(Age_Group != "Total 15++ Years")%>%
  group_by(Year, Age_Group) %>%
  summarise(Average_MH_Indicator = mean(Percent, na.rm = TRUE))

### Plot trends over time for different age groups
ggplot(age_trends, aes(x=Year, y=Average_MH_Indicator, color=Age_Group, group=Age_Group)) +
  geom_line(size=1) +
  geom_point(size=2) +
  theme_minimal() +
  labs(title="Mental Health Trends Across Age Groups (2002-2022)",
       x="Year", y="Average Mental Health Indicator (%)") +
  ylim(4,NA)+
  theme(legend.position="bottom")

## BY GEOGRAPHY
# Filter and group data
province_trends <- df %>%
  filter(Geography != "Canada") %>%
  group_by(Year, Geography) %>%
  summarise(Average_MH_Indicator = mean(Percent, na.rm = TRUE))

# Facet grid for better comparison
ggplot(province_trends, aes(x=Year, y=Average_MH_Indicator, color=Geography)) +
  geom_line(size=1) +
  geom_point(size=2) +
  facet_wrap(~ Geography, scales="free_y") +
  theme_minimal() +
  labs(title="Mental Health Trends by Province",
       x="Year", y="Average Mental Health Indicator (%)") +
  ylim(4, NA) +
  theme(legend.position="none")

## BY GENDER
gender_trends <- df %>%
  group_by(Year, Gender) %>%
  summarise(Average_MH_Indicator = mean(Percent, na.rm = TRUE))

ggplot(gender_trends, aes(x=Year, y=Average_MH_Indicator, color=Gender)) +
  geom_line(size=1) +
  theme_minimal() +
  labs(title="Mental Health Trends by Gender",
       x="Year", y="Average Mental Health Indicator (%)") +
  scale_color_manual(values=c("blue","purple", "pink" ))


# Suicide rates by provinces and gender
library(readxl)
suicide_df <- read_excel("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/suicide rate.xlsx")
df_suicide <- suicide_df

## BY GEOGRAPHY
# Filter and group data
province.suicide_trends <- suicide_df %>%
  filter(Geo != "Canada") %>%
  group_by(Year, Geo) %>%
  summarise(Average_MH_Indicator = mean(Total, na.rm = TRUE))

ggplot(province.suicide_trends, aes(x=Year, y=Average_MH_Indicator, color=Geo)) +
  geom_line(size=1) +
  geom_point(size=2) +
  facet_wrap(~ Geo, scales="free_y") +
  theme_minimal() +
  labs(title="Suicide Trends by Province",
       x="Year", y="Average Number Suicide") +
  theme(legend.position="none")

suicide_by_gender <- suicide_df %>%
  group_by(Year, Gender) %>%
  summarise(Average_Suicide_Rate = mean(rate, na.rm = TRUE))

# Plot suicide trends by gender
ggplot(suicide_by_gender, aes(x=Year, y=Average_Suicide_Rate, color=Gender, group=Gender)) +
  geom_line(size=1) +
  geom_point(size=2) +
  theme_minimal() +
  labs(title="Suicide Rate Trends by Gender (2002-2022)",
       x="Year", y="Suicide Rate per 100,000") +
  scale_color_manual(values=c("pink","blue", "purple"))

library(units)
library(tidyverse)
library(ggplot2)
library(sf)
library(ggthemes)
library(rnaturalearth) 
library(rnaturalearthdata)

df_filtered <- df_suicide %>%
  filter(Year %in% c(2002, 2012, 2022), Gender == "T", Geo != "Canada") %>%
  select(-rate)  # Remove the rate column

canada_map <- ne_states(country = "Canada", returnclass = "sf")
map_data <- canada_map %>%
  left_join(df_filtered, by = c("name" = "Geo"))  

map_data_centroids <- map_data %>%
  mutate(geometry = st_centroid(geometry)) %>%
  mutate(longitude = st_coordinates(geometry)[,1], 
         latitude = st_coordinates(geometry)[,2])

# Plot suicide numbers by province
ggplot(map_data) +
  geom_sf(aes(fill = Total), color = "white") +
  geom_text(data = map_data_centroids, aes(x = longitude, y = latitude, label = Total),
            size = 2, color = "black") +
  scale_fill_gradient(low = "lightblue", high = "darkred", name = "Total Suicides") +
  facet_wrap(~ Year) +  # Separate maps by year
  theme_void() +
  labs(title = "Total Suicides by Province in Canada (2002, 2012, 2022)")

##___________________________________________________
### MERGE DATA

df_mental_health <-df %>%
  rename(
    Population = Number.of.persons,
    Percentage = Percent
  )%>%
  select(!DGUID)


df_suicide <- suicide_df %>%
  rename(
    Population = Total,
    Percentage = rate,
    Geography = Geo
  ) %>%
  mutate(
    Age_Group = "Total 15++ Years",
    Indicators = "Commit Suicide",
    Gender = case_when(
      Gender == "T" ~ "Total, gender of person",
      Gender == "M" ~ "Men+",
      Gender == "F" ~ "Women+",
      TRUE ~ Gender
    ),
    Population = as.integer(Population)
  )

df_combined <- df_mental_health %>%
  full_join(df_suicide, by = c("Year", "Geography", "Gender", "Age_Group", "Indicators","Population","Percentage"))

df_canada <- df_canada %>%
  group_by(Year, Gender, Indicators) %>%
  summarise(Percentage = mean(Percentage, na.rm = TRUE), .groups = "drop")=

df_wide <- df_canada %>%
  pivot_wider(names_from = Indicators, values_from = Percentage)

cor_matrix <- df_wide %>%
  select(-Year, -Gender) %>% 
  cor(use = "pairwise.complete.obs") 

cor_long <- melt(cor_matrix)

# Creates heatmap for correlation each indicators

ggplot(cor_long, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +  
  geom_text(aes(label = round(value, 2)), size = 4, color = "black") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1, 1), 
                       name = "Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Correlation Heatmap: Mental Health Indicators & Suicide")
