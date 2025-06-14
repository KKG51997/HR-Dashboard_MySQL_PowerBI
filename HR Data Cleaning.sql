create database projects;
use projects;

SELECT * from hr;

ALTER TABLE hr
change column ï»¿id emp_id varchar(20) null;

desc hr;

SELECT birthdate from hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
  WHEN birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d%Y'), '%Y-%m-%d')
  ELSE NULL
  END;
  
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = case
  when hire_date like '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
  when hire_date like '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
  ELSE NULL
  END;
  
  ALTER TABLE hr
  MODIFY COLUMN hire_date date;
  
  SELECT * FROM hr;
  
  UPDATE hr
  SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
  WHERE termdate IS NOT NULL AND termdate !='';
  
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

select termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate date;

desc hr;
ALTER TABLE HR
ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, curdate());

SELECT birthdate, age from hr;

SELECT min(age) AS youngest,
	   max(age) AS oldest
       from hr;	
  SELECT birthdate, age from hr;
  
  select count(*) from hr where age<18;