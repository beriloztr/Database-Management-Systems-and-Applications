--Q1. This procedure deletes appointments that have been "Cancelled" for more than a week and displays an appropriate message or a warning message.

CREATE OR REPLACE PROCEDURE DeleteCancelledAppointments IS
BEGIN
    -- Delete appointments that are cancelled and older than 7 days
    DELETE FROM Appointments
    WHERE Status = 'Cancelled'
      AND AppointmentDate < SYSDATE - 7;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT ||' Cancelled appointments older than 7 days have been deleted.');
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('There is NO cancelled appointments older than 7 days.');
    END IF;

    COMMIT;
END;
/

SET SERVEROUTPUT ON;
BEGIN
  DELETECANCELLEDAPPOINTMENTS();
END;