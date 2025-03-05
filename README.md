# AI-Driven Mental Health Trend Analysis & Prediction Using R

![R Version](https://img.shields.io/badge/R-4.3.2-blue)
![License](https://img.shields.io/badge/License-MIT-green)

This project analyzes mental health trends, suicide rates, and socio-economic factors in Canada over two decades. It combines exploratory data analysis (EDA), predictive modeling, and an interactive dashboard to uncover insights and forecast future trends. Built in **R**.

- **Exploratory trends** by age, gender, and economic factors  
- **SARIMAX** time-series forecasting  
- **Logistic regression** for high-risk group prediction  
- **Sentiment analysis** of mental health discourse on Reddit  
- **Interactive Shiny dashboard** for visualization  


## Features
- **EDA**: Trends, correlations, and geospatial analysis.
- **Predictive Models**:  
  - Logistic regression to identify high-risk demographics.  
  - SARIMAX for suicide rate forecasting with inflation as an exogenous variable.  
- **Dashboard**: Interactive visualization of trends, forecasts, and risk factors.
- **Sentiment Analysis**: NLP-driven analysis of Reddit posts to gauge public sentiment trends.
- 
## Dataset Sources
1. **Gov of Canada Mental health indicators**: [StatCan Table 13-10-0465-01](https://open.canada.ca/data/dataset/a9863f45-6a1a-4277-ae0f-2d9cb61d413a/resource/2caa55d4-370c-41bc-a662-5ee67da3c074)
2. **Gov of Canada Consumer Price Index Data**: [Statistics Canada](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1810000401&pickMembers%5B0%5D=1.2&cubeTimeFrame.startMonth=01&cubeTimeFrame.startYear=2002&cubeTimeFrame.endMonth=12&cubeTimeFrame.endYear=2022&referencePeriods=20020101%2C20221201)
3. **Social Media Data**: Reddit (r/depression, r/anxiety) via `RedditExtractoR`.
4. **WHO Global Health Data**: [Suicide Rates by Country](https://www.who.int/data/gho).
```
Mental-Health-Trends-Canada/
Mental-Health-Canada-R/
├── data/
│   ├── raw/
│   │   ├── suicide_rates.csv
│   │   ├── mental_health_indicators.csv
│   │   └── inflation_rates.csv
│   └── processed/
│       └── merged_data.csv
├── scripts/
│   ├── 1_data_preprocessing.R
│   ├── 2_eda.R
│   ├── 3_modeling.R
│   ├── 4.data_scraping.py
│   └── 4_sentiment_analysis.R
├── app/
│   ├── app.R (Shiny dashboard)
│   └── saved_plots/
├── models/
│   ├── logistic_model.rds
│   └── sarimax_model.rds
└── README.md
```
## Install required R packages:
```
install.packages(c("dplyr", "ggplot2", "plotly", "caret", "forecast", 
                  "tseries", "shiny", "tidytext", "RedditExtractoR"))
```
