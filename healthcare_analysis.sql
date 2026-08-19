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
--Q1. How many records are in this data set?
SELECT COUNT(*) AS total_records
FROM patient_visits;

--Finding:
--The data set contains 9216 patient records

--=======================================

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
FROM patient_visits;

--Finding:
--By analzing the number of missing rows from each column in the date set we can conclude that the only column
--with NULL values is patient satisfaction score this will be important to remember when using functions like AVG and SUM

--=======================================

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
HAVING COUNT(*) > 1;

--Finding:
--There are no duplicate records

--=======================================

--Q4. Are the numerical values realistic?

SELECT 
MAX("Patient Age") AS max_patient_age,
MIN("Patient Age") AS min_patient_age,
MAX("Patient Satisfaction Score") AS max_satisfaction_score,
MIN("Patient Satisfaction Score") AS min_satisfaction_score,
MAX("Patient Waittime") AS max_patient_waittime,
MIN("Patient Waittime") AS min_patient_waittime
FROM patient_visits;

--Finding:
--From the data we see no outliers or negative values indicating realistic values in the data set
--Patient age is between 1 and 79
--Patient satisfaction is between 0 and 9
--Patient waittime is between 10 and 60 minutes

--=======================================

--Q5. Are the categorical values consistant?

SELECT DISTINCT "Patient Gender"
FROM patient_visits;

SELECT DISTINCT "Patient Race"
FROM patient_visits;

SELECT DISTINCT "Department Referral"
FROM patient_visits;

SELECT DISTINCT "Patient Admission Flag"
FROM patient_visits;

--Finding:
--There is only one inconsistant value being in the gender column
--This was a value of 'femaleemale' in the gender column which is most likely a typo will be corrected to just female

UPDATE patient_visits
SET "Patient Gender" = 'Female'
WHERE "Patient Gender" =  'Femaleemale';

--All inconsistant values have been corrected and errors have been fixed

--=======================================

------------------------------------------------------------
-- SECTION 2: BUSINESS ANALYSIS
------------------------------------------------------------

--Q1. Which departments have the most referrals

SELECT 
"Department Referral",
COUNT( *) AS number_of_referrals
FROM patient_visits
GROUP BY "Department Referral"
ORDER BY number_of_referrals DESC;

--Findings:
--After analyzing the data majority of patients did not need a referral (None = 5400)
--Following NONE was general practice at 1840 
--Then orthopedics at 995
--The lowest value was Renal at 86 referrals

=======================================

--Q2. Which department had the highest admission rate?

SELECT "Department Referral",  
COUNT(*) AS total_patients,
SUM (
CASE
WHEN "Patient Admission Flag" = 'Admission' THEN 1
ELSE 0
END) AS admitted_patients,
ROUND(SUM 
(CASE
WHEN "Patient Admission Flag" = 'Admission' THEN 1
ELSE 0
END)  *100.0 / COUNT(*), 
2) 
AS admission_percentage
FROM patient_visits
WHERE "Department Referral" != 'None'
GROUP BY "Department Referral"
ORDER BY admission_percentage DESC;

--Findings:
--The Renal department had the highest admission rate of 53.49%
--The average trend seemed to be a 50% admission percentage among departments
--The lowest admission percentage was general pactice at a rate of 48.21% however it was not an outlier still being close to the 50%


=======================================

--Q3. Which department has the longest average patient waittime?

SELECT "Department Referral",
COUNT(*) AS total_patients,
SUM (
CASE
WHEN "Patient Admission Flag" = 'Admission' THEN 1
ELSE 0
END) AS admitted_patients,
ROUND(AVG("Patient Waittime"), 2) AS average_patient_waittime
FROM patient_visits
GROUP BY "Department Referral"
ORDER BY average_patient_waittime DESC;


--Findings:
--The longest average waittime in was the Neurology department with an average waititime of 36.8 minutes
--The shortest was the Renal department at 34.7 minutes
--The spread between the departments was small with most departments hovering around 35 minutes suggesting fairly consistent waittimes across departments

=======================================

--Q.4 Which department has the highest overall patient satisfaction score?

SELECT "Department Referral" AS department,
ROUND(AVG("Patient Satisfaction Score"), 2) AS average_patient_satisfaction_score
FROM patient_visits
WHERE "Department Referral" != 'None'
GROUP BY "Department Referral"
ORDER BY average_patient_satisfaction_score DESC;


--Findings:
--The highest average patient satisfaction score Gastroenterology with a 5.8
--The lowest was Renal with a 4.57
--Overall satisfaction scores were quite low and improving patient satisfaction should be a priority moving forward

=======================================

--Q5. Is there a relationship between patient wait time and patient satisfaction?

SELECT "Department Referral" AS department,
ROUND(AVG("Patient Waittime"), 2) AS average_patient_waittime,
ROUND(AVG("Patient Satisfaction Score"), 2) AS average_patient_satisfaction_score
FROM patient_visits
WHERE "Department Referral" != 'None'
GROUP BY "Department Referral"
ORDER BY average_patient_waittime DESC;

--Findings:
--After analysing average patient waittimes and average satisfaction scores there does not appear to be a clear trend present
--There is does not appear to be a clear relationship present between a higher waittime and a lower satisfaction score

=======================================

--Q6. Which age group accounts for the largest proportion of hospital visits?

SELECT
CASE
WHEN "Patient Age" <= 17 THEN '0-17'
WHEN "Patient Age" >= 18 AND "Patient Age" <= 34 THEN '18-34'
WHEN "Patient Age" >= 35 AND "Patient Age" <= 49 THEN '35-49'
WHEN "Patient Age" >= 50 AND "Patient Age" <= 64 THEN '50-64'
ELSE '65+'
END AS age_category,
COUNT(*) AS number_of_patients,
ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM patient_visits),
        2
    ) AS proportion_of_visits
FROM patient_visits
GROUP BY
CASE
WHEN "Patient Age" <= 17 THEN '0-17'
WHEN "Patient Age" >= 18 AND "Patient Age" <= 34 THEN '18-34'
WHEN "Patient Age" >= 35 AND "Patient Age" <= 49 THEN '35-49'
WHEN "Patient Age" >= 50 AND "Patient Age" <= 64 THEN '50-64'
ELSE '65+'
END;

--Findings:
--Results show no significant difference in the proportion of visits between the groups
--The highest proportion appeared to be age group 0-17 at 21.39% and the lowest being 65+ at 18.84%

=======================================

--Q.7 How does average patient satisfaction differ between male and female patients across hospital departments?

SELECT "Department Referral",
"Patient Gender",
ROUND(AVG("Patient Satisfaction Score"),  2)  AS Average_Satisfaction_Score
FROM patient_visits
WHERE "Department Referral" != 'None'
GROUP BY "Department Referral", "Patient Gender"
ORDER BY "Department Referral", "Average_Satisfaction_Score" DESC;

--Findings:
--Female patients reported higher average satisfaction scores than male patients in most hospital departments
--The Renal department recorded the lowest satisfaction score with males having an average satisfaction of 4.21
--Neurology appears to have the largest difference in satisfaction scores between male and female patients with females having an average score of 5.79 and males with a 4.86 ( difference of 0.93)
--Orthopedics had the smallest difference between the genders with a difference of 0.16. Males had an average satisfaction score of 4.92 andfemales had an average score of 4.76
--Gastroenterology had consistant high scores with females at 5.9 and males at 5.67 suggesting a potentially more uniform and satisfiying patient experience in that department
