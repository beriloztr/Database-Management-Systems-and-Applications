CREATE OR REPLACE PROCEDURE greetings
IS 
BEGIN
dbms_output.put_line('greetings');
END;
/
EXECUTE greetings;
BEGIN
greetings();
END;
/
SHOW ERRORS PROCEDURE GREETINGS;

drop procedure greetings;
