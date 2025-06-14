-- Question
use projects;

-- 1 What is the gender break down of employees in the company?
select gender, count(*) as count from hr
where age >= 18 and termdate in (0000-00-00)
group by gender ;

-- 2. What is the Race/ethnicity breakdown of employees in the company;
select race, count(*) as count from hr
where age >= 18 and termdate in (0000-00-00)
group by race
order by count(*) desc ;

-- 3. What is the age distribution of employees in the company?
select 
     min(age) as youngest,
     max(age) as oldest
     from hr
     where age >= 18 and termdate in (0000-00-00);
     
     SELECT
          CASE 
          WHEN age >= 18 and age <= 24 THEN '18-24'
          WHEN age >= 25 and age <= 34 THEN '25-34'
          WHEN age >= 35 and age <= 44 THEN '35-44'
          WHEN age >= 45 and age <= 54 THEN '45-54'
          WHEN age >= 55 and age <= 64 THEN '55-64'
          ELSE '65+'
          END AS age_group,
          count(*) AS count
          from hr
          where age >=18 and termdate in (0000-00-00)
          group by age_group
          order by age_group;
          
          SELECT
          CASE 
          WHEN age >= 18 and age <= 24 THEN '18-24'
          WHEN age >= 25 and age <= 34 THEN '25-34'
          WHEN age >= 35 and age <= 44 THEN '35-44'
          WHEN age >= 45 and age <= 54 THEN '45-54'
          WHEN age >= 55 and age <= 64 THEN '55-64'
          ELSE '65+'
          END AS age_group, gender,
          count(*) AS count
          from hr
          where age >=18 and termdate in (0000-00-00)
          group by age_group, gender
          order by age_group, gender;
          
-- 4. How many employees work at headquaters vs remote location?
select location, count(*) as count
from hr
where age >=18 and termdate in (0000-00-00)
group by location
order by location;

-- 5. What is the average length of employeement for employees who have been terminated ?
select round(avg(datediff(termdate, hire_date))/365,0) as avg_length_employement
from hr
where termdate <= curdate() and termdate not in (0000-00-00) and age >= 18;

-- 6. How does the gender distribution vary across departments and jobtitles ?
Select
      department,gender, count(*) AS count
     from hr
     where age >=18 and termdate in (0000-00-00)
     group by department,gender
     Order by department,gender;
     
-- 7. what is the distribution of jobtitle across the company ?
Select
     jobtitle, count(*) AS count
     from hr
     where age >=18 and termdate in (0000-00-00)
     group by jobtitle
     Order by jobtitle Desc;
     
-- 8. Which department has the highest turnover rate?
Select
     department, total_count, terminated_count, terminated_count/total_count as termination_rate
     from(
          Select department,
          count(*) as total_count,
          sum(case when termdate not in (0000-00-00) and termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
          from hr
          where age >= 18
          group by department
          ) AS subquery
          order by termination_rate DESC;
          
-- 9. What is the distribution of employees across location by city and state?
select location_state, count(*) as count from hr
where age >= 18 and termdate in (0000-00-00)
group by location_state
order by count desc;

-- 10. How has the company's employees count changed over time on hire and term dates?
SELECT year, 
       hires,
       terminations,
       hires - terminations as net_change,
       round((hires-terminations)/hires * 100,2) as net_change_percentage
       from ( 
			SELECT
             Year(hire_date) as year,
             COUNT(*) as hires,
             sum(CASE WHEN termdate not in (0000-00-00) AND termdate <= curdate() THEN 1 ELSE 0 END ) AS terminations
             from hr
             where age >= 18
             group by YEAR(hire_date)
             ) AS subquery
		order by YEAR ASC;
        
-- 11. What is the tenure distribution of each department?
SELECT department, round(avg(datediff(termdate, hire_date)/365),0) as avg_Tenure from hr
where termdate <= curdate() and termdate not in (0000-00-00) and age >=18
group by department;



          