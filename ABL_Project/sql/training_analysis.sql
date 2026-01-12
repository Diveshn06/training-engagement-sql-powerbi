USE abl_training;
SET SQL_SAFE_UPDATES = 1;
-- Remove unwanted/ unnecessary column
ALTER TABLE training_analysis
DROP COLUMN MyUnknownColumn ;

-- DATA CLEANING

ALTER TABLE training_analysis
CHANGE `NAME` name VARCHAR(50),
CHANGE `GENDER` gender VARCHAR(10),
CHANGE `EMAIL_ID` email VARCHAR(50),
CHANGE `LDC_UPLINE` assigned_lead VARCHAR(50),
CHANGE `Mail_Replied` mail_replied VARCHAR(50); 

UPDATE training_analysis 
SET name = TRIM(name);
UPDATE training_analysis
SET gender = TRIM(gender);

UPDATE training_analysis
SET 
email = TRIM(email),
Location = TRIM(Location),
assigned_lead = TRIM(assigned_lead),
mail_replied= TRIM(mail_replied);


UPDATE training_analysis
SET name = SUBSTRING_INDEX(name,'â',1);

UPDATE training_analysis
SET gender = SUBSTRING_INDEX(gender,'â',1);

UPDATE training_analysis
SET assigned_lead = SUBSTRING_INDEX(assigned_lead,'â',1);

UPDATE training_analysis
SET mail_replied = 'No'
WHERE mail_replied IS NULL OR mail_replied = '';

UPDATE training_analysis
SET assigned_lead = "Lakshay Sheoran"
WHERE assigned_lead LIKE "%Sheron";

-- check wethere the format of the mail is correct or not
SELECT * FROM training_analysis
WHERE email NOT LIKE "%.Com";

SELECT assigned_lead, COUNT(*)
FROM training_analysis
GROUP BY assigned_lead;

-- 1. Count the total number of participants in the dataset.
SELECT COUNT(*) AS Total_participants
FROM training_analysis;

-- 2. Display gender-wise attendance count.
SELECT gender, COUNT(*) AS Total_participants
FROM training_analysis
GROUP BY gender;


-- 3. Show location-wise participant count.
SELECT location, COUNT(*) AS Total_participants
FROM training_analysis
GROUP BY location;

