-- Create HR Analytics database
create database hr_analytics;

-- Select the HR Analytics database
use  hr_analytics;

-- Display all tables in the database
show tables;

-- View complete employee dataset
select * from hr_analytics;

-- Calculate total number of employees
SELECT COUNT(*) FROM hr_analytics;

-- Calculate total employees who left the company
select count(*) FROM hr_analytics where attrition = 'Yes';

-- Calculate overall attrition rate
SELECT ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0
/COUNT(*),2) as Attrition_Rate
FROM hr_analytics;

-- Calculate average age of employees
select round(avg(Age),1) as Average_Age FROM hr_analytics;

-- Calculate average monthly income of employee
select round(avg(MonthlyIncome),0) as AverageMonthlyIncome from hr_analytics;

-- Calculate average monthly income by department
select round(avg(MonthlyIncome),0) as AverageMonthlyIncome ,
 Department 
 from hr_analytics 
 group by Department;
 
-- Calculate attrition count by department
 select count(*) as TotalAttrition,
 Department FROM hr_analytics 
 where attrition = 'Yes'
 group by Department;
 
-- Analyze gender distribution of employees
 select count(*) AS Genderdistribution , gender from hr_analytics group by gender;
 
-- Analyze impact of overtime on employee attrition(Overtime VS Attrition)
select  overtime , 
count(*) AS total_employees,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100,2) 
AS attrition_rate_percent from hr_analytics
group by overtime ; 

-- Analyze attrition rate based on job satisfaction level(JobSatisfaction VS Attrition)
select JobSatisfaction , 
count(*) AS total_employees,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
ROUND(AVG(CASE WHEN attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100,2) 
AS attrition_rate_percent from hr_analytics
group by JobSatisfaction ; 

 -- Group employees into age categories
select case
    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 45 THEN '36-45'
    WHEN Age BETWEEN 46 AND 55 THEN '46-55'
    ELSE '55+'
END as Age_Group,
        count(*) as Total_users from hr_analytics group by 1 order by min(Age);
 
-- Calculate average total work experience of employees       
select round(avg(TotalWorkingYears),2) as Avg_Experience from hr_analytics;

-- Categorize employees by experience level
select case when TotalWorkingYears <=5 then '0-5 Years'
			when TotalWorkingYears <= 10 then '6-10 Years'
            when TotalWorkingYears <= 15 then '11-15 Years'
            when TotalWorkingYears <= 20 then '16-20 Years'
            else '20+ Years'
		end as Experience_Group ,
        count(*) as Employee_Count from hr_analytics
        group by Experience_Group order by Employee_Count desc;

-- Rename Age column to remove BOM/import issue
ALTER TABLE hr_analytics
RENAME COLUMN `ï»¿Age` TO Age;

-- Verify updated table structure/data
SELECT * FROM hr_analytics;

-- Analyze attrition count by job role
select JobRole , count(*) as Attrition_Count from hr_analytics 
where Attrition='Yes' group by JobRole order by Attrition_Count desc;

-- Calculate employee count by department
select count(*) as Employee_count, Department 
 from hr_analytics 
 group by Department;
 
-- Analyze work-life balance impact on attrition
 SELECT WorkLifeBalance, COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(AVG(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END)*100,2) AS Attrition_Rate
FROM hr_analytics GROUP BY WorkLifeBalance;

-- Analyze employee distribution by marital status
SELECT
MaritalStatus,
COUNT(*) AS Employee_Count
FROM hr_analytics
GROUP BY MaritalStatus;