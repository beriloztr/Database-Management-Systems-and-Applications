create or replace PROCEDURE DoctorAppointments IS
    CURSOR docCrs IS
        SELECT DoctorID, DName
        FROM Doctors;

    doc_rec docCrs%ROWTYPE;

    AppCount NUMBER;
BEGIN
    FOR doc_rec IN docCrs LOOP
        -- Count the number of appointments for the current doctor
        SELECT COUNT(*) INTO AppCount
        FROM Appointments
        WHERE DoctorID = doc_rec.doctorid;

        -- Display doctor details
        DBMS_OUTPUT.PUT_LINE(CHR(10)||'Doctor: ' || doc_rec.DName);
        DBMS_OUTPUT.PUT_LINE('Number of Appointments: ' || AppCount);
        DBMS_OUTPUT.PUT_LINE('***********************');


        IF AppCount > 0 THEN
            -- Display each appointment details for the current doctor
            FOR app_rec IN (
                SELECT AppointmentDate, AppointmentTime, pName
                FROM Appointments
                JOIN Patients USING(PatientID)
                where doctorid=doc_rec.doctorid
            ) LOOP
                    DBMS_OUTPUT.PUT_LINE('Appointment Info: ' || TO_CHAR(app_rec.AppointmentDate, 'YYYY-MM-DD')|| 
                    ' @'||app_rec.AppointmentTime||', '||app_rec.pName);
                                
            END LOOP;
        ELSE
            -- Display a warning if no appointments are found
            DBMS_OUTPUT.PUT_LINE('No appointments found for Doctor: ' || doc_rec.DName);
        END IF;
        DBMS_OUTPUT.PUT_LINE('-------------------------');
    END LOOP;
END; 
/

SET SERVEROUTPUT ON;
BEGIN
  DOCTORAPPOINTMENTS();
END;
