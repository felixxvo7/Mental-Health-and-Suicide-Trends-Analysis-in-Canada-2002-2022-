# AI-Driven Mental Health Trend Analysis & Prediction Using R

![R Version](https://img.shields.io/badge/R-4.3.2-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A data science project analyzing mental health trends (e.g., depression, anxiety, suicide rates) and building predictive models to identify risk factors using **R**.

## 📌 Overview
This project aims to:
- Analyze historical mental health trends using public datasets.
- Predict future risks (e.g., depression, suicide rates) with machine learning.
- Provide actionable insights through interactive visualizations.

## 🚀 Features
- **Exploratory Data Analysis (EDA)**: Trends by age, gender, and socio-economic factors.
- **Predictive Models**: Logistic regression, ARIMA, and LSTM for forecasting.
- **Interactive Dashboard**: Built with Shiny to visualize predictions and trends.
- **Sentiment Analysis**: NLP on social media/text data (e.g., Reddit).

## 📂 Dataset Sources
1. **Suicide Rates**: [Kaggle Dataset](https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016)
2. **CDC Behavioral Risk Data**: [BRFSS](https://www.cdc.gov/brfss/)
3. **Social Media Data**: Reddit (r/depression, r/anxiety) via `RedditExtractoR`.
4. **WHO Global Health Data**: [Suicide Rates by Country](https://www.who.int/data/gho).
   
Mental-Health-Trends-Canada/
├── data/
│   ├── raw/ (original CSVs from CGC/WHO/StatCan)
│   ├── processed/ (cleaned datasets)
│   └── external/ (e.g., Reddit scrapes)
├── notebooks/
│   ├── 1_EDA.ipynb
│   ├── 2_Predictive_Models.ipynb
│   └── 3_Sentiment_Analysis.ipynb
├── models/
│   ├── logistic_regression.pkl
│   ├── sarimax.pkl
│   └── lstm.h5
├── app/ (Shiny/PowerBI dashboard)
├── requirements.txt
└── README.md
## ⚙️ Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/mental-health-analysis.git
