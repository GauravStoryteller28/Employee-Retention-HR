create schema HR_Analyst;
use hr_analyst;
desc hr_1;
desc hr_2;
desc hr_mergedfile;
select * from hr_1;
select * from hr_2;
select * from hr_mergedfile;

-- KPI-1 : Average Attrition Rate for All Department
select department,concat(format(avg(case when attrition = "Yes" then 1 else 0 end) * 100,2), "%") as Attrition_rate
from hr_mergedfile
group by department;

-- KPI-2 : Average Hourly Rate for Male Research Scientist
select jobrole, format(avg(hourlyrate),2) as Average_Hourlyrate, Gender from hr_mergedfile
where upper(jobrole)="RESEARCH SCIENTIST" and upper(Gender)="MALE"
group by jobrole,gender;

-- KPI-3 : AttritionRate VS MonthlyIncomeStats against department 
select department,concat(format(avg(case when attrition = "Yes" then 1 else 0 end) * 100,2), "%") as Average_Attrition_rate,
format(avg(`HR@2.MonthlyIncome`),2) as Average_Monthly_Income
from hr_mergedfile
group by department;

-- KPI-4 : Average Working Years for Each Department
select department, format(avg(`HR@2.TotalWorkingYears`),2) as Average_Working_Year
from hr_mergedfile
group by department;

-- KPI-5 : Job Role VS Work Life Balance
select JobRole,
-- sum(case when `HR@2.performancerating` = 1 then 1 else 0 end) as 1st_Rating_Total,
-- sum(case when `HR@2.performancerating` = 2 then 1 else 0 end) as 2nd_Rating_Total,
-- sum(case when `HR@2.performancerating` = 3 then 1 else 0 end) as 3rd_Rating_Total,
-- sum(case when `HR@2.performancerating` = 4 then 1 else 0 end) as 4th_Rating_Total, 
format(avg(`HR@2.WorkLifeBalance`),2) as Average_WorkLifeBalance_Rating
from hr_mergedfile 
group by jobrole;

-- KPI-6 : Attrition Rate Vs Year Since Last Promotion Relation Against Job Role
select JobRole,concat(format(avg(case when attrition = "Yes" then 1 else 0 end) * 100,2), "%") as Average_Attrition_rate,
format(avg(`HR@2.Yearssincelastpromotion`),2) as Average_YearsSincelastpromotion
from hr_mergedfile 
group by jobrole;
