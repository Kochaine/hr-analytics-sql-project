 HR Analytics SQL Project – IBM Employee Attrition Analysis

 Objective
The goal of this project is to analyze employee attrition patterns in IBM’s workforce using SQL. This helps HR teams understand what drives employees to leave and how to improve retention.

---

 Dataset Overview
- Dataset: IBM HR Analytics Employee Attrition & Performance
- Rows: 1,470 employees
- Columns: 35 HR-related variables (Attrition, Job Role, Income, Work-Life Balance, etc.)
- Source: [Kaggle](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)



 Tools Used
- Database**: MySQL
- Query Language: SQL
- IDE: MySQL Workbench / VS Code

 Data Cleaning
- Removed duplicate records
- Checked for and handled:
  - NULL values
  - Blank strings
  - Invalid data (e.g., zeros in fields like income or years at company)
- Created a comprehensive SQL view to monitor data quality:

Key Insights (Exploratory SQL Analysis)

| #  | Focus                               | Insight |
|----|-------------------------------------|---------|
| 1  | Overall Attrition Rate         | 16% of employees left |
| 2  | Attrition by Department        | Highest attrition in Sales |
| 3  | Attrition by Job Role          | Most vulnerable: Sales Executive |
| 4  | Income by Role                 | Research Director earns highest |
| 5  | Job Satisfaction Impact        | Low satisfaction → higher attrition |
| 6  | Work-Life Balance              | Balance rating 1 → high attrition |
| 7  | Overtime                     | Overtime staff leave at 2× rate |
| 8  | Business Travel                | Frequent travel increases attrition risk |
| 9  | Education Field Mismatch       | Human Resources field had higher exits |
| 10 | Tenure Insight                 | 0–2 years tenure = peak attrition |

---

Business Recommendations
- Focus retention efforts on employees in Sales & Executive roles
- Reduce overtime and improve work-life balance programs
- Support employees within first 2 years (onboarding, mentorship)
- Reassess travel policies for high-frequency travelers

---

 Project Roadmap

1. Project Setup – Database creation & data import  
2. Data Exploration – Structure, types, distinct values  
3. Data Cleaning – Nulls, invalids, blanks, duplication  
4. Data Quality View – SQL view to track issues  
5. EDA with SQL – 10 insights on attrition  



