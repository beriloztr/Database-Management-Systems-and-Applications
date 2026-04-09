select * from PERSONNEL;

set serveroutput on;
DECLARE
total_rows number(2);

BEGIN
UPDATE personnel 
SET salary = salary + 500;

IF sql%NOTFOUND THEN
dbms_output.put_line('No personnel in the list');
ELSIF sql%FOUND THEN
total_rows := sql%ROWCOUNT;
dbms_output.put_line('There are '|| total_rows || ' personnels');
commit;
END IF;
END;
/

SET SERVEROUTPUT ON;
DECLARE
CURSOR personnel_cur IS
    SELECT id, name, sname, salary
    FROM personnel;
p_row personnel_cur%ROWTYPE;

BEGIN 
OPEN personnel_cur;
LOOP
FETCH personnel_cur INTO p_row;
EXIT WHEN personnel_cur%NOTFOUND;
DBMS_OUTPUT.put_line(p_row.id || ' ' || p_row.name||' '||p_row.sname||
' earns '||p_row.salary||' $');
END LOOP;
CLOSE personnel_cur;
END;
/



