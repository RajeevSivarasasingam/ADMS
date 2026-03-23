

CREATE DATABASE HospitalDB;
USE HospitalDB

-- show all views

SELECT table_name
FROM information_schema.views
WHERE table_schema = 'HospitalDB';

--show data form VIEW
SELECT * FROM view_name;

--01 Doctor Table
CREATE TABLE Doctor (
    Doctor_id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialisation VARCHAR(50),
    Phone VARCHAR(20)
);

--02 Patient Table
CREATE TABLE Patient (
    Patient_id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Birth_date DATE,
    Gender VARCHAR(10),
    Address VARCHAR(150)
);


--03 Appointment Table
CREATE TABLE Appointment (
    Appointment_id INT PRIMARY KEY,
    Patient_id INT,
    Doctor_id INT,
    Appointment_date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id)
);



--04 Treatment Table
CREATE TABLE Treatment (
    Treatment_id INT PRIMARY KEY,
    Appointment_id INT,
    Description VARCHAR(100),
    Cost DECIMAL(10,2),
    FOREIGN KEY (Appointment_id) REFERENCES Appointment(Appointment_id)
);

--05 Prescription Table
CREATE TABLE Prescription (
    Prescription_id INT PRIMARY KEY,
    Appointment_id INT,
    Medicine VARCHAR(100),
    Dosage VARCHAR(100),
    FOREIGN KEY (Appointment_id) REFERENCES Appointment(Appointment_id)
);



---INSERT DATA 

	 
INSERT INTO Doctor (doctor_id,name,specialisation,phone)
VALUES
(1,'Dr. John Doe','Cardiology','021-222-1234'),
(2,'Dr. Sarah Smith','Neurology','021-222-2345'),
(3,'Dr. James Brown','Pediatrics','021-222-3456'),
(4,'Dr. Lisa White','Orthopedics','021-222-4567'),
(5,'Dr. Michael Black','Dermatology','021-222-5678'),
(6,'Dr. Emily Green','General','021-222-6789'),
(7,'Dr. Daniel Lee','Cardiology','021-222-7890'),
(8,'Dr. Linda Clark','Neurology','021-222-8901'),
(9,'Dr. Steven Turner','Pediatrics','021-222-9012'),
(10,'Dr. Jessica Martinez','Orthopedics','021-222-0123');


INSERT INTO Patient (patient_id,name,birth_date,gender,address)
VALUES
(1,'Alice Johnson','1985-05-12','Female','123 Elm St'),
(2,'Bob Miller','1990-02-23','Male','456 Oak St'),
(3,'Charlie Davis','2001-07-30','Male','789 Pine St'),
(4,'Diana Wilson','1975-09-14','Female','101 Maple St'),
(5,'Eve Moore','1982-04-19','Female','202 Birch St'),
(6,'Frank Harris','1995-01-08','Male','303 Cedar St'),
(7,'Grace Clark','1989-12-25','Female','404 Pine St'),
(8,'Henry Lewis','2000-03-14','Male','505 Maple St'),
(9,'Irene Robinson','1983-06-22','Female','606 Oak St'),
(10,'Jack Walker','1998-11-01','Male','707 Birch St');	 


INSERT INTO Appointment (appointment_id,patient_id,doctor_id,appointment_date,status)
VALUES
(1,1,2,'2026-04-10','Scheduled'),
(2,2,1,'2026-04-15','Scheduled'),
(3,3,5,'2026-04-12','Scheduled'),
(4,4,3,'2026-04-20','Scheduled'),
(5,5,2,'2026-04-18','Scheduled'),
(6,6,4,'2026-04-25','Scheduled'),
(7,7,6,'2026-04-17','Scheduled'),
(8,8,7,'2026-04-22','Scheduled'),
(9,9,8,'2026-04-14','Scheduled'),
(10,10,9,'2026-04-24','Scheduled');


INSERT INTO Treatment (treatment_id,appointment_id,description,cost)
VALUES
(1,1,'X-ray',150.00),
(2,2,'MRI',300.00),
(3,3,'Blood Test',100.00),
(4,4,'Physical Therapy',200.00),
(5,5,'Medication',50.00),
(6,6,'Surgery',800.00),
(7,7,'MRI',300.00),
(8,8,'X-ray',150.00),
(9,9,'Blood Test',100.00),
(10,10,'Physical Therapy',200.00);