-- 4. Calculate overall mail reply percentage.
SELECT ROUND(SUM(CASE WHEN mail_replied = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS mail_reply_perc
FROM training_analysis;
        -- or using subquery
SELECT ROUND(((SELECT COUNT(*) FROM training_analysis
WHERE mail_replied = 'Yes')*100)/COUNT(*),2) AS mail_reply_perc FROM training_analysis;

-- 5. Show gender-wise replied vs not replied count.
SELECT gender, ROUND(SUM(CASE WHEN mail_replied = 'Yes' THEN 1 ELSE 0 END ),2) AS replied,
ROUND(SUM(CASE WHEN mail_replied = 'No' THEN 1 ELSE 0 END ),2) AS not_replied
FROM training_analysis
GROUP BY gender;

-- 6. Display Assigned_Lead-wise total participants.
SELECT assigned_lead, COUNT(*) AS total_participants FROM training_analysis
GROUP BY assigned_lead
ORDER BY total_participants DESC;

-- 7. Calculate Assigned_Lead-wise reply rate percentage.
SELECT assigned_lead, ROUND((SUM(CASE WHEN mail_replied = 'Yes' THEN 1 ELSE 0 END)*100)/COUNT(*),2) AS reply_rate_perc
FROM training_analysis
GROUP BY assigned_lead
ORDER BY reply_rate_perc;

-- 8. Find Assigned_Leads with reply rate less than 50%.
SELECT assigned_lead, ROUND((SUM(CASE WHEN mail_replied = 'Yes' THEN 1 ELSE 0 END)*100)/COUNT(*),2) AS reply_rate_perc
FROM training_analysis
GROUP BY assigned_lead
HAVING reply_rate_perc < 50
ORDER BY reply_rate_perc;

-- 9. Rank Assigned_Leads based on reply rate.
WITH X AS (SELECT assigned_lead, ROUND((SUM(CASE WHEN mail_replied = 'Yes' THEN 1 ELSE 0 END)*100)/COUNT(*),2) AS reply_rate_perc
FROM training_analysis
GROUP BY assigned_lead
ORDER BY reply_rate_perc DESC)
SELECT assigned_lead, reply_rate_perc, DENSE_RANK() OVER(ORDER BY reply_rate_perc DESC) AS Rnk
FROM X;


-- 10. Identify the top 3 Assigned_Leads by engagement.
SELECT assigned_lead, COUNT(*) AS total_assigned_participants
FROM training_analysis 
GROUP BY assigned_lead
ORDER BY total_assigned_participants DESC 
LIMIT 3;

-- 11. Show location-wise reply rate.
SELECT Location, ROUND((SUM(CASE WHEN mail_replied = 'Yes' THEN 1 ELSE 0 END)*100)/COUNT(*),2) AS reply_rate_perc
FROM training_analysis
GROUP BY Location
ORDER BY reply_rate_perc DESC;


-- 12. List participants who have not replied and require follow-up.
SELECT name, assigned_lead, contact_no, mail_replied
FROM training_analysis
WHERE mail_replied = "No";


-- 13. Identify duplicate email IDs in the dataset.
SELECT email, COUNT(*)
FROM training_analysis
GROUP BY email
HAVING COUNT(*) > 1;


-- 14. Assign participants into 8 balanced teams based on gender.
WITH X AS (SELECT * , ROW_NUMBER() OVER(PARTITION BY gender ORDER BY name) AS rnk
FROM training_analysis)
SELECT *,((rnk-1)%10) + 1 AS team_no
FROM X;

-- Assigned team permanently
ALTER TABLE training_analysis
ADD COLUMN team_no INT; 
UPDATE training_analysis AS t
JOIN ( SELECT email, ((ROW_NUMBER()OVER(PARTITION BY gender ORDER BY email)-1)%10) +1 AS team_no 
FROM training_analysis) AS x
ON x.email = t.email
SET t.team_no = x.team_no;



-- 15. Show team-wise male and female count.
SELECT team_no,gender,COUNT(*) AS total_count
FROM training_analysis
GROUP BY team_no, gender
ORDER BY team_no;

-- 16. Calculate percentage contribution of each location to total participants.
SELECT location, ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM training_analysis),2) AS contribution_perc
FROM training_analysis
GROUP BY location;


-- 17. Find the city with the highest response rate.
SELECT location, ROUND(SUM((CASE WHEN mail_replied = 'Yes' THEN 1 ELSE 0 END)*100.0)/COUNT(*),2) AS response_rate
FROM training_analysis
GROUP BY location
ORDER BY response_rate DESC
LIMIT 1;

-- 18. Create a SQL view showing Assigned_Lead-wise engagement summary.
CREATE OR REPLACE VIEW assigned_lead_engagment AS 
SELECT assigned_lead, COUNT(*) AS total_participants
FROM training_analysis
GROUP BY assigned_lead
ORDER BY total_participants DESC;

SELECT * FROM assigned_lead_engagment;

-- 19. Display participants grouped by location and gender.
CREATE OR REPLACE VIEW participants_groupedby_location_gender AS
SELECT location, gender, COUNT(*) AS total_participants
FROM training_analysis
GROUP BY location, gender
ORDER BY total_participants DESC;

SELECT * FROM participants_groupedby_location_gender;


-- 20. Identify Assigned_Leads managing participants from more than 2 locations
SELECT assigned_lead, COUNT(DISTINCT location) AS total_locations
FROM training_analysis
GROUP BY assigned_lead
HAVING COUNT(DISTINCT location) > 2;



