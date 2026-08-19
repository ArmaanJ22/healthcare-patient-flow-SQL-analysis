
# Healthcare Patient Flow Analysis Using SQL

## Project Overview

This project analyzes a healthcare patient flow dataset using SQL to identify trends in hospital operations, patient admissions, wait times, and patient satisfaction.

The project begins with data cleaning  before progressing into business analysis that answer operational questions using SQL. The goal is to generate meaningful business insights from the healthcare dataset.

---


# Repository Structure

```text
healthcare-patient-flow-sql-analysis/
│
├── README.md
├── healthcare_analysis.sql
└── healthcare_analytics_patient_flow_data.csv
```

---

## Tools Used

- SQLite
- DB Browser for SQLite
- SQL

---

## Skills Demonstrated

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- Aggregate Functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)
- CASE Statements
- ROUND()
- Data Cleaning
- Subqueries
- Business Data Analysis

---

# Dataset

The dataset contains **9,216 patient visit records** and includes the following information:

- Patient ID
- Admission Date
- Admission Time
- Patient Gender
- Patient Age
- Patient Race
- Department Referrals
- Admission Status
- Patient Satisfaction Scores
- Patient Wait Times

The project uses this dataset to perform data cleaning, exploratory analysis, and answer business-oriented healthcare questions using SQL.

**Note:** 

-This project focuses on SQL analysis and business insights. The dataset was obtained from Kaggle and was not created by the author of this repository.
---

# Data Quality Assessment

Before performing any business analysis, the dataset was evaluated to ensure the information was complete, accurate, and suitable for analysis.

The following data quality checks were performed:

| Check | Result |
|-------|--------|
| Total Records | 9,216 |
| Missing Values | Only the **Patient Satisfaction Score** column contained NULL values |
| Duplicate Records | No duplicate patient visits were identified |
| Numerical Ranges | All values fell within expected ranges (Age: 1–79, Satisfaction: 0–9, Wait Time: 10–60 minutes) |
| Categorical Consistency | One inconsistent gender value (`Femaleemale`) was identified and corrected |

---

# Business Questions & Findings

The following business questions were explored using SQL to better understand hospital operations and patient experience.

## 1. Which departments receive the most referrals?

**Findings**

General Practice received the highest number of referrals (1,840), followed by Orthopedics (995). Renal received the fewest referrals (86).

---

## 2. Which department has the highest admission rate?

**Findings**

The Renal department recorded the highest admission rate at **53.49%**, however the average trend seemed to be a 50% admission percentage among departments

---

## 3. Which department has the longest average patient wait time?

**Findings**

The longest average wait time in was the Neurology department with an average waiti time of **36.8 minutes**, while Renal had the shortest at **34.7 minutes**. Overall, wait times were relatively consistent across departments.

---

## 4. Which department has the highest patient satisfaction?

**Findings**

Gastroenterology achieved the highest average patient satisfaction score (**5.80**), while Renal recorded the lowest (**4.57**).

---

## 5. Is there a relationship between patient wait time and patient satisfaction?

**Findings**

No clear relationship was observed between average patient wait time and patient satisfaction across departments.

---

## 6. Which age group accounts for the largest proportion of hospital visits?

**Findings**

Results show no significant difference in the proportion of visits between the groups, with the highest proportion appeared to be age group 0-17 at 21.39% and the lowest being 65+ at 18.84%. 

---

## 7. How does patient satisfaction differ between male and female patients across hospital departments?

**Findings**

Female patients reported higher average satisfaction scores than male patients in most departments. Neurology showed the largest gender difference, while Gastroenterology maintained consistently high satisfaction scores across both genders.

---

# Key Business Insights

Based on the analysis, several operational insights were identified:

- General Practice received the highest referral volume, indicating the greatest demand for services.
- Renal recorded the highest admission rate but the lowest average patient satisfaction score, suggesting improving patient experience within the department.
- Neurology had the longest average patient wait time, although wait times were relatively consistent across departments.
- Gastroenterology consistently achieved the highest patient satisfaction scores across both male and female patients.
- No clear relationship was observed between average patient wait time and patient satisfaction, suggesting that additional factors may influence the overall patient experience.
- Female patients reported higher average satisfaction scores than male patients in most departments. This trend indicates that operations may need to be changed to improve male satisfaction scores
