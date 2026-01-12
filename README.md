# ABL Training Engagement & Team Allocation Dashboard

## Project Overview  
This project analyzes training engagement data of more than 200 participants to help management track performance, follow-ups, and team allocation.  
SQL is used for data cleaning and analytics, and Power BI is used to build interactive dashboards.

The goal is to help the training team understand who has replied, who needs follow-up, and how participants should be distributed across teams and rooms.

---

## Business Problem  

ABL conducts training sessions across multiple cities. Management needs to:

Track who replied and who did not  
Measure Assigned Lead performance  
Ensure balanced male and female teams  
Support room planning by city and gender  
Identify low engagement locations  

This project solves all these problems in one integrated analytics system.

---

## Dataset  

The dataset contains training participant records with the following fields:

Name  
Gender  
Email  
Contact Number  
Location  
Assigned Lead  
Mail Replied  
Team Number  

The raw data had spelling errors, extra spaces, invalid characters, and missing values. All of this was cleaned using SQL.

---

## Data Cleaning (SQL)

The following actions were performed using SQL:

Trimmed extra spaces from text fields  
Removed special characters like Â  
Standardized gender values  
Fixed incorrect Assigned Lead names  
Converted NULL and blank replies to "No"  
Validated email formats  
Detected duplicate emails  
Assigned balanced team numbers by gender  

Example:

UPDATE training_analysis
SET name = SUBSTRING_INDEX(name,'â',1);

UPDATE training_analysis
SET mail_replied = 'No'
WHERE mail_replied IS NULL OR mail_replied = '';


---

## KPIs Created  

Total Participants  
Replied  
Not Replied  
Reply Rate (%)  
Assigned Lead Performance  
Gender Distribution  
Location Contribution  
Team-wise Male/Female Count  

---

## SQL Analysis  

This project uses real business-grade SQL concepts:

CASE WHEN  
GROUP BY and HAVING  
Window functions (ROW_NUMBER, DENSE_RANK)  
CTEs  
Views  
Percentage calculations  
Duplicate detection  

Example:

SELECT assigned_lead,
ROUND(SUM(CASE WHEN mail_replied='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS reply_rate
FROM training_analysis
GROUP BY assigned_lead;

 
---

## 📈Power BI Dashboard  

The Power BI dashboard contains two main pages:

Page 1 – Engagement Analysis  
Shows total participants, replied vs not replied, reply rate, Assigned Lead performance, and gender & location distribution.

Page 2 – Team & Room Planning  
Shows male vs female per team, balanced team allocation, and city-wise participant distribution.

These dashboards help management plan training rooms and prioritize follow-ups.

---

## Business Impact  

This project helps ABL to:

Identify low-performing trainers  
Improve follow-up efficiency  
Ensure gender-balanced teams  
Plan training rooms by city  
Make data-driven decisions  

---

## Tools Used  

MySQL  
SQL  
Power BI  
Excel / CSV  

---

## Repository Structure  


ABL_Project/
│
├── dataset/
│   └── training_data.csv
├── sql/
│   └── training_analysis.sql
├── images/
│   ├── dashboard_page1.png
│   └── dashboard_page2.png
├── powerbi/
│   └── ABL_Dashboard.pbix
└── README.md

## 📊 Dashboard Preview

### Engagement & Performance
![Engagement Dashboard](ABL_Project/images/dashboard_page1.png)

### Team & Room Planning
![Team Planning](ABL_Project/images/dashboard_page2.png)

