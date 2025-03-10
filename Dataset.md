# Dataset: Mental Health in Canada (2002-2022)

**File Name**: `mental_health_CAN_02-22.csv`
**Rows**: 1,609,931 · **Columns**: 18
**Format**: Longitudinal panel data (2002-2022)

---

## Dataset Overview

### Temporal Coverage

- **Full Range**: 2002-2022 (20-year span)
- **Measurement Frequency**: Annual
- **Reporting Periods**:
  - **Life**: Lifetime prevalence
  - **12 months**: Past-year incidence

### Geographic Scope

- **Coverage**: National (All Canadian territories)
- **Granularity**: Country-level aggregation

### Population Characteristics

- **Target Population**: Residents aged ≥15 years
- **Stratification**:
  - **Age Groups**:
    - Total (15+ years)
    - 15–24 years (Adolescent/Young Adult)
    - 25–64 years (Working Age)
  - **Gender Categories**:
    - Total (All genders)
    - Men+ (Male-identifying individuals)
    - Women+ (Female-identifying individuals)

---

## Data Structure & Variables

### Core Variables Table

| Column Name       | Description                                | Data Type | Example Values                        |
| ----------------- | ------------------------------------------ | --------- | ------------------------------------- |
| `REF_DATE`        | Reference year                             | Integer   | 2002, 2015, 2022                      |
| `GEO`             | Geographic location                        | Factor    | "Canada"                              |
| `Age group`       | Age categorization                         | Factor    | "15 to 24 years", "25-64 years"       |
| `Gender`          | Gender classification                      | Factor    | "Men+", "Women+"                      |
| `Indicators`      | Mental health metric (See full list below) | Factor    | "Major depressive episode, life"      |
| `Characteristics` | Measurement context                        | Factor    | "Low 95% confidence interval"         |
| `UOM`             | Unit of measurement                        | Factor    | "Number", "Percent"                   |
| `VALUE`           | Quantitative value                         | Numeric   | 3037049 (count), 12.2 (percentage)    |
| `SCALAR_FACTOR`   | Scaling factor for aggregated data         | Character | "units"                               |
| `STATUS/SYMBOL`   | Data quality flags                         | Character | "E" (High variance), "F" (Suppressed) |

---

## Key Mental Health Indicators

### Mental Health Conditions

#### Mood Disorders

- Major depressive episode (Life/12mo)
- Bipolar disorder (Life/12mo)
- Any mood disorder (Life/12mo)

#### Anxiety & Trauma

- Generalized anxiety disorder (Life/12mo)
- Social phobia (Life/12mo)
- PTSD (Current diagnosis)

#### Substance Use

- Cannabis use/abuse (Life/12mo)
- Alcohol abuse/dependence (Life/12mo)
- Other drug use (Excl. cannabis) (Life/12mo)

### Risk Factors & Outcomes

- Suicidal ideation (Life/12mo)
- Self-rated work stress levels:
  - High stress ("Quite a bit/extremely")
  - Moderate stress ("A bit")
  - Low stress ("Not at all/not very")

### Clinical Diagnoses

- Schizophrenia/Psychosis (Ever diagnosed)
- Eating disorders (Current diagnosis)
- ADHD (Current diagnosis)

### Perceptions & Utilization

- Self-rated mental health:
  - Very good/excellent
  - Good
  - Fair/poor
- Mental health service use (12mo)
- Unmet care needs:
  - No need
  - Needs met/partially met/unmet



