
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employee CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE patient CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Appointment CASCADE CONSTRAINTS';
    EXCEPTION
    WHEN OTHERS THEN NULL;
END;





CREATE TABLE employee
(
    employee_Id   Varchar(20) NOT NULL,
    skill_id      varchar(20),
    employee_Name Varchar(50),
    age           integer,
    phone_number  varchar(20),
    gender        varchar(20),
    address       varchar(50),
    salary        number(10, 2),
    job_role      varchar(20),
    PRIMARY KEY (employee_Id)
);

CREATE TABLE patient
(
    patient_Id   Varchar(20) NOT NULL,
    patient_Name Varchar(50),
    age          integer,
    phone_number varchar(20),
    gender       varchar(20),
    PRIMARY KEY (patient_Id)
);


CREATE TABLE Appointment
(
    Appointment_Id Varchar(20) NOT NULL,
    Start_Time     Timestamp,
    End_Time       Timestamp,
    patient_id     varchar(20),
    employee_id    varchar(20),
    PRIMARY KEY (Appointment_Id),
    FOREIGN KEY (patient_id) REFERENCES patient (patient_id),
    FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
);

insert into employee (employee_Id, employee_Name, age, phone_number, gender, address, salary, job_role)
select 'EMP01',
       'John Doe',
       '32',
       '+1(213)346-5098',
       'Male',
       '123 jade avenue',
       10000,
       'Front_Office Worker'
from dual
union all
select 'EMP02',
       'Micheal Sebastian',
       '30',
       '+1(213)146-5098',
       'Male',
       '123 jade avenue',
       20000,
       'doctor'
from dual
union all
select 'EMP03',
       'Jim Gingrich',
       '40',
       '+1(212)246-5198',
       'Male',
       '234 vermont avenue',
       30000,
       'doctor'
from dual
union all
select 'EMP04',
       'Timothy Cook',
       '35',
       '+1(213)346-5028',
       'Male',
       '345 adams avenue',
       40000,
       'Front_Office Worker'
from dual
union all
select 'EMP05',
       'Ron Weasley',
       '24',
       '+1(214)446-5093',
       'Male',
       '456 hollywood avenue',
       60000,
       'Front_Office Worker'
from dual
union all
select 'EMP06',
       'Olivia Potter',
       '26',
       '+1(215)546-5498',
       'Female',
       '567 central perk avenue',
       70000,
       'doctor'
from dual
union all
select 'EMP07',
       'Ken Tribiani',
       '39',
       '+1(216)946-5058',
       'Male',
       '568 regal avenue',
       90000,
       'doctor'
from dual
union all
select 'EMP08',
       'Daryl Bing',
       '41',
       '+1(217)746-5096',
       'Male',
       '321 catalina avenue',
       100000,
       'doctor'
from dual
union all
select 'EMP09',
       'Linda Green',
       '33',
       '+1(218)846-5097',
       'Female',
       '543 hoover avenue',
       35000,
       'doctor'
from dual
union all
select 'EMP10',
       'Greg Buffey',
       '36',
       '+1(212)046-5098',
       'Male',
       '765 figueroa avenue',
       56000,
       'doctor'
from dual
union all
select 'EMP11',
       'Monica Geller',
       '27',
       '+1(213)246-5099',
       'Female',
       '987 27th street',
       67000,
       'doctor'
from dual
union all
select 'EMP12',
       'Rachel Carpenter',
       '22',
       '+1(214)846-4128',
       'Female',
       '780 35th street',
       78000,
       'Front_Office Worker'
from dual
union all
select 'EMP13',
       'Monalisa Granger',
       '30',
       '+1(213)146-5048',
       'Male',
       '1235 jade avenue',
       20000,
       'doctor'
from dual
union all
select 'EMP14',
       'Cleo Pater',
       '30',
       '+1(213)146-2048',
       'Male',
       '1237 jade avenue',
       20000,
       'doctor'
from dual
union all
select 'EMP15',
       'Mason Sebastian',
       '30',
       '+1(213)166-5098',
       'Male',
       '1230 jade avenue',
       20000,
       'Front_Office Worker'
from dual
union all
select 'EMP16',
       'Daniel Kim',
       '30',
       '+1(213)106-5098',
       'Male',
       '150 jade avenue',
       20000,
       'doctor'
from dual
union all
select 'EMP17',
       'Donald Trump',
       '24',
       '+1(217)446-5093',
       'Male',
       '123 Florida Avenue',
       60000,
       'doctor'
from dual
union all
select 'EMP18',
       'Hermione Geeter',
       '24',
       '+1(210)446-1223',
       'Female',
       '456 hollywood avenue',
       60000,
       'Front_Office Worker'
from dual
union all
select 'EMP19',
       'Phoebe Buffey',
       '22',
       '+1(214)806-4028',
       'Female',
       '780 35th street',
       78000,
       'doctor'
from dual
union all
select 'EMP20',
       'Saraswati Pandit',
       '22',
       '+1(210)850-4128',
       'Female',
       '780 35th street',
       78000,
       'Front_Office Worker'
from dual
union all
select 'EMP21',
       'Parth Patel',
       '22',
       '+1(510)846-4128',
       'Male',
       '780 35th street',
       78000,
       'doctor'
from dual;

