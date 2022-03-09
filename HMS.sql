drop database if exists hospital_db ;
create database if not exists hospital_db ;
use hospital_db ;

#1 Patients table
CREATE TABLE if not exists patients(
Email VARCHAR(50) PRIMARY KEY,
Age VARCHAR(30) NOT NULL,
Name VARCHAR(50) NOT NULL,
Address VARCHAR(60) NOT NULL,
Gender VARCHAR(20) NOT NULL );


#2 Schedule Table
CREATE TABLE if not exists schedule(
P_ID int NOT NULL,
Start_Time TIME NOT NULL,
End_Time TIME NOT NULL,
Breaks TIME NOT NULL,
Day varchar(20) NOT NULL,
PRIMARY KEY (P_ID, Start_Time, End_Time, Breaks, Day) );

#3 Doctors table
CREATE TABLE if not exists doctors(
Email varchar(50) PRIMARY KEY,
Gender varchar(20) NOT NULL,
Password varchar(30) NOT NULL,
Name varchar(50) NOT NULL );

describe doctors ;
describe schedule ;

#4 appointments table
CREATE TABLE appointments(
P_ID int PRIMARY KEY,
Date DATE NOT NULL,
Start_Time TIME NOT NULL,
End_Time TIME NOT NULL,
Status varchar(15) NOT NULL );

#5 patients_medical history
CREATE TABLE if not exists patients_medical_history(
Patient varchar(50) NOT NULL,
History int NOT NULL,
FOREIGN KEY (Patient) REFERENCES patients (Email) ON DELETE CASCADE,
FOREIGN KEY (History) REFERENCES medical_history (P_ID) ON DELETE CASCADE,
PRIMARY KEY (History) );

#6 Patients_appointment table
CREATE TABLE if not exists patients_appointments(
patient varchar(50) NOT NULL,
appt int NOT NULL,
concerns varchar(40) NOT NULL,
symptoms varchar(40) NOT NULL,
FOREIGN KEY (patient) REFERENCES patients (Email) ON DELETE CASCADE,
FOREIGN KEY (appt) REFERENCES appointments (P_ID) ON DELETE CASCADE,
PRIMARY KEY (patient, appt) );
describe patients_appointments ;

#7 Doctors_schedules table
CREATE TABLE if not exists doctors_schedules(
sched int NOT NULL,
doctor varchar(50) NOT NULL,
FOREIGN KEY (sched) REFERENCES schedule (P_ID) ON DELETE CASCADE,
FOREIGN KEY (doctor) REFERENCES doctors (Email) ON DELETE CASCADE,
PRIMARY KEY (sched, doctor) );

#8 Doctors_diagnosis
CREATE TABLE if not exists doctors_diagnosis(
appt int NOT NULL,
doctor varchar(50) NOT NULL,
diagnosis varchar(40) NOT NULL,
prescription varchar(50) NOT NULL,
FOREIGN KEY (appt) REFERENCES appointments (P_ID) ON DELETE CASCADE,
FOREIGN KEY (doctor) REFERENCES doctors (Email) ON DELETE CASCADE,
PRIMARY KEY (appt, doctor) );

#9 Medical history
CREATE TABLE medical_history (
P_ID int PRIMARY KEY,
Date DATE NOT NULL,
Conditions VARCHAR(100) NOT NULL,
Surgeries VARCHAR(100) NOT NULL,
Medication VARCHAR(100) NOT NULL );

show tables ;

#Users Creation
CREATE USER 'yograj'@'localhost' IDENTIFIED BY 'yograj' ;
CREATE USER 'yogesh'@'localhost' IDENTIFIED BY 'yogesh' ;
CREATE USER 'ayushi'@'localhost' IDENTIFIED BY 'ayushi' ;
CREATE USER 'manyata'@'localhost' IDENTIFIED BY 'manyata' ;
CREATE USER 'pooja'@'localhost' IDENTIFIED BY 'pooja' ;
CREATE USER 'dhruv'@'localhost' IDENTIFIED BY 'dhruv' ;

#patient
grant  select  on  hospital_db.patients  to  'dhruv'@'localhost'  ;
grant  select  on  hospital_db.patients_medical_history  to  'dhruv'@'localhost'  ;
grant  select  on  hospital_db. patients_appointments  to  'dhruv'@'localhost'  ;
grant  select  on  hospital_db.doctors  to  'dhruv'@'localhost'  ;

#dba
GRANT create,drop, select  ON hospital_db.*  TO 'yograj'@'localhost' with grant option ;

#admin
GRANT select, insert, update, delete   ON hospital_db.*  TO 'yogesh'@'localhost' ;

#receptionist
GRANT select ON hospital_db.*  TO 'ayushi'@'localhost' ;
GRANT insert, update, delete ON hospital_db.patients_appointments TO 'ayushi'@'localhost' ;
GRANT insert, update, delete ON hospital_db.doctors_diagnosis TO 'ayushi'@'localhost' ;

#doctor
GRANT select   ON hospital_db.patients TO 'manyata'@'localhost' ;
GRANT select   ON hospital_db.doctors TO 'manyata'@'localhost' ;
GRANT select   ON hospital_db.doctors_schedule TO 'manyata'@'localhost' ;
GRANT select   ON hospital_db.doctors_diagnosis TO 'manyata'@'localhost' ;
GRANT select,insert,update ON hospital_db.patients_medical_history TO 'manyata'@'localhost' ;
GRANT select   ON hospital_db.doctors_diagnosis TO 'manyata'@'localhost' ;

#nurse
GRANT select   ON hospital_db.patients TO 'pooja'@'localhost' ;
GRANT select   ON hospital_db.doctors TO 'pooja'@'localhost' ;
GRANT select   ON hospital_db.schedule TO 'pooja'@'localhost' ;

