CREATE database ibm_hr;
use ibm_hr;
--  DATA UNDERSTANDING AND EXPLORATION 

select * 
from ibm_data
limit 5;    -- preview the table 

select count(*) as total_employee 
from ibm_data;  -- total employee 

describe ibm_data;  -- data description 

select distinct Gender from ibm_data;
select distinct Attrition from ibm_data;
select distinct JobRole from ibm_data;
select distinct Department from ibm_data;
select distinct Education from ibm_data;
select distinct WorkLifeBalance from ibm_data;
select distinct StockOptionLevel from ibm_data;
select distinct HourlyRate from ibm_data;


-- Data Cleaning and Validation 
select EmployeeNumber, count(*) as count_employee
from ibm_data
group by EmployeeNumber 
having count_employee > 1;    -- Checking for duplicates  

With maybe_duplicates as (
select EmployeeNumber, count(*) as count_employee
from ibm_data
group by EmployeeNumber 
)
select * 
from maybe_duplicates 
where count_employee > 1;    -- using cte to check for duplicate 

alter table ibm_data
drop column EmployeeCount,
drop column Over18, 
drop column StandardHours;   -- we doing this as these columns have no way to affect our analysis

select *
from ibm_data
limit 5;

select count(*) as count_of_null
from ibm_data 
where Attrition is null;   -- checking for null values 

describe ibm_data;

select 
sum(case when ï»¿Age is null or ï»¿Age <= 0 then 1 else 0 end ) as invalid_age, 
sum(case when DailyRate is null or DailyRate < 0 then 1 else 0 end ) as invalid_DailyRate,
sum(case when DistanceFromHome is null or DistanceFromHome <= 0 then 1 else 0 end ) as invalid_DistanceFromHome,
sum(case when Education is null or Education <= 0 then 1 else 0 end ) as invalid_education,
sum(case when EmployeeNumber is null or EmployeeNumber < 0 then 1 else 0 end ) as invalid_employee_num,
sum(case when EnvironmentSatisfaction is null or EnvironmentSatisfaction < 0 then 1 else 0 end ) as invalid_EnvironmentSatisfaction,
sum(case when HourlyRate is null or HourlyRate < 0 then 1 else 0 end ) as invalid_HourlyRate,
sum(case when JobInvolvement is null or JobInvolvement < 0 then 1 else 0 end ) as invalid_JobInvolvement,
sum(case when JobLevel is null or JobLevel < 0 then 1 else 0 end ) as invalid_level,
sum(case when JobSatisfaction is null or JobSatisfaction< 0 then 1 else 0 end ) as invalid_jobsatisfaction,
sum(case when MonthlyIncome is null or MonthlyIncome < 0 then 1 else 0 end ) as invalid_MonthlyIncome,
sum(case when MonthlyRate is null or MonthlyRate < 0 then 1 else 0 end ) as invalid_MonthlyRate,
sum(case when NumCompaniesWorked is null or NumCompaniesWorked < 0 then 1 else 0 end ) as invalid_NumCompaniesWorked,
sum(case when PercentSalaryHike is null or PercentSalaryHike < 0 then 1 else 0 end ) as invalid_PercentSalaryHike,
sum(case when PerformanceRating is null or PerformanceRating <= 0 then 1 else 0 end ) as invalid_PerformanceRating,
sum(case when RelationshipSatisfaction is null or RelationshipSatisfaction < 0 then 1 else 0 end ) as invalid_RelationshipSatisfaction,
sum(case when StockOptionLevel is null or StockOptionLevel < 0 then 1 else 0 end ) as invalid_StockOptionLevel,
sum(case when TotalWorkingYears is null or TotalWorkingYears < 0 then 1 else 0 end ) as invalid_TotalWorkingYears,
sum(case when  TrainingTimesLastYear is null or TrainingTimesLastYear <= 0 then 1 else 0 end ) as invalid_TrainingTimesLastYear,
sum(case when WorkLifeBalance is null or WorkLifeBalance < 0 then 1 else 0 end ) as invalid_WorkLifeBalance,
sum(case when YearsAtCompany is null or YearsAtCompany  < 0 then 1 else 0 end ) as invalid_YearsAtCompany,
sum(case when YearsInCurrentRole is null or YearsInCurrentRole < 0 then 1 else 0 end ) as invalid_YearsInCurrentRole,
sum(case when YearsSinceLastPromotion is null or YearsSinceLastPromotion < 0 then 1 else 0 end ) as invalid_YearsSinceLastPromotion,
sum(case when YearsWithCurrManager is null or YearsWithCurrManager < 0 then 1 else 0 end ) as invalid_YearsWithCurrManager
from ibm_data;  -- NULL or invalid values in numerical columns

