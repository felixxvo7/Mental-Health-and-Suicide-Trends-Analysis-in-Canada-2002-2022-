# AI-Driven Mental Health Trend Analysis & Prediction Using R

## Project Plan

### **Phase 1: Project Setup & Data Collection**
#### 1. Initialize Repository  
- Set up a GitHub repository with the folder structure.
- Create a `README.md` with project goals, dataset sources, and setup instructions.

#### 2. Data Acquisition  
- Download datasets from Statistics Canada and WHO.
- Use `RedditExtractoR` to scrape Reddit posts related to mental health.
- Store raw data in the `data/raw/` folder.

#### 3. Environment Setup  
- Ensure R (4.3.2) is installed with required packages (`dplyr`, `ggplot2`, `caret`, etc.).
- Set up a virtual environment using `renv` for dependency management.

---

### **Phase 2: Data Preprocessing & Exploratory Data Analysis (EDA)**
#### 4. Preprocessing & Cleaning (`scripts/1_data_preprocessing.R`)
- Handle missing values, outliers, and inconsistent data formats.
- Merge datasets into a single structured format (`data/processed/merged_data.csv`).

#### 5. Exploratory Data Analysis (`scripts/2_eda.R`)
- Generate visualizations of suicide trends by age, gender, and economic indicators.
- Perform geospatial analysis (heatmaps for suicide rates per province).
- Correlation analysis between suicide rates and inflation/mental health indicators.

---

### **Phase 3: Modeling & Predictions**
#### 6. Suicide Rate Forecasting with SARIMAX (`scripts/3_modeling.R`)
- Train a **SARIMAX model** to forecast suicide rates using inflation and economic indicators.
- Evaluate model performance using RMSE and AIC/BIC scores.
- Save the trained model in `models/sarimax_model.rds`.
- **Segmented SARIMAX Analysis:**
  - Train separate SARIMAX models for different **age groups** (e.g., 15-24, 25-44, 45-64, 65+).
  - Fit models for **male vs. female** trends.
  - Perform **regional** forecasting by province/territory.
  - Analyze trends based on **economic vulnerability** (low-income vs. high-income groups).
  - Examine mental health patterns in **Indigenous communities** vs. the general population.

#### 7. High-Risk Group Prediction using Logistic Regression
- Train a logistic regression model to classify high-risk demographics.
- Feature selection and performance evaluation (AUC, Precision-Recall).
- Save the trained model in `models/logistic_model.rds`.

---

### **Phase 4: Sentiment Analysis & NLP**
#### 8. Reddit Sentiment Analysis (`scripts/4_sentiment_analysis.R`)
- Perform text preprocessing (tokenization, stop-word removal).
- Use `tidytext` to calculate sentiment scores over time.
- Visualize sentiment trends in relation to real-world events (e.g., pandemic).

---

### **Phase 5: Dashboard & Visualization**
#### 9. Develop a Shiny Dashboard (`app/app.R`)
- **Tabs for:**  
  - Suicide trends over time  
  - Forecasting results  
  - High-risk demographics  
  - Sentiment analysis visualizations  
- Deploy on **ShinyApps.io** or local hosting.

---

### **Phase 6: Deployment & Documentation**
#### 10. Code Optimization & Documentation
- Add comments and explanations in scripts.
- Create a `requirements.txt` for package dependencies (`renv::snapshot()`).

#### 11. Final Report & Presentation
- Prepare insights, findings, and recommendations based on analysis.
- Create a research paper or blog post summarizing key trends.

