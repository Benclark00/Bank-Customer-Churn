# Bank-Customer-Churn

In this project I utilized a dataset from Kaggle that models a bank's churn data in a few countries. I began this analysis by combing through the dataset with Microsoft SQL Server.
While performing EDA, I examined the effect of each column on the relative churn rate to see which factors really had a strong impact on the churning of customers from the bank.
After completing the EDA portion, finding the top three churn factors, I moved into Power BI to build a report to for my findings. Inside this presentation I have shown the relative 
churn rate based off each factor and pages for each, as well as an overview page to show at risk customers. The designed presentation also implements RLS, allowing for the data to 
be seen through a focused lens based on country. This was based on whether the customers were from Germany, or if they had at least three products, as I determined the gender component
was more negligible, depsite stil being a factor. If I had done this for a real organization some of the recommendations I would have would be to look into the at risk customers, 
specifically those that are based in Germany, as well as trying to understand why the users that surpass two different types of products tend to churn.

# Project Contents

## Churn Folder

### Images Folder
- Images of Query Results

### Customer-Churn-Records.csv
- Original Dataset

### Data Cleaning and EDA.sql
- Holds all queries applied to the data to clean and explore the original dataset

### Report.pbi
- Power BI report