INSERT INTO Prescription (prescription_id,appointment_id,medicine,dosage)
VALUES
(1,1,'Paracetamol','1 tablet twice a day'),
(2,2,'Ibuprofen','2 tablets daily'),
(3,3,'Amoxicillin','1 capsule thrice a day'),
(4,4,'Metformin','1 tablet after meals'),
(5,5,'Lisinopril','1 tablet daily'),
(6,6,'Amlodipine','1 tablet daily'),
(7,7,'Paracetamol','1 tablet twice a day'),
(8,8,'Ibuprofen','2 tablets daily'),
(9,9,'Amoxicillin','1 capsule thrice a day'),
(10,10,'Metformin','1 tablet after meals');


--1. List all doctors. 
CREATE VIEW AllDoctors AS
SELECT * FROM Doctor;

SELECT * FROM AllDoctors;

	+-----------+----------------------+----------------+--------------+
	| Doctor_id | Name                 | Specialisation | Phone        |
	+-----------+----------------------+----------------+--------------+
	|         1 | Dr. John Doe         | Cardiology     | 021-222-1234 |
	|         2 | Dr. Sarah Smith      | Neurology      | 021-222-2345 |
	|         3 | Dr. James Brown      | Pediatrics     | 021-222-3456 |
	|         4 | Dr. Lisa White       | Orthopedics    | 021-222-4567 |
	|         5 | Dr. Michael Black    | Dermatology    | 021-222-5678 |
	|         6 | Dr. Emily Green      | General        | 021-222-6789 |
	|         7 | Dr. Daniel Lee       | Cardiology     | 021-222-7890 |
	|         8 | Dr. Linda Clark      | Neurology      | 021-222-8901 |
	|         9 | Dr. Steven Turner    | Pediatrics     | 021-222-9012 |
	|        10 | Dr. Jessica Martinez | Orthopedics    | 021-222-0123 |
	+-----------+----------------------+----------------+--------------+
	10 rows in set (0.00 sec)

--2. List all patients who are female. 
CREATE VIEW FemalePatients AS
SELECT * FROM Patient
WHERE Gender = 'Female';

SELECT * FROM FemalePatients;

	+------------+----------------+------------+--------+--------------+
	| Patient_id | Name           | Birth_date | Gender | Address      |
	+------------+----------------+------------+--------+--------------+
	|          1 | Alice Johnson  | 1985-05-12 | Female | 123 Elm St   |
	|          4 | Diana Wilson   | 1975-09-14 | Female | 101 Maple St |
	|          5 | Eve Moore      | 1982-04-19 | Female | 202 Birch St |
	|          7 | Grace Clark    | 1989-12-25 | Female | 404 Pine St  |
	|          9 | Irene Robinson | 1983-06-22 | Female | 606 Oak St   |
	+------------+----------------+------------+--------+--------------+
	5 rows in set (0.01 sec)

--3. Get all appointments for patient with `patient_id` = 3.
CREATE VIEW Patient3Appointments AS
SELECT * FROM Appointment
WHERE Patient_id = 3;

SELECT * FROM Patient3Appointments;
	+----------------+------------+-----------+------------------+-----------+
	| Appointment_id | Patient_id | Doctor_id | Appointment_date | Status    |
	+----------------+------------+-----------+------------------+-----------+
	|              3 |          3 |         5 | 2026-04-12       | Scheduled |
	+----------------+------------+-----------+------------------+-----------+
	1 row in set (0.00 sec)

--4. List all treatments with their costs.
CREATE VIEW TreatmentsWithCost AS
SELECT Description, Cost FROM Treatment;

SELECT * FROM TreatmentsWithCost;
	+------------------+--------+
	| Description      | Cost   |
	+------------------+--------+
	| X-ray            | 150.00 |
	| MRI              | 300.00 |
	| Blood Test       | 100.00 |
	| Physical Therapy | 200.00 |
	| Medication       |  50.00 |
	| Surgery          | 800.00 |
	| MRI              | 300.00 |
	| X-ray            | 150.00 |
	| Blood Test       | 100.00 |
	| Physical Therapy | 200.00 |
	+------------------+--------+
	10 rows in set (0.00 sec)	