select 
sum(case when Attrition is null or trim(Attrition) = '' then 1 else 0 end ) as missing_attrition,
sum(case when Department is null or trim(Department) = '' then 1 else 0 end ) as missing_department,
sum(case when BusinessTravel is null or trim(BusinessTravel) = '' then 1 else 0 end ) as missing_businesstravel,
sum(case when EducationField is null or trim(EducationField) = '' then 1 else 0 end ) as missing_educationfield,
sum(case when Gender is null or trim(Gender) = '' then 1 else 0 end ) as missing_gender,
sum(case when JobRole is null or trim(JobRole) = '' then 1 else 0 end ) as missing_JobRole,
sum(case when MaritalStatus is null or trim(MaritalStatus) = '' then 1 else 0 end ) as missing_maritalStatus,
sum(case when OverTime is null or trim(OverTime) = '' then 1 else 0 end ) as missing_overtime
from ibm_data;     -- NULL or blank spaces 

-- EXPLORATORY  ANALYSIS 
select 
COUNT(*) AS total_employees, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as total_attrition, 
round(sum(case when Attrition = 'Yes' then 1 else 0 end)/ count(*) *100, 2) as attrition_rate 
from ibm_data; -- attrition rate 

with attrition_details as (
select count(*) as total_employee, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_yes 
from ibm_data
)
select total_employee, 
attrition_yes, 
round(attrition_yes/ total_employee * 100, 2 ) as attrition_rate
from attrition_details;    -- using cte to find attrition rate 

select total_employees, 
attrition_yes, 
round(attrition_yes/total_employees * 100, 2) as attrition_rate
from
(select count(*) as total_employees, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_yes
from  ibm_data) as sub_attr;   -- using sub_query to find attrition rate 

with attrition_department as (
select
Department, count(*) as total_in_dept, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_yes 
from ibm_data
group by Department
)
select 
Department, total_in_dept, attrition_yes,
round(attrition_yes/total_in_dept * 100, 2) as attrition_dept
from attrition_department
order by attrition_dept desc;  --  Attrition Ratee my Department 

with attrition_role as (
select JobRole, count(*) as total_in_jobrole, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_rate
from ibm_data
group by JobRole)
select  JobRole, total_in_jobrole,
attrition_rate, 
round(attrition_rate/total_in_jobrole * 100, 2) as attrition_rate 
from attrition_role
order by attrition_rate desc; -- attrition by Jobrole 

with Monthly_income as (
select JobRole, avg(MonthlyIncome) as avg_income 
from ibm_data
group by JobRole)
select JobRole, avg_income, 
round(avg_income, 0) as avgg_income_deci
from Monthly_income 
order by avgg_income_deci; -- average income by jobrole 

with job_satisfy as (
select JobSatisfaction, count(*) as total_IN_satisfaction, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_rae
from 
ibm_data 
group by JobSatisfaction
) 
select JobSatisfaction, total_IN_satisfaction, attrition_rae,
round(attrition_rae/total_IN_satisfaction * 100, 2) as job_attri_satisfy
from job_satisfy 
order by JobSatisfaction  desc;   -- job attrition by satisfaction 

with life_balance as (
select WorkLifeBalance, count(*) as toatl_worklife, 
sum(case when Attrition = 'Yes' then 1 else 0 end ) as attrition_rate 
from ibm_data 
group by WorkLifeBalance
)
select WorkLifeBalance, toatl_worklife, attrition_rate,
round(attrition_rate/toatl_worklife * 100, 2) as work_life_attrition_rate 
from life_balance 
order by work_life_attrition_rate desc;    --  work_life by attrition 

select sub.BusinessTravel, 
sub.count_of_busines_travel, 
sub.attrition_rate,
round(attrition_rate/count_of_busines_travel * 100, 2) as BusinessTravel_by_Attrition_Rate
from

(select BusinessTravel, count(*) as count_of_busines_travel, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition_rate
from ibm_data
group by BusinessTravel ) as sub 
order by BusinessTravel_by_Attrition_Rate desc;   -- does travel frequency impact attrition


--  Does overtime affect attrition 
select sub.OverTime, 
sub.total_overtime,
sub.attrition,
round(attrition/total_overtime * 100, 1) as OverTime_Attrition_RAte 
from
(select OverTime, count(*) as total_overtime, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition
from ibm_data
group by OverTime) as sub
order by OverTime_Attrition_RAte desc;

-- Are people with certain educational background likely to leave 
with education_attri as (
select Education, count(*) as totaal_in_school, 
sum(case when Attrition = 'Yes' then 1 else 0 end) as attrition 
from ibm_data
group by Education
)
select Education, totaal_in_school, attrition,
round(attrition/totaal_in_school * 100, 2) as Education_attrition
from education_attri 
order by Education, Education_attrition desc; 

-- years in company vs attrition 
select sub.age_group, sub.total_count, sub.arttrition, 
round(arttrition/total_count * 100, 2) as  YearsAtCompany_attrition_Rate
from
(select 
case 
when YearsAtCompany <= 1 then '0-1 years'
when YearsAtCompany <= 3 then '2-3 years'
when YearsAtCompany <= 5 then '4-5 years'
when YearsAtCompany <= 7 then '6-7 years'
when YearsAtCompany <= 10 then '8-10 years' 
else '10+ years' end as age_group,
count(*) total_count, 
sum(case when Attrition = 'Yes' then 1 else 0 end ) as arttrition
from ibm_data
group by age_group)
as sub
order by YearsAtCompany_attrition_Rate;