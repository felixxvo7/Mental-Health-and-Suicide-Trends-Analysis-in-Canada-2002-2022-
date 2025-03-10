
library(tidyverse)
library(lubridate)
library(plotly)
library(data.table)
library(ggplot2)
library(dplyr)


mental_health <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/mental health CAN 02-22.csv") %>%
  mutate(Year = (REF_DATE))

unique(mental_health$Indicators)