🧠 ABL Training Engagement & Team Allocation Dashboard

(SQL + Power BI Project)

📌 Project Overview

This project analyzes training engagement data of 200+ participants to help management monitor performance, improve follow-ups, and plan training rooms efficiently.

Using SQL for data cleaning and analytics and Power BI for visualization, this solution provides a complete end-to-end business intelligence system for training operations.

🏢 Business Problem

ABL conducts training sessions across multiple cities. Management needs to:

Track who has replied vs not replied

Measure Assigned Lead performance

Ensure fair male/female distribution across teams

Support room planning by city & gender

Identify low engagement areas

This project solves all of these in one integrated dashboard.

📂 Dataset

The dataset contains training participant records, including:

Name

Gender

Email

Contact Number

Location

Assigned Lead

Mail Reply Status

Team Number

Raw data was inconsistent and required extensive cleaning before analysis.

🧹 Data Cleaning Using SQL

Key cleaning steps:

Removed invalid characters (Â, extra spaces)

Standardized gender values

Fixed incorrect Assigned Lead names

Converted missing replies to "No"

Validated email formats

Identified duplicate emails

Created gender-balanced team numbers using window functions

Example:

UPDATE training_analysis
SET name = SUBSTRING_INDEX(name,'â',1);

UPDATE training_analysis
SET mail_replied = 'No'
WHERE mail_replied IS NULL OR mail_replied = '';

📊 KPIs Created
Metric	Description
Total Participants	Total attendees
Replied	People who replied
Not Replied	Pending follow-ups
Reply Rate %	Engagement score
Lead Performance	Response rate by trainer
Gender Split	Male vs Female
Location Share	City-wise participation
Team Balance	Gender distribution per team
🧮 SQL Analytics Used

This project demonstrates real-world SQL including:

CASE WHEN

GROUP BY & HAVING

WINDOW FUNCTIONS (ROW_NUMBER, DENSE_RANK)

CTEs

VIEWS

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

