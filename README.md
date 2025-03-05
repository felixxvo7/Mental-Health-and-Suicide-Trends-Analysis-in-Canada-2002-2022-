# AI-Driven Mental Health Trend Analysis & Prediction Using R

![R Version](https://img.shields.io/badge/R-4.3.2-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A data science project analyzing mental health trends (e.g., depression, anxiety, suicide rates) and building predictive models to identify risk factors using **R**.

## Overview
This project aims to:
- Analyze historical mental health trends using public datasets.
- Predict future risks (e.g., depression, suicide rates) with machine learning.
- Provide actionable insights through interactive visualizations.

## Features
- **Exploratory Data Analysis (EDA)**: Trends by age, gender, and socio-economic factors.
- **Predictive Models**: Logistic regression, ARIMA, and LSTM for forecasting.
- **Interactive Dashboard**: Built with Shiny to visualize predictions and trends.
- **Sentiment Analysis**: NLP on social media/text data.

## Dataset Sources
1. **Gov of Canada Mental health indicators**: [GC Dataset](https://open.canada.ca/data/dataset/a9863f45-6a1a-4277-ae0f-2d9cb61d413a/resource/2caa55d4-370c-41bc-a662-5ee67da3c074)
2. **Gov of Canada Consumer Price Index Data**: [GC data](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1810000401&pickMembers%5B0%5D=1.2&cubeTimeFrame.startMonth=01&cubeTimeFrame.startYear=2002&cubeTimeFrame.endMonth=12&cubeTimeFrame.endYear=2022&referencePeriods=20020101%2C20221201)
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
│   └── 4_sentiment_analysis.R
├── app/
│   ├── app.R (Shiny dashboard)
│   └── saved_plots/
├── models/
│   ├── logistic_model.rds
│   └── sarimax_model.rds
└── README.md
```
## ⚙️ Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/mental-health-analysis.git
