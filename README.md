# auto_insuranceclaims

The objective of this project is to conduct a data analysis of the auto insurance claims dataset using a series of specific SQL queries. The primary focus is to identify patterns and trends related to fraudulent claims, demographics, and accident details. This analysis will provide actionable insights that could help in risk assessment and fraud detection.

The project will use the following SQL components to achieve its goals:

CREATE TABLE: To set up the database schema for the claims data.

SELECT and FROM: To retrieve data from the table.

WHERE: To filter records based on specific criteria, such as fraudulent claims (fraud_reported = 'Y'), collision type, and other incident details.

GROUP BY: To aggregate data based on categorical columns like age group, incident state, and education level.

COUNT() and AVG(): To calculate the number of cases and average claim amounts for different groups.

CASE: To categorize ages into meaningful groups for analysis.

LIMIT: To retrieve a specific number of top results, such as the highest claim amounts or most common incident hours.

QUALIFY: To rank and filter results within partitions, specifically to find the most common collision type per state.

ROUND(): To round calculated values for clarity.

FILTER: To count specific conditions within an aggregate function, such as the number of fraudulent cases.
