set serveroutput on;
DECLARE
n_pct employees.commission_pct%TYPE;
v_eval varchar2(10);
e_empid employees.employee_id%TYPE := &emp_id;

BEGIN 
select commission_pct INTO n_pct
from employees
where employee_id = e_empid;

CASE nvl(n_pct, 0)
    WHEN 0 THEN
    v_eval := 'N/A';
    WHEN 0.1 THEN
    v_eval := 'Low';
    WHEN 0.4 THEN
    v_eval := 'High';
ELSE
    v_eval := 'Fair';
    
END CASE;
dbms_output.put_line('Employee '||e_empid||' commission '||n_pct||' which is '||v_eval);
END;
/