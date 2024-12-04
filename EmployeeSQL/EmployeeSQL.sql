create table departments (
dept_no VARCHAR (30) NOT NULL,
dept_name VARCHAR (30) NOT NULL,
PRIMARY KEY (dept_no));
SELECT * FROM departments

Create table dept_emp (
emp_no INT NOT NULL,
dept_no VARCHAR (30) NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no));

SELECT * FROM dept_emp

Create table dept_manager (
dept_no VARCHAR (30)NOT NULL,
emp_no INT NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (dept_no, emp_no));
SELECT * FROM dept_manager

Create table employees (
emp_no INT NOT NULL,
emp_title_id VARCHAR (30) NOT NULL,
birth_date date NOT NULL,
first_name VARCHAR (30) NOT NULL,
last_name VARCHAR (30) NOT NULL,
sex VARCHAR (30) NOT NULL,
hire_date Date NOT NULL,
FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
PRIMARY KEY (emp_no));
SELECT * FROM employees

Create table Salaries (
emp_no INT NOT NULL,
salary INT NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (emp_no));
SELECT * FROM Salaries

Create Table titles(
title_id VARCHAR (30) NOT NULL,
title VARCHAR (30) NOT NULL,
PRIMARY KEY (title_id));
SELECT * FROM titles

#List the employee number, last name, first name, sex, and salary of each employee
Select e.emp_no,e.last_name,e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON e.emp_no = s.emp_no;

#List the first name, last name, and hire date for the employees who were hired in 1986.
Select first_name, last_name, hire_date
FROM employees
WHERE hire_date>'12/31/1985' AND hire_date<'01/01/1987';

#List the manager of each department along with their department number, department name,
#employee number, last name, and first name.
Select dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
From dept_manager as dm
Inner Join departments as d ON dm.dept_no = d.dept_no
Inner Join employees as e ON dm.emp_no = e.emp_no;

#List the department number for each employee along with that employee’s employee number,
#last name, first name, and department name.

Select e.emp_no, e.last_name, e.first_name, d.dept_name, de.dept_no
From employees as e
Inner Join dept_emp as de ON e.emp_no = de.emp_no
Inner Join departments as d ON de.dept_no = d.dept_no;

#List first name, last name, and sex of each employee whose first name is Hercules and whose
#last name begins with the letter B.
Select last_name, first_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';

#List each employee in the Sales department, including their employee number, last name, and
first name.

Select e.emp_no, e.last_name, e.first_name, d.dept_name, de.dept_no
From employees as e
Inner Join dept_emp as de ON e.emp_no = de.emp_no
Inner Join departments as d ON de.dept_no = d.dept_no
where dept_name = 'Sales';

#List each employee in the Sales and Development departments, including their employee
number,
#last name, first name, and department name.

Select e.emp_no, e.last_name, e.first_name, d.dept_name, de.dept_no
From employees as e
Inner Join dept_emp as de ON e.emp_no = de.emp_no
Inner Join departments as d ON de.dept_no = d.dept_no
where dept_name = 'Sales' or dept_name = 'Development';

#List the frequency counts, in descending order, of all the employee last names
#(that is, how many employees share each last name)

SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;