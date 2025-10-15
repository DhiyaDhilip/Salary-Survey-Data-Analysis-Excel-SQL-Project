CREATE DATABASE SurveySalary;

Create Table Salary(
Employee_Id serial Primary key Not null,
Age_Range text,
Industry text,
Job_Title text,
Annual_Salary bigint,
Additional_Monetary_Compensation bigint,
Currency text,
Country text,
City text,
Years_of_Professional_Experience_Overall text,
Years_of_Professional_Experience_in_Field text,
Highest_Level_of_Education_Completed text,
Gender text
);

Select * from Salary;

--1.Average Salary by Industry and Gender
SELECT DISTINCT ON(Industry) Industry,Gender,AVG(Annual_Salary) AS average_salary
FROM Salary
GROUP BY Industry, Gender
ORDER BY Industry, Gender
LIMIT 10;

--2.Total Salary Compensation by Job Title
SELECT Job_Title,SUM(Annual_Salary + Additional_Monetary_Compensation) AS Total_Compensation
FROM Salary
GROUP BY Job_Title
ORDER BY Total_Compensation DESC
LIMIT 10;

--3.Salary Distribution by Education Level
SELECT Highest_Level_of_Education_Completed AS education_level,
AVG(Annual_Salary) AS average_salary,MIN(Annual_Salary) AS minimum_salary,MAX(Annual_Salary) AS maximum_salary
FROM Salary
GROUP BY Highest_Level_of_Education_Completed
ORDER BY average_salary DESC;

--4.Number of Employees by Industry and Years of Experience
SELECT Industry,Years_of_Professional_Experience_Overall AS experience_years,
COUNT(*) AS employee_count
FROM Salary
GROUP BY Industry,Years_of_Professional_Experience_Overall
ORDER BY Industry,experience_years
LIMIT 10;

--5.Median Salary by Age Range and Gender
SELECT Age_Range, Gender, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Annual_Salary) AS median_salary
FROM Salary
GROUP BY Age_Range, Gender
ORDER BY Age_Range, Gender;


--6.Job Titles with the Highest Salary in Each Country
SELECT DISTINCT ON (Country) Country,Job_Title,Annual_Salary
FROM Salary
ORDER BY Country, Annual_Salary DESC
LIMIT 10;


--7.Average Salary by City and Industry
SELECT City,Industry,AVG(Annual_Salary) AS average_salary
FROM Salary
GROUP BY City, Industry
ORDER BY City, Industry
LIMIT 10;


--8.Percentage of Employees with Additional Monetary Compensation by Gender
SELECT Gender,(COUNT(CASE WHEN Additional_Monetary_Compensation > 0 THEN 1 END) * 100.0) / COUNT(*) AS percentage_with_compensation
FROM Salary
GROUP BY Gender;

--9.Total Compensation by Job Title and Years of Experience
SELECT Job_Title,Years_of_Professional_Experience_Overall ,
SUM(Annual_Salary + Additional_Monetary_Compensation) AS Total_Compensation
FROM Salary
GROUP BY Job_Title, Years_of_Professional_Experience_Overall
ORDER BY Total_Compensation DESC
LIMIT 10;



--10.Average Salary by Industry, Gender, and Education Level
SELECT Industry,Gender,Highest_Level_of_Education_Completed,AVG(Annual_Salary) AS average_salary
FROM Salary
GROUP BY Industry, Gender, Highest_Level_of_Education_Completed
LIMIT 10;