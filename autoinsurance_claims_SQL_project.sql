CREATE TABLE autoinsurance_claims (
    months_as_customer INT,
    age INT,
    policy_number INT,
    policy_bind_date DATE,
    policy_state VARCHAR(10),
    policy_csl VARCHAR(20),
    policy_deductable INT,
    policy_annual_premium DECIMAL(10,2),
    umbrella_limit BIGINT,
    insured_zip INT,
    insured_sex VARCHAR(10),
    insured_education_level VARCHAR(50),
    insured_occupation VARCHAR(50),
    insured_hobbies VARCHAR(50),
    insured_relationship VARCHAR(50),
    capital_gains INT,
    capital_loss INT,
    incident_date DATE,
    incident_type VARCHAR(50),
    collision_type VARCHAR(50),
    incident_severity VARCHAR(50),
    authorities_contacted VARCHAR(50),
    incident_state VARCHAR(10),
    incident_city VARCHAR(50),
    incident_location VARCHAR(100),
    incident_hour_of_the_day INT,
    number_of_vehicles_involved INT,
    property_damage VARCHAR(10),
    bodily_injuries INT,
    witnesses INT,
    police_report_available VARCHAR(10),
    total_claim_amount INT,
    injury_claim INT,
    property_claim INT,
    vehicle_claim INT,
    auto_make VARCHAR(50),
    auto_model VARCHAR(50),
    auto_year INT,
    fraud_reported CHAR(1)
);

------------------------------------
Select * from autoinsurance_claims
----------------------------------
--Average Claim Amount per State

SELECT incident_state, ROUND(AVG(total_claim_amount),2) AS avg_claim
FROM autoinsurance_claims
GROUP BY incident_state
ORDER BY avg_claim DESC;

-----Top 5 Vehicle Makes Involved in Accidents
SELECT auto_make, COUNT(*) AS num_accidents
FROM autoinsurance_claims
GROUP BY auto_make
ORDER BY num_accidents DESC
LIMIT 5;

-------Fraud Cases by Incident Severity
SELECT incident_severity, 
       COUNT(*) FILTER (WHERE fraud_reported = 'Y') AS fraud_cases,
       COUNT(*) AS total_cases,
       ROUND(100.0 * COUNT(*) FILTER (WHERE fraud_reported = 'Y') / COUNT(*),2) AS fraud_percentage
FROM autoinsurance_claims
GROUP BY incident_severity;

------Average Premium vs Claim Amount
SELECT ROUND(AVG(policy_annual_premium),2) AS avg_premium,
       ROUND(AVG(total_claim_amount),2) AS avg_claim
FROM autoinsurance_claims;

------Claims by Age Group
SELECT CASE 
         WHEN age < 25 THEN 'Under 25'
         WHEN age BETWEEN 25 AND 40 THEN '25-40'
         WHEN age BETWEEN 41 AND 60 THEN '41-60'
         ELSE '60+'
       END AS age_group,
       ROUND(AVG(total_claim_amount),2) AS avg_claim
FROM autoinsurance_claims
GROUP BY age_group
ORDER BY avg_claim DESC;

------Most Common Collision Type per State
SELECT incident_state, collision_type, COUNT(*) AS num_cases
FROM autoinsurance_claims
WHERE collision_type <> '?'
GROUP BY incident_state, collision_type
QUALIFY ROW_NUMBER() OVER (PARTITION BY incident_state ORDER BY COUNT(*) DESC) = 1;

------Witness Impact on Fraud
SELECT witnesses, 
       COUNT(*) FILTER (WHERE fraud_reported = 'Y') AS fraud_cases,
       COUNT(*) AS total_cases
FROM autoinsurance_claims
GROUP BY witnesses
ORDER BY witnesses;

-----Hour of the Day with Highest Accidents
SELECT incident_hour_of_the_day, COUNT(*) AS num_incidents
FROM autoinsurance_claims
GROUP BY incident_hour_of_the_day
ORDER BY num_incidents DESC
LIMIT 5;

------Education Level vs Fraud
SELECT insured_education_level,
       COUNT(*) FILTER (WHERE fraud_reported = 'Y') AS fraud_cases,
       COUNT(*) AS total_cases,
       ROUND(100.0 * COUNT(*) FILTER (WHERE fraud_reported = 'Y') / COUNT(*),2) AS fraud_rate
FROM autoinsurance_claims
GROUP BY insured_education_level
ORDER BY fraud_rate DESC;

-----Relationship Status and Claim Size
SELECT insured_relationship,
       ROUND(AVG(total_claim_amount),2) AS avg_claim
FROM autoinsurance_claims
GROUP BY insured_relationship
ORDER BY avg_claim DESC;






