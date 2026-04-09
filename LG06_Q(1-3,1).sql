SELECT LAST_NAME, FIRST_NAME, SALARY, DEPARTMENT_NAME
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT LAST_NAME, FIRST_NAME, SALARY
FROM employees e, departments d
WHERE e.department_id = d.department_id and d.department_name LIKE 'Shipping'
order by e.salary desc;

SELECT DEPARTMENT_ID, DEPARTMENT_NAME, L.LOCATION_ID
FROM departments d, locations l
WHERE d.location_id = l.location_id and CITY LIKE 'Seattle'
order by DEPARTMENT_NAME;

SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY>12000;