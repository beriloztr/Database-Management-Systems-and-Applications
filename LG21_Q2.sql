--This function calculates and displays the age of a given patient.
CREATE OR REPLACE FUNCTION CalculateAge
(PID IN NUMBER) 
RETURN NUMBER IS
    BirthDate DATE;
    Age NUMBER;
BEGIN
    -- Get the patient's birthdate
    SELECT BirthDate  INTO BirthDate
    FROM Patients
    WHERE PatientID = PID;
    
    -- Calculate the age of the patient
    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, BirthDate) / 12) INTO Age 
    FROM dual;

    RETURN Age;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Patient with id '||pid||' NOT FOUND!');
    RETURN -1;
END;
/

SET SERVEROUTPUT ON;

ACCEPT pid PROMPT 'Please enter the patient id: ';
DECLARE
  pAge NUMBER;
BEGIN
    pAge:= CALCULATEAGE(&PID);
  
    if pAge != -1 then 
        DBMS_OUTPUT.PUT_LINE('Age of the patient is: ' || pAge);
    end if;

END;
