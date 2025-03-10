# Dataset: Mental Health in Canada (2002- 2022)

**File Name**: `mental health CAN 02-22.csv`

Columns : 18

Rows: 1609931

------------------------------------------------------------------------

## **Dataset Overview**

-   **Period** : 10 years (2012) , 20 years (2022)

<!-- -->

-   **Geographic Coverage**: Canada (national level) , all terraroties.\
-   **Target Population**: Individuals aged **15 years and older**.\
-   **Demographic Breakdown**:
    -   **Age Groups**:
        -   Total (15+ years)
        -   15–24 years
        -   25–64 years\
    -   **Gender Categories**:
        -   Total (all genders)
        -   Men+
        -   Women+

------------------------------------------------------------------------

## **Key Variables**

| Column Name | Description | Example Values |
|----|----|----|
| `REF_DATE` | Reference year | `2002` |
| `GEO` | Geographic location | `Canada` |
| `Age group` | Age range of respondents | `"Total, 15 years and over"`, `"15 to 24 years"` |
| `Gender` | Gender classification | `"Total, gender of person"`, `"Men+"`, `"Women+"` |
| `Indicators` | Mental health condition or behavior measured | `"Major depressive episode, life"`, `"Cannabis use, 12 months"` |
| `Characteristics` | Subtype of measurement (e.g., confidence intervals) | `"Low 95% confidence interval, number of persons"` |
| `UOM` | Unit of measurement | `Number`, `Percent` |
| `VALUE` | Numerical value (count or percentage) | `3037049`, `12.2` |
| `STATUS`/`SYMBOL` | Data quality flags (e.g., `E` = high variability, `F` = suppressed) | `E`, `F` |

------------------------------------------------------------------------

## **Key Indicators & Metrics**

### 1. **Major Depressive Episode**

-   **Lifetime Prevalence**:
    -   Total (15+ years): **3,037,049 persons** (12.2%).\
    -   Men+: **1,125,806 persons** (9.2%).\
    -   Women+: **1,911,243 persons** (15.1%).\
-   **12-Month Prevalence**:
    -   Total (15+ years): **1,195,955 persons** (4.8%).

### 2. **Cannabis Use**

-   **Lifetime Use**:
    -   Total (15+ years): **10,315,481 persons** (41.3%).\
    -   Men+: **5,757,706 persons** (47%).\
    -   Women+: **4,557,775 persons** (35.9%).\
-   **12-Month Use**:
    -   Total (15+ years): **3,049,068 persons** (12.2%).

### 3. **Suicidal Thoughts**

-   **Lifetime Prevalence**:
    -   Total (15+ years): **3,345,344 persons** (13.4%).\
    -   Men+: **1,507,262 persons** (12.3%).\
    -   Women+: **1,838,083 persons** (14.5%).\
-   **12-Month Prevalence**:
    -   Total (15+ years): **919,795 persons** (3.7%).

### 4. **Perceived Mental Health**

-   **"Very Good or Excellent"**:
    -   Total (15+ years): **16,752,154 persons** (67.1%).\
-   **"Fair or Poor"**:
    -   Total (15+ years): **1,715,204 persons** (6.9%).

### 5. **Work-Related Stress**

-   **"Quite a Bit/Extremely Stressful" Days**:
    -   Total (15+ years): **5,479,419 persons** (30.7%).

------------------------------------------------------------------------

## **Data Quality Notes**

1.  **Confidence Intervals**: Provided for most estimates (e.g., lifetime major depressive episode: 2,913,405–3,160,692 persons).\
2.  **Coefficient of Variation (CV)**:
    -   High CV (\>33%) indicates lower precision (e.g., 12-month suicidal thoughts: CV = 44%).\
    -   Low CV (\<15%) indicates higher reliability (e.g., perceived mental health "very good": CV = 5%).\
3.  **Symbols**:
    -   `E`: High variability (e.g., eating disorder estimates).\
    -   `F`: Suppressed data (e.g., PTSD in some age/gender groups).
