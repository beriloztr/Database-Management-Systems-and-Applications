CREATE OR REPLACE VIEW borrowingInfo AS
    SELECT s.STID, s.STNAME, s.STSURNAME, COUNT(*) Total
    FROM STUDENTS s, BORROWING b
    WHERE s.STID = b.STUID
    group by s.STID, s.STNAME, s.STSURNAME
    order by s.stid;  

SELECT * from borrowingInfo;

CREATE OR REPLACE PROCEDURE CALCULATEPUNISHMENT AS
CURSOR cur IS
    SELECT * FROM BORROWING;
c_row cur%ROWTYPE;
BEGIN
OPEN cur;
LOOP
FETCH cur INTO c_row;
EXIT WHEN cur%NOTFOUND;
IF c_row.duedate - c_row.returndate < 0 THEN
update BORROWING 
set punishment = (c_row.returndate - c_row.duedate)*2.25
where stuid = c_row.stuid;
END IF;
END LOOP;
dbms_output.put_line(cur%rowcount || 'records have been updated');
dbms_output.put_line('punishmnet calculation done');
CLOSE cur;
END;
/

set SERVEROUTPUT on;
BEGIN
CALCULATEPUNISHMENT();
END;
/



CREATE OR REPLACE PROCEDURE DISPLAYBOOKS AS
CURSOR cur IS
    SELECT * FROM BOOKS
    WHERE STATUS = 'A';
c_row cur%ROWTYPE;
BEGIN
OPEN cur;
dbms_output.put_line('List Of Available Books: ');
LOOP
FETCH cur INTO c_row;
EXIT WHEN cur%NOTFOUND;
dbms_output.put_line(c_row.ISBN || c_row.title || c_row.STATUS);
END LOOP;
CLOSE cur;
END;
/

set SERVEROUTPUT on;
BEGIN
DISPLAYBOOKS();
end;
/

create or replace procedure borrowbook
(BOOKisbn IN varchar2, stuId IN number )
AS
    bstatus char(1);
BEGIN
    select status INTO bstatus
    from books
    where isbn = BOOKisbn;

    IF bstatus = 'A' THEN
    INSERT INTO BORROWING (STUID, BISBN, BORROWDATE, returndate, DUEDATE, PUNISHMENT)
    VALUES (stuId, BOOKisbn, TO_DATE(sysdate, 'DD/MM/YYYY'), NULL ,TO_DATE(sysdate, 'DD/MM/YYYY') + 15, 0);

    UPDATE BOOKS 
    SET status = 'N'
    WHERE isbn = BOOKisbn;

    dbms_output.put_line('The Book '||BOOKisbn||' borrowed');
    commit;

    ELSE
   dbms_output.put_line('Sorry! The Book '||BOOKisbn || ' is NOT available');
    end IF;
end;
/

SET SERVEROUTPUT ON;
accept bisbn PROMPT 'Enter the ISBN of the book: ';
accept stuid PROMPT 'Enter the Student Id: ';

DECLARE 
    bisbn varchar2(10);
    stuid number(3);
BEGIN
borrowbook(&bisbn, &stuid);
END;
/

CREATE OR REPLACE FUNCTION PunishmentLevel
RETURN NUMBER
IS
  CURSOR cur IS
      SELECT s.stid, s.stname, s.stsurname, SUM(PUNISHMENT) totalPunishment
      FROM students s, borrowing b
      WHERE s.stid = stuid
      GROUP BY s.stid, s.stname, s.stsurname;
      
c_row cur%ROWTYPE;
userLevel varchar2(20);
cntRedLevel number(3) := 0;
BEGIN
FOR c_row IN cur
LOOP
CASE 
WHEN c_row.totalPunishment > 10 THEN 
userLevel := 'red';
WHEN  c_row.totalPunishment > 1 and  c_row.totalPunishment <= 10 THEN
userLevel := 'yellow';
ELSE 
userLevel := 'green';
END CASE;
IF userLevel = 'red' THEN
cntRedLevel := cntRedLevel + 1;
END IF;
 DBMS_OUTPUT.PUT_LINE(c_row.stid||' '||c_row.stname||' '||c_row.stsurname||': '||userLevel||' user with the punishment payment '||c_row.totalPunishment||' TL');
END LOOP;
RETURN cntRedLevel;
END;
/

set SERVEROUTPUT on;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Total nb of red users: ' ||PunishmentLevel());  
END;
/
-----

CREATE OR REPLACE FUNCTION PunishmentLevel1
RETURN NUMBER
IS
  CURSOR cur IS
      SELECT s.stid, s.stname, s.stsurname, SUM(PUNISHMENT) totalPunishment
      FROM students s, borrowing b
      WHERE s.stid = stuid
      GROUP BY s.stid, s.stname, s.stsurname;
c_row cur%ROWTYPE;
userLevel varchar2(20);
cntRedLevel number(3) := 0;
BEGIN
FOR c_row IN cur
LOOP
CASE 
WHEN c_row.totalPunishment > 10 THEN 
userLevel := 'red';
WHEN  c_row.totalPunishment > 1 and  c_row.totalPunishment <= 10 THEN
userLevel := 'yellow';
ELSE 
userLevel := 'green';
END CASE;
IF userLevel = 'red' THEN
cntRedLevel := cntRedLevel + 1;
END IF;
 DBMS_OUTPUT.PUT_LINE(c_row.stid||' '||c_row.stname||' '||c_row.stsurname||': '||userLevel||' user with the punishment payment '||c_row.totalPunishment||' TL');
END LOOP;
RETURN cntRedLevel;
END;
/

