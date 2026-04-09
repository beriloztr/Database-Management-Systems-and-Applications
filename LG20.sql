create or replace PROCEDURE ScheduleAppoIntment 
(
    AppID IN NUMBER,
    PatID IN NUMBER,
    docID IN NUMBER,
    AppDate IN DATE,
    AppTime IN VARCHAR2
) AS
a_ID number;
d_ID number;
p_ID number;

BEGIN 
SELECT APPOINTMENTID INTO a_ID 
FROM APPOINTMENTS
WHERE APPOINTMENTID = AppID;

IF sql%FOUND THEN
dbms_output.put_line('Appointment id already exists.');

ELSE
    SELECT DOCTORID INTO d_ID 
    FROM APPOINTMENTS
    WHERE DOCTORID = docID;
    
    IF sql%NOTFOUND THEN
        dbms_output.put_line('no doc id valid');
    ELSE
        SELECT PATIENTID INTO p_ID 
        FROM APPOINTMENTS
        WHERE DOCTORID = docID;
        
        IF sql%NOTFOUND THEN
          dbms_output.put_line('no doc id valid');
         ELSE
            INSERT INTO APPOINTMENTS (APPOINTMENTID, PATIENTID, DOCTORID, APPOINTMENTDATE, APPOINTMENTTIME, STATUS)
            VALUES(AppID, PatID, docID, AppDate, AppTime, 'Scheduled');
            commit;
            dbms_output.put_line('Appointment Scheduled successfully.');
END IF;
END IF;
END IF;

END;
/


SET SERVEROUTPUT ON;
Accept AppID NUMBER PROMPT 'Enter Appointment ID: ';
Accept PatID NUMBER PROMPT 'Enter Patient ID';
Accept DocID NUMBER PROMPT 'Enter Doctor ID';
Accept AppDate DATE PROMPT 'Enter Appointment Date';
Accept AppTime CHAR PROMPT 'Enter Appointment Time';
BEGIN

ScheduleAppoIntment (&AppID, &PatID, &DocID, TO_DATE('&AppDate', 'DD-MON-RR'), '&AppTime');
END;
/
-- WHY WRONG

CREATE OR REPLACE PROCEDURE DisplayMedicalHistory (PatID IN NUMBER) IS
  CURSOR cur IS
    SELECT DIAGNOSIS, TREATMENT, RECORDDATE
    FROM MEDICALRECORDS
    WHERE PATIENTID = PatID;
  r_cur cur%ROWTYPE;
BEGIN
  OPEN cur;
  FETCH cur INTO r_cur;
  
  IF cur%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('No record for the patient.');
  ELSE
    LOOP
      DBMS_OUTPUT.PUT_LINE('Diagnosis: ' || r_cur.Diagnosis || 
                           ', Treatment: ' || r_cur.Treatment || 
                           ', Date: ' || TO_CHAR(r_cur.RecordDate, 'YYYY-MM-DD'));
      
      FETCH cur INTO r_cur;
      EXIT WHEN cur%NOTFOUND;
    END LOOP;
  END IF;
  
  CLOSE cur;
END;
/

set serveroutput on;
DECLARE 
EnterpatientID number;
BEGIN
DisplayMedicalHistory(&EnterpatientID);

END;
/

/*
SET SERVEROUTPUT ON;
DECLARE
PrescriptionID NUMBER := 4;
AppointmentID NUMBER := 6;
Medicine VARCHAR2(100) := 'Paracetamol';
Dosage VARCHAR2(50) := '500mg';
Duration VARCHAR2(50) := '5 days';
Instructions VARCHAR2(200) := 'Take 1 tablet every 6 hours';
BEGIN
-- Call the RecordPrescription procedure with sample data
RecordPrescription (PrescriptionID, AppointmentID, Medicine, Dosage, Duration, Instructions);
END;
/
*/