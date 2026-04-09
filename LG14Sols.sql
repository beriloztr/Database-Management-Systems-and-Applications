--14.1
set serveroutput on;
DECLARE
    today DATE;
BEGIN
    today := SYSDATE;
        dbms_output.put_line('Today''s date is');
        dbms_output.put_line(today);
END;
/
--14.2
DECLARE
emp_id emp.empno%TYPE;
emp_name emp.ename%TYPE;
wages NUMBER(7,2);
BEGIN
SELECT ename, sal + comm
INTO emp_name, wages FROM emp
WHERE empno = emp_id;

END;

--14.2-a
/*Write a PL/SQL program to declare a string 
and initialize it to "CTIS259-Database Management Systems".
Then find the department ("CTIS") and course number ("259")
and output them.*/
set serveroutput on;
DECLARE
str VARCHAR2(50);
dept VARCHAR2(30);
cno NUMBER(5);

BEGIN
str := 'CTIS259-Database Management Systems';
dept := 'CTIS';
cno := 259;


dbms_output.put_line(str);
dbms_output.put_line(dept);
dbms_output.put_line(cno);
END;
/

--14.2-b
/*Modify the PL/SQL program in EXERCISE 2-a 
so the program will display the department in different format 
(Capitalizes the first letter) also searches for the word 'Data’
and displays its position.*/
set serveroutput on;
DECLARE
str VARCHAR2(50);
dept VARCHAR2(30);
cno NUMBER(5);

BEGIN
str := 'CTIS259-Database Management Systems';
dept := 'CTIS';
cno := 259;

dbms_output.put_line(INSTR(str, 'Data'));
dbms_output.put_line(str);
dbms_output.put_line(INITCAP(dept));
dbms_output.put_line(cno);
END;
/

--14.3 Find and display the date n months later from now.
set serveroutput on;
DECLARE
today DATE:= sysdate;
nMonths NUMBER:=&enterN;
BEGIN
dbms_output.put_line(nMonths || ' months later is: ' 
|| ADD_MONTHS(today, nMonths));
END;
/

--14.4 Calculate the area and perimeter of a circle. 
--The radius will be given by user. (pi: 3.14)
set serveroutput on;
DECLARE
pi number(3,2):= 3.14;
perimeter number(13.2);
area number(13.2);
radius number(7.2);
BEGIN
radius:= &enterR;
perimeter:= 2*pi*radius;
area:= pi*radius*radius;
dbms_output.put_line('area is: '||area);
dbms_output.put_line('perimeter is: '|| perimeter);

END;
/

--14.5 Generate the reverse of a given number

set serveroutput on;
DECLARE
n number(7):= 0;
rev number(7);
BEGIN
n:= &enterNumber;
WHILE( n > 0 )
LOOP 
rev:= rev*10 + mod(n,10);
n:= floor(num/10);
END LOOP;
END;
/

--14.6 Calculate and display the sum of the numbers between 1-100.

set serveroutput on;
DECLARE
Nsum number(5):= 0;
n number(3):=1;
BEGIN
LOOP
Nsum := n+Nsum;
n:= n +1;
EXIT WHEN(n>100);
END LOOP;
dbms_output.put_line(Nsum);
END;
/

--14.7
/*Display the name of the department that John Micc is working for.*/
set serveroutput on;
DECLARE 
currdname department.dname%TYPE;
BEGIN
SELECT dname
INTO currdname
FROM department, employee
WHERE dnumber = dno AND lname='MICC' AND fname ='JOHN';
dbms_output.put_line('The department name is: '|| currdname);
 END;
 /

--14.8 
/*Display the names of employees who are working for Department 3.*/

set serveroutput on;
DECLARE
elname employee.lname%TYPE;
efname employee.fname%TYPE;
deptno department.dnumber%TYPE;
CURSOR e_cursor IS
    SELECT fname, lname
    FROM employee
    WHERE dno = deptno;
BEGIN
deptno:= 3;
OPEN e_cursor;
LOOP
FETCH e_cursor INTO efname, elname;
EXIT WHEN e_cursor%NOTFOUND;
dbms_output.put_line('Employee: ' || efname || ' '|| elname);
END LOOP;
CLOSE e_cursor;
END;
/

--14.9
Exercise 9:
SET SERVEROUTPUT ON;
DECLARE
deptno department.dnumber%TYPE;
CURSOR emp_cursor IS
SELECT fname, lname
FROM employee
WHERE dno = deptno;
e_row emp_cursor%ROWTYPE;
BEGIN
deptno := 3;
FOR e_row IN emp_cursor LOOP
DBMS_OUTPUT.PUT_LINE ('Employee: ' || e_row.fname || ' ' || e_row.lname);
END LOOP;
END;
/


--14.10
SET SERVEROUTPUT ON;
DECLARE
Emp_name VARCHAR2(10);
Emp_number INTEGER;
Empno_out_of_range EXCEPTION;
BEGIN
Emp_number := 10001;
IF Emp_number > 9999 OR Emp_number < 100 THEN
RAISE Empno_out_of_range;
ELSE
SELECT fname INTO Emp_name FROM employee
WHERE ssn = Emp_number;
dbms_output.put_line ('Employee name is ' || Emp_name);
END IF;
EXCEPTION
WHEN Empno_out_of_range THEN
dbms_output.put_line ('Employee number ' || Emp_number || ' is out of range.');
END;
/