--5. Get the total cost of treatments for patient with `patient_id` = 2.
CREATE VIEW Patient2TreatmentCost AS
SELECT SUM(T.Cost) AS TotalCost
FROM Treatment T
JOIN Appointment A ON T.Appointment_id = A.Appointment_id
WHERE A.Patient_id = 2;

SELECT * FROM Patient2TreatmentCost;

	+-----------+
	| TotalCost |
	+-----------+
	|    300.00 |
	+-----------+
	1 row in set (0.01 sec)

--6. Get the details of doctors who specialize in "Cardiology". 
CREATE VIEW CardiologyDoctors AS
SELECT * FROM Doctor
WHERE Specialisation = 'Cardiology';

SELECT * FROM CardiologyDoctors;
	+-----------+----------------+----------------+--------------+
	| Doctor_id | Name           | Specialisation | Phone        |
	+-----------+----------------+----------------+--------------+
	|         1 | Dr. John Doe   | Cardiology     | 021-222-1234 |
	|         7 | Dr. Daniel Lee | Cardiology     | 021-222-7890 |
	+-----------+----------------+----------------+--------------+
	2 rows in set (0.00 sec)

--7. List appointments scheduled after `2025-04-15`. 
CREATE VIEW AppointmentsAfterDate AS
SELECT * FROM Appointment
WHERE Appointment_date > '2025-04-15';

SELECT * FROM AppointmentsAfterDate;
	+----------------+------------+-----------+------------------+-----------+
	| Appointment_id | Patient_id | Doctor_id | Appointment_date | Status    |
	+----------------+------------+-----------+------------------+-----------+
	|              1 |          1 |         2 | 2026-04-10       | Scheduled |
	|              2 |          2 |         1 | 2026-04-15       | Scheduled |
	|              3 |          3 |         5 | 2026-04-12       | Scheduled |
	|              4 |          4 |         3 | 2026-04-20       | Scheduled |
	|              5 |          5 |         2 | 2026-04-18       | Scheduled |
	|              6 |          6 |         4 | 2026-04-25       | Scheduled |
	|              7 |          7 |         6 | 2026-04-17       | Scheduled |
	|              8 |          8 |         7 | 2026-04-22       | Scheduled |
	|              9 |          9 |         8 | 2026-04-14       | Scheduled |
	|             10 |         10 |         9 | 2026-04-24       | Scheduled |
	+----------------+------------+-----------+------------------+-----------+
	10 rows in set (0.01 sec)

--8. Find the most recent appointment for patient `1`. 
CREATE VIEW Patient1RecentAppointment AS
SELECT *
FROM Appointment
WHERE Patient_id = 1
ORDER BY Appointment_date DESC
LIMIT 1;

SELECT * FROM Patient1RecentAppointment;
	+----------------+------------+-----------+------------------+-----------+
	| Appointment_id | Patient_id | Doctor_id | Appointment_date | Status    |
	+----------------+------------+-----------+------------------+-----------+
	|              1 |          1 |         2 | 2026-04-10       | Scheduled |
	+----------------+------------+-----------+------------------+-----------+
	1 row in set (0.00 sec)




--9. List all patients who have a scheduled appointment with a doctor 
	-- -specializing in "Neurology". 
CREATE VIEW NeurologyPatients AS
SELECT DISTINCT P.*
FROM Patient P
JOIN Appointment A ON P.Patient_id = A.Patient_id
JOIN Doctor D ON A.Doctor_id = D.Doctor_id
WHERE D.Specialisation = 'Neurology';

SELECT * FROM NeurologyPatients;
	+------------+----------------+------------+--------+--------------+
	| Patient_id | Name           | Birth_date | Gender | Address      |
	+------------+----------------+------------+--------+--------------+
	|          1 | Alice Johnson  | 1985-05-12 | Female | 123 Elm St   |
	|          5 | Eve Moore      | 1982-04-19 | Female | 202 Birch St |
	|          9 | Irene Robinson | 1983-06-22 | Female | 606 Oak St   |
	+------------+----------------+------------+--------+--------------+
	3 rows in set (0.01 sec)


