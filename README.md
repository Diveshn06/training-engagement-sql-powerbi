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

📈 Power BI Dashboards
🔹 Page 1 – Engagement & Performance

Tracks:

Reply rate

Assigned Lead performance

Gender & location distribution

🔹 Page 2 – Team & Room Planning

Tracks:

Male vs Female per team

Balanced team allocation

City-wise room planning

These dashboards allow management to instantly see who needs follow-up and how to plan rooms effectively.

🧠 Business Impact

This dashboard helps ABL:

Identify low-performing trainers

Improve email follow-up efficiency

Ensure gender-balanced teams

Optimize room allocation

Enable data-driven training decisions

🛠 Tools Used
Tool	Purpose
MySQL	Data cleaning & analysis
SQL	Business logic & KPIs
Power BI	Interactive dashboards
Excel / CSV	Raw data

📁 Repository Structure
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

