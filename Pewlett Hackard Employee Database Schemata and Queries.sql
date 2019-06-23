DROP TABLE "Departments" CASCADE;
DROP TABLE "Dept_Emps" CASCADE;
DROP TABLE "Dept_Managers" CASCADE;
DROP TABLE "Employees" CASCADE;
DROP TABLE "Salaries" CASCADE;
DROP TABLE "Titles" CASCADE;



CREATE TABLE "Departments" (
    "Department_ID" VARCHAR   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "Department_ID"
     )
);

CREATE TABLE "Dept_Emps" (
    "Dept_Emp_ID" VARCHAR   NOT NULL,
    "Department_ID" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Dept_Emps" PRIMARY KEY (
        "Dept_Emp_ID"
     )
);

CREATE TABLE "Dept_Managers" (
    "Dept_Manager_ID" VARCHAR   NOT NULL,
    "Department_ID" VARCHAR   NOT NULL,
    -- Dept_Emps_ID INTEGER FK >- Dept_Emps.Dept_Emp_ID
    -- Title_ID INTEGER FK >- Titles.Title_ID
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Dept_Managers" PRIMARY KEY (
        "Dept_Manager_ID"
     )
);

CREATE TABLE "Employees" (
    "Employee_ID" VARCHAR   NOT NULL,
    -- Department_ID INTEGER FK >- Departments.Department_ID
    "Dept_Manager_ID" VARCHAR   NOT NULL,
    "Dept_Emps_ID" VARCHAR   NOT NULL,
    -- Title_ID VARCHAR FK >- Titles.Title_ID
    "emp_no" INTEGER   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Employee_ID"
     )
);

CREATE TABLE "Salaries" (
    "Salary_ID" VARCHAR   NOT NULL,
    -- Department_ID INTEGER FK >- Departments.Department_ID
    -- Dept_Emps_ID INTEGER FK >- Dept_Emps.Dept_Emp_ID
    -- Dept_Manager_ID INTEGER FK >- Dept_Managers.Dept_Manager_ID
    "Employee_ID" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "salary" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "Salary_ID"
     )
);

CREATE TABLE "Titles" (
    "Title_ID" VARCHAR   NOT NULL,
    -- Department_ID INTEGER FK >- Departments.Department_ID
    -- Dept_Emps_ID INTEGER FK >- Dept_Emps.Dept_Emp_ID
    -- Dept_Manager_ID INTEGER FK >- Dept_Managers.Dept_Manager_ID
    "Employee_ID" INTEGER   NOT NULL,
    -- Salary_ID INTEGER FK >- Salaries.Salary_ID
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "Title_ID"
     )
);

ALTER TABLE "Dept_Emps" ADD CONSTRAINT "fk_Dept_Emps_Department_ID" FOREIGN KEY("Department_ID")
REFERENCES "Departments" ("Department_ID");

ALTER TABLE "Dept_Managers" ADD CONSTRAINT "fk_Dept_Managers_Department_ID" FOREIGN KEY("Department_ID")
REFERENCES "Departments" ("Department_ID");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_Dept_Manager_ID" FOREIGN KEY("Dept_Manager_ID")
REFERENCES "Dept_Managers" ("Dept_Manager_ID");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_Dept_Emps_ID" FOREIGN KEY("Dept_Emps_ID")
REFERENCES "Dept_Emps" ("Dept_Emp_ID");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Employee_ID" FOREIGN KEY("Employee_ID")
REFERENCES "Employees" ("Employee_ID");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_Employee_ID" FOREIGN KEY("Employee_ID")
REFERENCES "Employees" ("Employee_ID");

--1.List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no;

--2.List employees who were hired in 1986.

SELECT * FROM employees
WHERE hire_date >= '1/1/1986' AND hire_date <= '12/31/1986';


--3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager AS dm
INNER JOIN departments AS d
	ON dm.dept_no = d.dept_no
INNER JOIN employees AS e
	ON dm.emp_no = e.emp_no;

--4.List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN dept_employee as de
	ON e.emp_no = de.emp_no
INNER JOIN departments AS d
	ON de.dept_no = d.dept_no;


--5.List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_employee AS de
	ON e.emp_no = de.emp_no
INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
	WHERE d.dept_name = 'Sales';


--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_employee AS de
	ON e.emp_no = de.emp_no
INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
	WHERE d.dept_name IN ('Sales', 'Development');

--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT (emp_no)
FROM employees
GROUP BY last_name
ORDER BY COUNT (emp_no) DESC;

