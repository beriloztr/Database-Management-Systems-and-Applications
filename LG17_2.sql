/*SET SERVEROUTPUT ON;
DECLARE
avg_amount NUMBER(15,5);
user_company VARCHAR2(10):='&user_company';
BEGIN
SELECT AVG(supported_amount) INTO avg_amount
FROM Sponsors WHERE Company=user_company; IF avg_amount IS NULL THEN dbms_output.put_line(user_company || ' is not among sponsors.');
ELSIF avg_amount = 0 THEN
dbms_output.put_line('No support is given by ' || user_company);
ELSIF avg_amount < 500000 THEN
dbms_output.put_line(user_company || ': Fairly Good Amount with ' || avg_amount);
ELSE
dbms_output.put_line(user_company || ': Among the Top Sponsors with ' || avg_amount);
END IF;
END;
/


CREATE OR REPLACE PROCEDURE Company_Support_Amount (user_company IN VARCHAR2) 
IS
avg_amount NUMBER(15,5);
BEGIN
SELECT AVG(supported_amount) INTO avg_amount
FROM Sponsors WHERE Company=user_company;
IF avg_amount IS NULL THEN
dbms_output.put_line(user_company || ' is not among sponsors.');
ELSIF avg_amount = 0 THEN
dbms_output.put_line('No support is given by ' || user_company);
ELSIF avg_amount < 500000 THEN
dbms_output.put_line(user_company || ': Fairly Good Amount with ' || avg_amount);
ELSE
dbms_output.put_line(user_company || ': Among the Top Sponsors with ' || avg_amount);
END IF;
END;
/
SHOW ERRORS PROCEDURE Company_Support_Amount;

SET SERVEROUTPUT ON;
BEGIN
Company_Support_Amount('OYAK');
END;
/



CREATE OR REPLACE PROCEDURE Company_Support_Amount (user_company IN VARCHAR2, the_result OUT VARCHAR2) IS
avg_amount NUMBER(15,5);
BEGIN
SELECT AVG(supported_amount) INTO avg_amount
FROM Sponsors WHERE Company=user_company;
IF avg_amount IS NULL THEN the_result := user_company || ' is not among sponsors.';
ELSIF avg_amount = 0 THEN the_result := 'No support is given by ' || user_company;
ELSIF avg_amount < 500000 THEN the_result := user_company || ': Fairly Good Amount with ' || avg_amount;
ELSE the_result := user_company || ': Among the Top Sponsors with ' || avg_amount;
END IF;
END;
/


SET SERVEROUTPUT ON;
DECLARE
the_output VARCHAR2(50);
BEGIN
Company_Support_Amount('OYAK', the_output);
DBMS_OUTPUT.PUT_LINE(the_output);
END;
/
*/

drop procedure Company_Support_Amount;

CREATE OR REPLACE FUNCTION Company_Support_Amount (user_company IN VARCHAR2) 
RETURN VARCHAR2
IS
avg_amount NUMBER(15,5);
BEGIN
SELECT AVG(supported_amount) INTO avg_amount
FROM Sponsors WHERE Company=user_company;
IF avg_amount IS NULL THEN RETURN user_company || ' is not among sponsors.';
ELSIF avg_amount = 0 THEN RETURN 'No support is given by ' || user_company;
ELSIF avg_amount < 500000 THEN RETURN user_company || ': Fairly Good Amount with ' || avg_amount;
ELSE RETURN user_company || ': Among the Top Sponsors with ' || avg_amount;
END IF;
END;
/

show errors FUNCTION Company_Support_Amount;


SET SERVEROUTPUT ON;
DECLARE
the_output VARCHAR2(50);
BEGIN
the_output := Company_Support_Amount('OYAK');
DBMS_OUTPUT.PUT_LINE(the_output);
END;
/

/*
set serveroutput on;
CREATE OR REPLACE FUNCTION Team_Driver_Age_Average(team_id IN VARCHAR2)
RETURN NUMBER
IS
total_age INTEGER :=0;
avg_age NUMBER := 0;
driver_age NUMBER(2);
BEGIN
    select (EXTRACT(year from sysdate) - EXTRACT(YEAR FROM BirthDate)) 
    INTO driver_age 
    from driver 
    Where id = team_id;

total_age := total_age + 1;
avg_age := avg_age + driver_age;
avg_age := avg_age / total_age;

RETURN avg_age;
END;
/


CREATE OR REPLACE FUNCTION Team_drIver_age_Average
(team_Id IN VARCHAR2)
RETURN NUMBER
IS
total_age INTEGER:=0;
avg_age NUMBER:= 0;
drIver_age NUMBER(2);
BEGIN
SELECT (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIrthDate))
INTO drIver_age
FROM DrIver WHERE ID=team_Id;
total_age := total_age + 1;
avg_age := avg_age + drIver_age;
avg_age := avg_age / total_age;
RETURN avg_age;
END;
/
*/


CREATE OR REPLACE FUNCTION Team_Driver_Age_Average
(team_id IN VARCHAR2)
RETURN NUMBER
IS
No_Team_Members EXCEPTION;
total_age INTEGER:=0;
avg_age NUMBER:= 0;
driver_age NUMBER(2);
cursor mycursor IS
SELECT (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BirthDate))
FROM DrIver WHERE ID=team_id;
BEGIN
OPEN mycursor;
LOOP
FETCH mycursor INTO driver_age;
EXIT WHEN mycursor%NOTFOUND;
total_age := total_age + 1;
avg_age := avg_age + driver_age;
END LOOP;
CLOSE mycursor;
IF total_age = 0 THEN
RAISE No_Team_Members;
END IF;
avg_age := avg_age / total_age;
RETURN avg_age;
EXCEPTION
WHEN No_Team_Members THEN
dbms_output.put_line('Cannot calculate the average. No team members found.');
RETURN -1;
END;
/



Alter table TEAM
ADD NBOFDRIVERS NUMBER(2);


desc team;













