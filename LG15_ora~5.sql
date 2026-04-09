select EXTRACT(day FROM DATE '2020-04-21')
from dual;

select last_name, hire_date, extract(year from hire_date)
from employees;

ACCEPT salary NUMBER FORMAT '999.99' DEFAULT '000.0' PROMPT 'Enter weekly salary:';
ACCEPT pswd CHAR PROMPT 'Type your Password: ' HIDE;

SET SERVEROUTPUT ON;
BEGIN
dbms_output.put_line (user || ' Tables in the database:');
FOR t IN (SELECT table_name FROM user_tables)
LOOP
dbms_output.put_line(t.table_name);
END LOOP;
END;
/