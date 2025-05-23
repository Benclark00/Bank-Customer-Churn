-- Data Cleaning Process

-- Examine data
/*select top 10 * 
from ChurnRecords;*/

-- Removing Unnecessary Personal Information 
/*Alter table ChurnRecords
drop column Surname;*/

-- Check to ensure Surname column was removed
/*select top 10 * 
from ChurnRecords;*/

--Drop RowNumber column
/*Alter table ChurnRecords
drop column RowNumber;*/

-- Validate column was removed
/*select top 10 * 
from ChurnRecords;*/

-- Round Balance and Salary Columns to 2 decimal places
/*Update ChurnRecords
set Balance = round(Balance, 2), EstimatedSalary = round(EstimatedSalary, 2)

-- Validate columns were updated
select top 10 * 
from ChurnRecords;*/


-- Exploratory Data Analysis

-- See which country has the highest percentage of churned customers
/*select Geography, concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by Geography
order by '% Total Churned' desc;*/

-- Germany is at a churn rate more than double Spain and France

-- Examining Churn Rate versus making Complaints 
/*select CASE 
	WHEN Complain = 1 THEN 'YES'
	ELSE 'NO'
	END AS HasComplaints,
	concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by CASE 
	WHEN Complain = 1 THEN 'YES'
	ELSE 'NO'
	END
order by '% Total Churned' desc;*/

-- Unsurprinsingly those without complaints don't tend to churn based on the data


-- Investigating Churn By Gender
/*select Gender, concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by Gender
order by '% Total Churned' desc;*/

-- Interestingly a greater percentage of churned customers are female

--Investigating Churn By Gender and Country
/*Select Geography,
	   Gender,
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by Geography, Gender
order by '% Total Churned' desc;*/

-- It looks this churn rate difference in genders is really negligible except for Germany, which is the leading country for churn

-- Checking churn rate by number of products and gender in Germany
/*select NumOfProducts, 
	   Gender,
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
where Geography = 'Germany'
group by NumOfProducts, Gender
order by NumOfProducts desc;*/

-- This is really odd, for some reason in Germany it looks like users with more products are more likely to churn. It also looks like the optimal number of product may be two or at least it is in Germany.

-- Examining Churn Rate based on number of products and gender in all countries
/*select NumOfProducts, 
	   Gender,
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by NumOfProducts, Gender
order by NumOfProducts desc;*/

-- This trend, of two being the optimal number of products, appears to be true for all Countries based on the dataset

-- Examining Churn Rate by Card Type
/*select Card_Type,
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by Card_Type;*/

-- Card Type Appears to have no effect on Churn Rate

-- Examing Churn Rate by Points_Earned (the min value is 119 and the max value is 1000)
/*Select CASE
	   WHEN Point_Earned > 100 AND Point_Earned <= 250 THEN '100-250'
	   WHEN Point_Earned > 250 AND Point_Earned <= 500 THEN '251-500'
	   WHEN Point_Earned > 500 AND Point_Earned <= 750 THEN '501-750'
	   ELSE '751-1000'
	   END AS 'Point Bracket',
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by CASE
	   WHEN Point_Earned > 100 AND Point_Earned <= 250 THEN '100-250'
	   WHEN Point_Earned > 250 AND Point_Earned <= 500 THEN '251-500'
	   WHEN Point_Earned > 500 AND Point_Earned <= 750 THEN '501-750'
	   ELSE '751-1000'
	   END
order by 'Point Bracket';*/

-- Points seem to have no effect on the churn rate

-- Examining Tenure brackets and Churn Rate (the min value is 0 and the max value is 10)
/*select CASE
	   WHEN Tenure >= 0 AND Tenure < 3 THEN '0-2 years'
	   WHEN Tenure >= 3 AND Tenure < 5 THEN '3-4 years'
	   WHEN Tenure >= 5 AND Tenure < 7 THEN '5-6 years'
	   WHEN Tenure >= 7 AND Tenure < 9 THEN '7-8 years'
	   ELSE '9-10 years'
	   END AS 'Tenure Bracket',
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by CASE
	   WHEN Tenure >= 0 AND Tenure < 3 THEN '0-2 years'
	   WHEN Tenure >= 3 AND Tenure < 5 THEN '3-4 years'
	   WHEN Tenure >= 5 AND Tenure < 7 THEN '5-6 years'
	   WHEN Tenure >= 7 AND Tenure < 9 THEN '7-8 years'
	   ELSE '9-10 years'
	   END
order by 'Tenure Bracket';*/

