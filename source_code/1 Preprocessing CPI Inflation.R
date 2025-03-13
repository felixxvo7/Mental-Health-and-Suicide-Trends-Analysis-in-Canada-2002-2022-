
library(tidyverse)
library(dplyr)
library(tidyr)
library(readxl)

Inflation <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/Inflation.csv", header=TRUE)
CPI <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/raw/CPI.csv")
suicide_rate <- read_excel("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/suicide rate raww.xlsx")

