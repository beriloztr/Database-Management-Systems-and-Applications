SET SERVEROUTPUT ON;
DECLARE
c_grade number(5,2) := &overall;
c_letter CHAR(1);
BEGIN
find_letter(c_grade, c_letter);
dbms_output.put_line('Your Letter grade is: '|| c_letter);
END;
/