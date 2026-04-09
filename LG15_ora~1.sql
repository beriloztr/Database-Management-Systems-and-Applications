CREATE OR REPLACE FUNCTION EmpCount
RETURN NUMBER
IS 
TOTAL number := 0;
BEGIN
SELECT count(*) INTO TOTAL
from employees;
RETURN TOTAL;
END;
/
SHOW ERRORS FUNCTION EmpCount;

SELECT EmpCount() FROM dual;

drop FUNCTION EmpCount;

SET SERVEROUTPUT ON;
DECLARE
c number(2);
BEGIN
c := EMPCOUNT ();
dbms_output.put_line('Total no. of Employees: ' || c);
END;
/