--10. Get all treatments that cost more than `200`. 
CREATE VIEW ExpensiveTreatments AS
SELECT * FROM Treatment
WHERE Cost > 200;

SELECT * FROM ExpensiveTreatments;
	+--------------+----------------+-------------+--------+
	| Treatment_id | Appointment_id | Description | Cost   |
	+--------------+----------------+-------------+--------+
	|            2 |              2 | MRI         | 300.00 |
	|            6 |              6 | Surgery     | 800.00 |
	|            7 |              7 | MRI         | 300.00 |
	+--------------+----------------+-------------+--------+
	3 rows in set (0.00 sec)

--11. List all doctors with their total number of appointments.
CREATE VIEW DoctorAppointmentsCount AS
SELECT D.Name, COUNT(A.Appointment_id) AS TotalAppointments
FROM Doctor D
LEFT JOIN Appointment A ON D.Doctor_id = A.Doctor_id
GROUP BY D.Name;

SELECT * FROM DoctorAppointmentsCount;
	+----------------------+-------------------+
	| Name                 | TotalAppointments |
	+----------------------+-------------------+
	| Dr. John Doe         |                 1 |
	| Dr. Sarah Smith      |                 2 |
	| Dr. James Brown      |                 1 |
	| Dr. Lisa White       |                 1 |
	| Dr. Michael Black    |                 1 |
	| Dr. Emily Green      |                 1 |
	| Dr. Daniel Lee       |                 1 |
	| Dr. Linda Clark      |                 1 |
	| Dr. Steven Turner    |                 1 |
	| Dr. Jessica Martinez |                 0 |
	+----------------------+-------------------+
	10 rows in set (0.01 sec)

--12. Get the most commonly prescribed medication. 
CREATE VIEW CommonMedication AS
SELECT Medicine, COUNT(*) AS TimesPrescribed
FROM Prescription
GROUP BY Medicine
ORDER BY TimesPrescribed DESC
LIMIT 1;

SELECT * FROM CommonMedication;
	+-------------+-----------------+
	| Medicine    | TimesPrescribed |
	+-------------+-----------------+
	| Paracetamol |               2 |
	+-------------+-----------------+
	1 row in set (0.00 sec)

--13. Find all patients who were born before `1990-01-01`.
CREATE VIEW PatientsBornBefore1990 AS
SELECT * FROM Patient
WHERE Birth_date < '1990-01-01';

SELECT * FROM  PatientsBornBefore1990;
	+------------+----------------+------------+--------+--------------+
	| Patient_id | Name           | Birth_date | Gender | Address      |
	+------------+----------------+------------+--------+--------------+
	|          1 | Alice Johnson  | 1985-05-12 | Female | 123 Elm St   |
	|          4 | Diana Wilson   | 1975-09-14 | Female | 101 Maple St |
	|          5 | Eve Moore      | 1982-04-19 | Female | 202 Birch St |
	|          7 | Grace Clark    | 1989-12-25 | Female | 404 Pine St  |
	|          9 | Irene Robinson | 1983-06-22 | Female | 606 Oak St   |
	+------------+----------------+------------+--------+--------------+
	5 rows in set (0.00 sec)
	
--14. List all prescriptions for the appointment with `appointment_id` = 6.
CREATE VIEW Appointment6Prescriptions AS
SELECT * FROM Prescription
WHERE Appointment_id = 6;

SELECT * FROM  Appointment6Prescriptions;
	+-----------------+----------------+------------+----------------+
	| Prescription_id | Appointment_id | Medicine   | Dosage         |
	+-----------------+----------------+------------+----------------+
	|               6 |              6 | Amlodipine | 1 tablet daily |
	+-----------------+----------------+------------+----------------+
	1 row in set (0.00 sec)

--15. Find the average cost of treatments per appointment.
 CREATE VIEW AvgTreatmentCost AS
SELECT AVG(Cost) AS AverageCost
FROM Treatment;

SELECT * FROM  AvgTreatmentCost;
	+-------------+
	| AverageCost |
	+-------------+
	|  235.000000 |
	+-------------+
	1 row in set (0.00 sec)
	

