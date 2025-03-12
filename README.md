# AI-Driven Mental Health Trend Analysis & Suicide Prediction in Canada  

## Overview  
This project examines **mental health trends, suicide rates, and socio-economic factors** in Canada over two decades (2002–2022). Using **exploratory data analysis (EDA), machine learning models, and sentiment analysis from Reddit**, the study aims to identify high-risk groups and provide actionable insights.  

## Key Features  
- **Exploratory Data Analysis (EDA):** Identifying trends in mental health indicators and suicide rates by demographics (age, gender, province).  
- **Machine Learning Models:**  
  - Logistic Regression for **high-risk group classification**.  
  - Support Vector Machine (SVM) and Random Forest for **suicide risk prediction**.  
- **Reddit Sentiment Analysis:** Analyzing public discourse on mental health to detect emerging trends.  
- **Interactive Dashboard:** A **Shiny web application** for visualizing mental health and suicide trends.  

---

## Research Questions  

### 1. Descriptive Analysis  
- How have **mental health indicators** changed over time (2002, 2012, 2022) across **age, province, and gender**?  
- What are the **trends in suicide rates** over 20 years, overall and by demographic groups?  
- Are there **provincial differences** in mental health disorders and suicide rates?  
- How have **inflation and CPI trends** varied across provinces?  

### 2. Inferential Analysis & Hypothesis Testing  
- Is there a **statistically significant** relationship between mental health disorders and suicide rates?  
- Do **certain demographic groups** have significantly higher suicide rates?  
- How have **inflation (CPI) and economic conditions** impacted suicide rates and mental health disorders?  

### 3. Predictive Analysis  
- Can we **predict high-risk groups** for suicide using mental health and economic indicators?  
- Which **mental health disorders** have the strongest correlation with suicide rates?  
- Which **machine learning model** (Random Forest, SVM, Logistic Regression) performs best for suicide risk prediction?  
- What are the most influential **factors (mental health, economic, demographic) in suicide risk**?  

### 4. Trend & Sentiment Analysis (Reddit Data Integration)  
- How does **public discourse on mental health** (Reddit sentiment) align with **suicide rates and disorder prevalence**?  
- Can **Reddit sentiment trends** be used as an early indicator of **emerging mental health crises**?  

---

## Data Sources  

| **Source** | **Dataset** | **Link** |
|------------|------------|----------|
| Government of Canada | Mental health indicators (2002–2022) | [StatCan Table 13-10-0465-01](https://open.canada.ca/data/dataset/a9863f45-6a1a-4277-ae0f-2d9cb61d413a/resource/2caa55d4-370c-41bc-a662-5ee67da3c074) |
| Government of Canada | Consumer Price Index (CPI) | [Statistics Canada](https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1810000401) |
| WHO | Global Suicide Rates | [WHO Global Health Data](https://www.who.int/data/gho) |
| Reddit | Mental health discussions (r/depression, r/anxiety) | Extracted via `RedditExtractoR` |

## Project Structure  
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

## Dataset  

The dataset consists of **160,992 records** across multiple years (2002, 2012, 2022) and includes:  

- **Mental Health Indicators:** Prevalence rates of conditions such as Depression, Anxiety, PTSD, and ADHD.  
- **Demographics:** Age groups, gender, and geographic location (province-level data).  
- **Economic Factors:** Inflation rates and Consumer Price Index (CPI) per province.  
- **Suicide Rates:** Number and percentage of suicides, categorized by age, gender, and region.  

## Methodology  

###  **Data Preprocessing**  
- **Handling missing data** through imputation techniques.  
- **Standardizing & normalizing** numerical data (CPI, inflation, suicide rates).  
- **Encoding categorical variables** (Province, Sex, Age Group).  

### **Machine Learning Models**  

| **Model** | **Purpose** |
|-----------|------------|
| **Logistic Regression** | Baseline model for **binary classification (high vs. low suicide risk)** |
| **Random Forest** | Identifying **feature importance and non-linear relationships** |
| **SVM (Support Vector Machine)** | Detecting complex patterns in **suicide risk classification** |

### **Sentiment Analysis on Reddit**  
- Extract Reddit posts from **r/depression, r/anxiety**.  
- **Perform Sentiment Analysis** using **VADER, TextBlob, or BERT-based models**.  
- **Compare sentiment trends** with actual suicide rates (correlation analysis).  
- **Topic Modeling (LDA)** to detect **key mental health themes**.  

### **Model Interpretation & Insights**  
- **Feature Importance** (Random Forest) to rank key predictors.  
- **SHAP (SHapley Additive Explanations)** for model interpretability.  
- **Visualization**: Heatmaps, Time-Series Charts, Word Clouds.  

## Author
Felix Vo