-- Tenure doesn't seem to have an effect on how likely people are to switch banks

-- Checking Satisfaction_Score (out of 5) by Churn Rate
/*select Satisfaction_Score,
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by Satisfaction_Score
order by Satisfaction_Score;*/

-- Satisfaction interestingly has no effect on Churn Rate

-- Churn Rate Versus Credit Score Bracket (MIN 350 and MAX 850)
/*select CASE
	   WHEN CreditScore >= 350 AND CreditScore < 450 THEN '350-449'
	   WHEN CreditScore >= 450 AND CreditScore < 550 THEN '450-549'
	   WHEN CreditScore >= 550 AND CreditScore < 650 THEN '550-649'
	   WHEN CreditScore >= 650 AND CreditScore < 750 THEN '650-749'
	   ELSE '750-850'
	   END AS  'Credit Bracket',
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by CASE
	   WHEN CreditScore >= 350 AND CreditScore < 450 THEN '350-449'
	   WHEN CreditScore >= 450 AND CreditScore < 550 THEN '450-549'
	   WHEN CreditScore >= 550 AND CreditScore < 650 THEN '550-649'
	   WHEN CreditScore >= 650 AND CreditScore < 750 THEN '650-749'
	   ELSE '750-850'
	   END
order by 'Credit Bracket';*/

-- The lower credit bracket seems to be slightly more likely to churn

-- Checking Churn Rate versus balance brackts

/*select case
	   when Balance >=0 AND Balance < 50000 then '$0-$50,000'
	   when Balance >= 50000 AND Balance < 100000 then '$50,000-$99,999'
	   when Balance >= 100000 AND Balance < 150000 then '$100,000-$149,999'
	   when Balance >= 150000 AND Balance < 199999 then '$150,000-$199,999'
	   else 'Over $200,000'
	   end as 'BalanceBracket',
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by case
	   when Balance >=0 AND Balance < 50000 then '$0-$50,000'
	   when Balance >= 50000 AND Balance < 100000 then '$50,000-$99,999'
	   when Balance >= 100000 AND Balance < 150000 then '$100,000-$149,999'
	   when Balance >= 150000 AND Balance < 199999 then '$150,000-$199,999'
	   else 'Over $200,000'
	   end
order by 'BalanceBracket';*/

-- When Customers reach over $200,000 it seems that they are more likely to churn

-- Estimated Salary Versus Churn Rate

/*select case
	   when EstimatedSalary >=0 AND EstimatedSalary < 50000 then '$0-$50,000'
	   when EstimatedSalary >= 50000 AND EstimatedSalary < 100000 then '$50,000-$99,999'
	   when EstimatedSalary >= 100000 AND EstimatedSalary < 150000 then '$100,000-$149,999'
	   else 'Over $150,000'
	   end as 'SalaryBracket',
	   concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by case
	   when EstimatedSalary >=0 AND EstimatedSalary < 50000 then '$0-$50,000'
	   when EstimatedSalary >= 50000 AND EstimatedSalary < 100000 then '$50,000-$99,999'
	   when EstimatedSalary >= 100000 AND EstimatedSalary < 150000 then '$100,000-$149,999'
	   else 'Over $150,000'
	   end
order by 'SalaryBracket';*/

-- The Estimated Salary Seems to have no effect on churn rates

-- Having a Credit Card versus Churn Rate
/*select CASE 
	WHEN HasCrCard = 1 THEN 'YES'
	ELSE 'NO'
	END AS HasCard,
	concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by CASE 
	WHEN HasCrCard = 1 THEN 'YES'
	ELSE 'NO'
	END
order by '% Total Churned' desc;*/

-- Having a Credit Card seemingly has no effect on the churn rate
/*select CASE 
	WHEN IsActiveMember = 1 THEN 'YES'
	ELSE 'NO'
	END AS ActiveMember,
	concat(round(sum(CAST(Exited as float)) / Count(CAST(Exited as float)), 2) * 100, '%') as '% Total Churned'
from ChurnRecords
group by CASE 
	WHEN IsActiveMember = 1 THEN 'YES'
	ELSE 'NO'
	END
order by '% Total Churned' desc;*/

-- Being in inactive seems to lead to higher churn, but not by a significant amount