--16. Get all patients who have been prescribed "Ibuprofen". 
CREATE VIEW IbuprofenPatients AS
SELECT DISTINCT P.*
FROM Patient P
JOIN Appointment A ON P.Patient_id = A.Patient_id
JOIN Prescription PR ON A.Appointment_id = PR.Appointment_id
WHERE PR.Medicine = 'Ibuprofen';

SELECT * FROM IbuprofenPatients;
	+------------+-------------+------------+--------+--------------+
	| Patient_id | Name        | Birth_date | Gender | Address      |
	+------------+-------------+------------+--------+--------------+
	|          2 | Bob Miller  | 1990-02-23 | Male   | 456 Oak St   |
	|          8 | Henry Lewis | 2000-03-14 | Male   | 505 Maple St |
	+------------+-------------+------------+--------+--------------+
	2 rows in set (0.00 sec)


--17. List all treatments and the patients they were given to.
CREATE VIEW TreatmentsWithPatients AS
SELECT T.Description, P.Name
FROM Treatment T
JOIN Appointment A ON T.Appointment_id = A.Appointment_id
JOIN Patient P ON A.Patient_id = P.Patient_id;

SELECT * FROM TreatmentsWithPatients;
	+------------------+----------------+
	| Description      | Name           |
	+------------------+----------------+
	| X-ray            | Alice Johnson  |
	| MRI              | Bob Miller     |
	| Blood Test       | Charlie Davis  |
	| Physical Therapy | Diana Wilson   |
	| Medication       | Eve Moore      |
	| Surgery          | Frank Harris   |
	| MRI              | Grace Clark    |
	| X-ray            | Henry Lewis    |
	| Blood Test       | Irene Robinson |
	| Physical Therapy | Jack Walker    |
	+------------------+----------------+
	10 rows in set (0.00 sec)
	
--18. Get the total number of treatments provided. 
CREATE VIEW TotalTreatments AS
SELECT COUNT(*) AS TotalTreatments
FROM Treatment;

SELECT * FROM TotalTreatments;
	+-----------------+
	| TotalTreatments |
	+-----------------+
	|              10 |
	+-----------------+
	1 row in set (0.05 sec)


--19. Get the names of doctors who have treated patient `1`.
CREATE VIEW DoctorsForPatient1 AS
SELECT DISTINCT D.Name
FROM Doctor D
JOIN Appointment A ON D.Doctor_id = A.Doctor_id
WHERE A.Patient_id = 1;

SELECT * FROM DoctorsForPatient1 ;
	+-----------------+
	| Name            |
	+-----------------+
	| Dr. Sarah Smith |
	+-----------------+
	1 row in set (0.00 sec)

--20. List down the medicines and dosage prescribed for the patient with patient id 7. 
CREATE VIEW Patient7Prescriptions AS
SELECT PR.Medicine, PR.Dosage
FROM Prescription PR
JOIN Appointment A ON PR.Appointment_id = A.Appointment_id
WHERE A.Patient_id = 7;

SELECT * FROM Patient7Prescriptions;
	+-------------+----------------------+
	| Medicine    | Dosage               |
	+-------------+----------------------+
	| Paracetamol | 1 tablet twice a day |
	+-------------+----------------------+
	1 row in set (0.00 sec)

--21. Update the cost for X-ray to 300 and list the records of the view created in 
-- Question 4. State your observation on the X-ray cost. 
UPDATE Treatment
SET Cost = 300
WHERE Description = 'X-ray';

	-- View from Q4 will now show updated cost
SELECT * FROM TreatmentsWithCost;
	+------------------+--------+
	| Description      | Cost   |
	+------------------+--------+
	| X-ray            | 300.00 |
	| MRI              | 300.00 |
	| Blood Test       | 100.00 |
	| Physical Therapy | 200.00 |
	| Medication       |  50.00 |
	| Surgery          | 800.00 |
	| MRI              | 300.00 |
	| X-ray            | 300.00 |
	| Blood Test       | 100.00 |
	| Physical Therapy | 200.00 |
	+------------------+--------+
	10 rows in set (0.00 sec)
	

--22. Insert a new record into the doctor table with the following values: 
--	11  Dr. Smith Sebastian    Orthopedics     021-222-4433 
-- 	Describe your observation when selecting all the records from the view created in Question 1.

INSERT INTO Doctor VALUES (11, 'Dr. Smith Sebastian', 'Orthopedics', '021-222-4433');

	-- View from Q1 will now include the new doctor