insert into patient (patient_Id, patient_Name, age, phone_number, gender)
select 'PAT01', 'Walker Doe', '32', '+1(510)346-5098', 'Male'
from dual
union all
select 'PAT02', 'Marley Sebastian', '30', '+1(210)146-5098', 'Male'
from dual
union all
select 'PAT03', 'Sawyer Gingrich', '40', '+1(210)246-5198', 'Male'
from dual
union all
select 'PAT04', 'Holden Cook', '35', '+1(217)346-5028', 'Male'
from dual
union all
select 'PAT05', 'Nash Weasley', '24', '+1(210)446-5093', 'Male'
from dual
union all
select 'PAT06', 'Journey Potter', '26', '+1(213)546-5498', 'Female'
from dual
union all
select 'PAT07', 'Brecket Tribiani', '39', '+1(510)946-5058', 'Male'
from dual
union all
select 'PAT08', 'Preston Bing', '41', '+1(210)746-5096', 'Male'
from dual
union all
select 'PAT09', 'Blake Green', '33', '+1(210)846-5097', 'Female'
from dual
union all
select 'PAT10', 'Graham Buffey', '36', '+1(217)046-5098', 'Male'
from dual
union all
select 'PAT11', 'Andrea Geller', '27', '+1(510)246-5099', 'Female'
from dual
union all
select 'PAT12', 'Eloise Carpenter', '22', '+1(215)846-4128', 'Female'
from dual
union all
select 'PAT13', 'Venessa Granger', '30', '+1(210)146-5048', 'Male'
from dual
union all
select 'PAT14', 'Spenser Pater', '30', '+1(215)146-2048', 'Male'
from dual
union all
select 'PAT15', 'Edwin Sebastian', '30', '+1(210)166-5098', 'Male'
from dual
union all
select 'PAT16', 'Sam Kim', '30', '+1(215)106-5098', 'Male'
from dual
union all
select 'PAT17', 'Denver Trump', '24', '+1(216)446-5093', 'Male'
from dual
union all
select 'PAT18', 'Alden Geeter', '24', '+1(215)446-1223', 'Female'
from dual
union all
select 'PAT19', 'Henley Buffey', '22', '+1(213)806-4028', 'Female'
from dual
union all
select 'PAT20', 'Chitra Pandit', '22', '+1(215)850-4128', 'Female'
from dual
union all
select 'PAT21', 'Rahul Patel', '22', '+1(210)846-4128', 'Male'
from dual;

insert into appointment (appointment_id, start_time, end_time, patient_id, employee_id)
select '#id11', timestamp'2021-01-11 22:50:00.0000', timestamp'2021-01-11 23:22:00.0000', 'PAT01', 'EMP01'
from dual
union all
select '#id12', timestamp'2021-01-12 22:49:00.0000', timestamp'2021-01-12 23:23:00.0000', 'PAT02', 'EMP01'
from dual
union all
select '#id13', timestamp'2021-01-13 22:48:00.0000', timestamp'2021-01-13 23:24:00.0000', 'PAT03', 'EMP07'
from dual
union all
select '#id14', timestamp'2021-01-14 22:47:00.0000', timestamp'2021-01-14 23:25:00.0000', 'PAT04', 'EMP06'
from dual
union all
select '#id15', timestamp'2021-01-15 22:46:00.0000', timestamp'2021-01-15 23:26:00.0000', 'PAT05', 'EMP05'
from dual
union all
select '#id16', timestamp'2021-01-16 22:45:00.0000', timestamp'2021-01-16 23:27:00.0000', 'PAT06', 'EMP03'
from dual
union all
select '#id17', timestamp'2021-01-17 22:44:00.0000', timestamp'2021-01-17 23:28:00.0000', 'PAT07', 'EMP02'
from dual
union all
select '#id18', timestamp'2021-01-18 22:43:00.0000', timestamp'2021-01-18 23:29:00.0000', 'PAT08', 'EMP01'
from dual
union all
select '#id19', timestamp'2021-01-19 22:42:00.0000', timestamp'2021-01-19 23:30:00.0000', 'PAT09', 'EMP08'
from dual
union all
select '#id20', timestamp'2021-01-20 22:41:00.0000', timestamp'2021-01-20 23:31:00.0000', 'PAT10', 'EMP05'
from dual
union all
select '#id21', timestamp'2021-01-21 22:40:00.0000', timestamp'2021-01-21 23:32:00.0000', 'PAT11', 'EMP05'
from dual
union all
select '#id22', timestamp'2021-01-22 22:39:00.0000', timestamp'2021-01-22 23:33:00.0000', 'PAT12', 'EMP06'
from dual
union all
select '#id23', timestamp'2021-01-23 22:38:00.0000', timestamp'2021-01-23 23:34:00.0000', 'PAT13', 'EMP05'
from dual
union all
select '#id24', timestamp'2021-01-24 22:37:00.0000', timestamp'2021-01-24 23:35:00.0000', 'PAT14', 'EMP08'
from dual
union all
select '#id25', timestamp'2021-01-25 22:36:00.0000', timestamp'2021-01-25 23:36:00.0000', 'PAT15', 'EMP09'
from dual
union all
select '#id26', timestamp'2021-01-26 22:35:00.0000', timestamp'2021-01-26 23:37:00.0000', 'PAT16', 'EMP09'
from dual
union all
select '#id27', timestamp'2021-01-27 22:34:00.0000', timestamp'2021-01-27 23:38:00.0000', 'PAT17', 'EMP09'
from dual
union all
select '#id28', timestamp'2021-01-28 22:33:00.0000', timestamp'2021-01-28 23:39:00.0000', 'PAT18', 'EMP09'
from dual
union all
select '#id29', timestamp'2021-01-29 22:32:00.0000', timestamp'2021-01-29 23:40:00.0000', 'PAT19', 'EMP08'
from dual;

SELECT AP.employee_id, EM.employee_name
FROM ((SELECT employee_id,
              COUNT(employee_id) as "top_performer"
       FROM appointment
       GROUP BY employee_id
       ORDER BY "top_performer" DESC) AP
         inner join employee EM on AP.employee_id = EM.employee_id)
WHERE ROWNUM <= 3;
