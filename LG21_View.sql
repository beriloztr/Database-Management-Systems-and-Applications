Create or Replace view AppointmentCntView
AS
Select Doctorid, Dname, Specialty, count(*) NumberOFAppointments
from Doctors 
join Appointments using (Doctorid)
group by Doctorid, Dname, Specialty;

Select * from AppointmentCntView;
