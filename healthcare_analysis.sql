-- ==========================================================
-- Healthcare Patient Flow Analysis
-- Author: Armaan Jangi
-- ==========================================================

-- Project:
-- Analyze healthcare patient flow data using SQL to identify
-- operational trends in referrals, admissions, wait times,
-- and patient satisfaction.

------------------------------------------------------------
-- SECTION 1: DATA QUALITY ASSESSMENT
------------------------------------------------------------
-Q1. How many records are in this data set?
SELECT COUNT(*) AS total_records
FROM patient_visits

--Finding:
--The data set contains 9216 patient records

=======================================

--Q2. Are there missing values?

SELECT COUNT(*) AS total_rows,
COUNT(*) - COUNT("Patient Id") AS missing_ID,
COUNT(*) - COUNT("Patient Admission Date") AS missing_date,
COUNT(*) - COUNT("Patient Admission Time") AS missing_patient_time,
COUNT(*) - COUNT("Merged") AS missing_name,
COUNT(*) - COUNT("Patient Gender") AS missing_gender,
COUNT(*) - COUNT("Patient Age") AS missing_age,
COUNT(*) - COUNT("Patient Race") AS missing_patient_race,
COUNT(*) - COUNT("Department Referral") AS missing_referral,
COUNT(*) - COUNT("Patient Admission Flag") AS missing_admission_flag,
COUNT(*) - COUNT("Patient Satisfaction Score") AS missing_satisfaction,
COUNT(*) - COUNT("Patient Waittime") AS missing_waittime
FROM patient_visits

--Finding:
--By analzing the number of missing rows from each column in the date set we can conclude that the only column
--with NULL values is patient satisfaction score this will be important to remember when using functions like AVG and SUM

=======================================

--Q3. Are there duplicate records?

SELECT
    "Patient ID",
    "Patient Admission Date",
    "Patient Admission Time",
    COUNT(*) AS record_count
FROM patient_visits
GROUP BY
    "Patient ID",
    "Patient Admission Date",
    "Patient Admission Time"
HAVING COUNT(*) > 1

--Finding:
--There are no duplicate records

=======================================

--Q4. Are the numerical values realistic?

SELECT 
MAX("Patient Age") AS max_patient_age,
MIN("Patient Age") AS min_patient_age,
MAX("Patient Satisfaction Score") AS max_satisfaction_score,
MIN("Patient Satisfaction Score") AS min_satisfaction_score,
MAX("Patient Waittime") AS max_patient_waittime,
MIN("Patient Waittime") AS min_patient_waittime
FROM patient_visits

--Finding:
--From the data we see no outliers or negative values indicating realistic values in the data set
--Patient age is between 1 and 79
--Patient satisfaction is between 0 and 9
--Patient waittime is between 10 and 60 minutes

=======================================

--Q5. Are the categorical values consistant?

SELECT DISTINCT "Patient Gender"
FROM patient_visits

SELECT DISTINCT "Patient Race"
FROM patient_visits

SELECT DISTINCT "Department Referral"
FROM patient_visits

SELECT DISTINCT "Patient Admission Flag"
FROM patient_visits

--Finding:
--There is only one inconsistant value being in the gender column
--This was a value of 'femaleemale' in the gender column which is most likely a typo will be corrected to just female

UPDATE patient_visits
SET "Patient Gender" = 'Female'
WHERE "Patient Gender" =  'Femaleemale'

--All inconsistant values have been corrected and errors have been fixed

=======================================