SELECT * FROM AllDoctors;
	+-----------+----------------------+----------------+--------------+
	| Doctor_id | Name                 | Specialisation | Phone        |
	+-----------+----------------------+----------------+--------------+
	|         1 | Dr. John Doe         | Cardiology     | 021-222-1234 |
	|         2 | Dr. Sarah Smith      | Neurology      | 021-222-2345 |
	|         3 | Dr. James Brown      | Pediatrics     | 021-222-3456 |
	|         4 | Dr. Lisa White       | Orthopedics    | 021-222-4567 |
	|         5 | Dr. Michael Black    | Dermatology    | 021-222-5678 |
	|         6 | Dr. Emily Green      | General        | 021-222-6789 |
	|         7 | Dr. Daniel Lee       | Cardiology     | 021-222-7890 |
	|         8 | Dr. Linda Clark      | Neurology      | 021-222-8901 |
	|         9 | Dr. Steven Turner    | Pediatrics     | 021-222-9012 |
	|        10 | Dr. Jessica Martinez | Orthopedics    | 021-222-0123 |
	|        11 | Dr. Smith Sebastian  | Orthopedics    | 021-222-4433 |
	+-----------+----------------------+----------------+--------------+
	11 rows in set (0.00 sec)

--23. Delete a record from the view created in Question 4 and describe your 
--	 observation while listing down all the records from that view. 
DELETE FROM Treatment WHERE Treatment_id = 1;

	-- View from Q4 will now exclude deleted record
SELECT * FROM TreatmentsWithCost;
	+------------------+--------+
	| Description      | Cost   |
	+------------------+--------+
	| MRI              | 300.00 |
	| Blood Test       | 100.00 |
	| Physical Therapy | 200.00 |
	| Medication       |  50.00 |
	| Surgery          | 800.00 |
	| MRI              | 300.00 |
	| X-ray            | 300.00 |
	| Blood Test       | 100.00 |
	| Physical Therapy | 200.00 |
	+------------------+--------+
	9 rows in set (0.00 sec)

--24. List down all the views created by you for the hospital database.  
 SELECT table_name
FROM information_schema.views
WHERE table_schema = 'HospitalDB';
		+---------------------------+
		| TABLE_NAME                |
		+---------------------------+
		| alldoctors                |
		| appointment6prescriptions |
		| appointmentsafterdate     |
		| avgtreatmentcost          |
		| cardiologydoctors         |
		| commonmedication          |
		| doctorappointmentscount   |
		| doctorsforpatient1        |
		| expensivetreatments       |
		| femalepatients            |
		| ibuprofenpatients         |
		| neurologypatients         |
		| patient1recentappointment |
		| patient2treatmentcost     |
		| patient3appointments      |
		| patient7prescriptions     |
		| patientsbornbefore1990    |
		| totaltreatments           |
		| treatmentswithcost        |
		| treatmentswithpatients    |
		+---------------------------+
		20 rows in set (0.00 sec)

--25. Delete the view created for Question 20 and list down all the views created by 
--	you again.
DROP VIEW `Patient7Prescriptions`;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

	+---------------------------+------------+
	| Tables_in_hospitaldb      | Table_type |
	+---------------------------+------------+
	| alldoctors                | VIEW       |
	| appointment6prescriptions | VIEW       |
	| appointmentsafterdate     | VIEW       |
	| avgtreatmentcost          | VIEW       |
	| cardiologydoctors         | VIEW       |
	| commonmedication          | VIEW       |
	| doctorappointmentscount   | VIEW       |
	| doctorsforpatient1        | VIEW       |
	| expensivetreatments       | VIEW       |
	| femalepatients            | VIEW       |
	| ibuprofenpatients         | VIEW       |
	| neurologypatients         | VIEW       |
	| patient1recentappointment | VIEW       |
	| patient2treatmentcost     | VIEW       |
	| patient3appointments      | VIEW       |
	| patientsbornbefore1990    | VIEW       |
	| totaltreatments           | VIEW       |
	| treatmentswithcost        | VIEW       |
	| treatmentswithpatients    | VIEW       |
	+---------------------------+------------+
	19 rows in set (0.01 sec)