Links to the Answers:

       Question1: 

       https://livesql.oracle.com/apex/livesql/s/lgi5trsy4c2a3mr4p29ig42tq

       Question2:

       https://livesql.oracle.com/apex/livesql/s/lgi3h3n3heqx8l8hbn4mka6oi 

       Question3:

       https://livesql.oracle.com/apex/livesql/s/lgi79nyr3alro5563juymsfb5

        Question4:

       https://livesql.oracle.com/apex/livesql/s/lgiwokn63atkjmdxkmimynybi



SQL Queries for the Questions:

Question1:
Given a time range (eg. Jan 1 to Jan 31, 2021), in that interval, what is the average amount a procedure cost, and how long did it take on the average?

Answer :

Assumption:

The Billing_Record table consist of all the transaction records of the patient billing. This includes billings done on the procedures that the patients undergo. The table is related to appointment, procedure and provider tables. 

This query gives us the average billed cost per procedure in the given date.

•	First, we are joining Billing record with procedure and appointment using left join operation.
•	Then we filter the result to a given time range (eg. Jan 1 to Jan 31, 2021).
•	Group by procedure_id.
•	Projecting the procedure_id and average billed amount


select Procedure_id
     , round(avg(Total_Billed_Amount), 3)                                   AVG_BILLED_AMOUNT
     , round(avg(to_number(extract(HOUR from end_time - start_time)) * 60 +
                 to_number(extract(MINUTE from end_time - start_time))), 3) AVG_PROCEDURE_TIME
from Billing_record B --LEFT JOIN PROCEDURE P ON B.PROCEDURE_ID = P.PROCEDURE_ID
         LEFT JOIN appointment A ON B.appointment_id = A.appointment_id
where Date_billed >= date'2021-01-01'
  and Date_billed < date'2021-01-31'
group by Procedure_id;


scenario 2: This query gives us the average billed cost for all the procedures combined.

select round(avg(Total_Billed_Amount), 3)                                   AVG_BILLED_AMOUNT
     , round(avg(to_number(extract(HOUR from end_time - start_time)) * 60 +
                 to_number(extract(MINUTE from end_time - start_time))), 3) AVG_PROCEDURE_TIME
from Billing_record B --LEFT JOIN PROCEDURE P ON B.PROCEDURE_ID = P.PROCEDURE_ID
         LEFT JOIN appointment A ON B.appointment_id = A.appointment_id
where Date_billed >= date'2021-01-01'
  and Date_billed < date'2021-01-31';


Question2:
Given a date, what is the income for that date, from all the procedures performed that day? The owners could run this daily, to chart income, cumulative income, etc.
Answer :

Assumption:
The Billing_Record table consist of all the transaction records of the patient billing. This includes billings done on the procedures that the patients undergo.

select Date_billed, sum(round((Total_Billed_Amount), 3)) as Total_Income
from Billing_record
where Date_billed = date'2021-01-20'
group by date_billed;

scenario2:This query gives the results for all the dates.

select Date_billed, sum(round((Total_Billed_Amount), 3)) as Total_Income
from Billing_record
group by date_billed order by date_billed;


Question3:

The owners have asked you to create a new table, after you'd built the original db - this is a simple 'capabilities' table, with just two columns: EMPLOYEE ID, SKILL. With this table, they hope to have, in a single place, what each employee (staff, surgeons... everyone) can do, eg. throw a party, file taxes, administer injections, extract teeth, talk to the press... [each employee would pick from a giant list of tasks, one or more of the items - this is to prevent variations and typos].
Write a query that will pick out only the employees who can do every task in a table such as the one below:
File taxes
Meet the press
Organize spring cleaning
Do teeth cleaning
Reorder inventory

Answer :

Assumption:
Capabilities table will have all the skills that an employee of the dental procedure can have. Employee table will have employee details. Task sheet table will have necessary skills needed by the owners.

The query will output the employee_id and corresponding skill_name that they possess.

select abc.employee_id, def.skill_name
from (
         select employee_id, count(ES.skill_id)
         from employee_skills ES
                  inner join capabilities S on ES.skill_id = S.skill_id
         where S.skill_name IN
               (select * from task_sheet)
         Group by employee_id
         having count(ES.skill_id) >= (select count(skill_name) from task_sheet)) abc
         cross JOIN
     (select skill_name
      from capabilities
      where skill_name IN
            (select * from task_sheet)) def
Order by employee_id;

scenario2:The query will output emp_id of those employees who have all the skills in the task sheet.

select employee_id
from (
         select employee_id, count(ES.skill_id)
         from employee_skills ES
                  inner join capabilities S on ES.skill_id = S.skill_id
         where S.skill_name IN
               (select * from task_sheet)
         Group by employee_id
         having count(ES.skill_id) >= (select count(skill_name) from task_sheet)
     );

scenario3: The query will output employee names of those employees who have all the skills in the task sheet.

select employee_name
from (
         select employee_name, count(ES.skill_id)
         from employee_skills ES
                  inner join employee E on ES.employee_id = E.employee_id
                  inner join capabilities S on ES.skill_id = S.skill_id
         where S.skill_name IN
               (select * from task_sheet)
         Group by employee_name
         having count(ES.skill_id) >= (select count(skill_name) from task_sheet)
     );



Question4:
The administration has decided to give bonus to the top 3 employees who have worked on more appointments during this COVID time. So, Write a query to get the top 3 performers that will pick out only 3 employees in order who have taken maximum number of appointments.
Answer :

Assumption:
Appointment table will have all the appointment details including patient and corresponding doctor’s details who has taken the appointment. The query will output emp_id and name of those top 3 performing employees.

SELECT AP.employee_id, EM.employee_name
FROM ((SELECT employee_id,
              COUNT(employee_id) as "top_performer"
       FROM appointment
       GROUP BY employee_id
       ORDER BY "top_performer" DESC) AP
         inner join employee EM on AP.employee_id = EM.employee_id)
WHERE ROWNUM <= 3;



Table creation Queries:

CREATE TABLE Procedure
(
    Procedure_Id   Varchar(20) NOT NULL,
    Procedure_Name Varchar(20),
    PRIMARY KEY (Procedure_Id)
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

CREATE TABLE Provider
(
    Provider_Id   Varchar(20) NOT NULL,
    Provider_Name Varchar(60),
    PRIMARY KEY (Provider_Id)
);

CREATE TABLE Billing_Record
(
    Billing_ID          VARCHAR(20),
    Patient_ID          VARCHAR(20),
    Provider_ID         VARCHAR(20),
    Appointment_ID      VARCHAR(20),
    Procedure_ID        VARCHAR(20),
    Total_Billed_Amount INTEGER,
    Total_Owed_Amount   INTEGER,
    Patient_Payment     INTEGER,
    Insurance_Payment   INTEGER,
    Date_Billed         DATE,
    PRIMARY KEY (Billing_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES APPOINTMENT (Appointment_ID),
    FOREIGN KEY (PROCEDURE_ID) REFERENCES PROCEDURE (PROCEDURE_ID),
    FOREIGN KEY (PROvider_ID) REFERENCES PROVIDER (PROVIDER_ID)
);

CREATE TABLE capabilities
(
    skill_Id   Varchar(20) NOT NULL,
    skill_Name Varchar(60),
    PRIMARY KEY (skill_Id)
);

create table employee_skills
(
    employee_id varchar(20),
    skill_id    varchar(20),
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE (employee_id),
    FOREIGN KEY (skill_id) REFERENCES capabilities (skill_id)
);


CREATE TABLE TASK_SHEET
(
    SKILL_NAME VARCHAR(60),
    PRIMARY KEY (SKILL_NAME)
);


Insert records Queries:

insert into Procedure (Procedure_Id, Procedure_Name)
select 'proc1', 'Braces'
from dual
union all
select 'proc2', 'General Consultation'
from dual
union all
select 'proc3', 'Root Canals'
from dual
union all
select 'proc4', 'Gum Surgery'
from dual
union all
select 'proc5', 'Teeth Whitening'
from dual
union all
select 'proc6', 'Fillngs and Repairs'
from dual
union all
select 'proc7', 'Extractions'
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

insert into Provider (Provider_Id, Provider_Name)
select 'prov1', 'United Healthcare'
from dual
union all
select 'prov2', 'MetLife'
from dual
union all
select 'prov3', 'Guardian Life Insurance'
from dual
union all
select 'prov4', 'Best California'
from dual
union all
select 'prov5', 'Blue Cross'
from dual;

insert into billing_record (Billing_ID, Patient_ID, Provider_ID, Appointment_ID, Procedure_ID, Total_Billed_Amount,
                            Total_Owed_Amount, Patient_Payment, Insurance_Payment, Date_Billed)
select '501',
       'pat11',
       'prov3',
       '#id11',
       'proc5',
       1091,
       79,
       271,
       741,
       date'2021-01-13'
from dual
union all
select '502',
       'pat12',
       'prov3',
       '#id12',
       'proc1',
       1223,
       91,
       298,
       834,
       date'2021-01-14'
from dual
union all
select '503',
       'pat13',
       'prov4',
       '#id13',
       'proc2',
       1211,
       92,
       397,
       722,
       date'2021-01-15'
from dual
union all
select '504',
       'pat10',
       'prov4',
       '#id13',
       'proc2',
       1059,
       100,
       359,
       600,
       date'2021-01-15'
from dual
union all
select '505',
       'pat13',
       'prov4',
       '#id13',
       'proc2',
       1758,
       935,
       323,
       500,
       date'2021-01-15'
from dual
union all
select '506',
       'pat14',
       'prov2',
       '#id14',
       'proc2',
       192,
       4,
       54,
       134,
       date'2021-01-16'
from dual
union all
select '507',
       'pat15',
       'prov2',
       '#id15',
       'proc2',
       959,
       7,
       313,
       639,
       date'2021-01-17'
from dual
union all
select '508',
       'pat16',
       'prov4',
       '#id16',
       'proc4',
       242,
       64,
       10,
       168,
       date'2021-01-18'
from dual
union all
select '509',
       'pat17',
       'prov1',
       '#id17',
       'proc2',
       869,
       26,
       104,
       739,
       date'2021-01-19'
from dual
union all
select '510',
       'pat18',
       'prov5',
       '#id18',
       'proc3',
       493,
       25,
       345,
       123,
       date'2021-01-20'
from dual
union all
select '511',
       'pat10',
       'prov5',
       '#id18',
       'proc6',
       900,
       45,
       700,
       155,
       date'2021-01-20'
from dual
union all
select '512',
       'pat16',
       'prov5',
       '#id18',
       'proc6',
       783,
       33,
       650,
       100,
       date'2021-01-20'
from dual
union all
select '513',
       'pat17',
       'prov5',
       '#id18',
       'proc3',
       532,
       12,
       497,
       23,
       date'2021-01-20'
from dual
union all
select '514',
       'pat19',
       'prov5',
       '#id18',
       'proc6',
       386,
       100,
       230,
       56,
       date'2021-01-20'
from dual
union all
select '515',
       'pat18',
       'prov5',
       '#id18',
       'proc3',
       584,
       20,
       3,
       613,
       date'2021-01-21'
from dual
union all
select '516',
       'pat18',
       'prov5',
       '#id18',
       'proc2',
       1211,
       92,
       397,
       722,
       date'2021-01-11'
from dual
union all
select '517',
       'pat20',
       'prov2',
       '#id20',
       'proc4',
       636,
       69,
       13,
       464,
       date'2021-01-22'
from dual
union all
select '518',
       'pat21',
       'prov4',
       '#id21',
       'proc4',
       546,
       17,
       68,
       524,
       date'2021-01-23'
from dual
union all
select '519',
       'pat22',
       'prov5',
       '#id22',
       'proc1',
       609,
       6,
       404,
       393,
       date'2021-01-24'
from dual
union all
select '520',
       'pat20',
       'prov5',
       '#id22',
       'proc1',
       803,
       60,
       156,
       25,
       date'2021-01-24'
from dual
union all
select '521',
       'pat12',
       'prov5',
       '#id22',
       'proc1',
       241,
       25,
       410,
       200,
       date'2021-01-24'
from dual
union all
select '522',
       'pat13',
       'prov5',
       '#id22',
       'proc1',
       635,
       30,
       300,
       325,
       date'2021-01-24'
from dual
union all
select '523',
       'pat14',
       'prov3',
       '#id23',
       'proc5',
       635,
       26,
       467,
       618,
       date'2021-01-25'
from dual
union all
select '524',
       'pat23',
       'prov1',
       '#id24',
       'proc4',
       1111,
       14,
       485,
       810,
       date'2021-01-26'
from dual
union all
select '525',
       'pat24',
       'prov2',
       '#id25',
       'proc5',
       1309,
       73,
       20,
       397,
       date'2021-01-27'
from dual
union all
select '526',
       'pat26',
       'prov5',
       '#id26',
       'proc2',
       490,
       29,
       83,
       620,
       date'2021-01-28'
from dual
union all
select '527',
       'pat27',
       'prov2',
       '#id27',
       'proc6',
       732,
       76,
       119,
       266,
       date'2021-01-29'
from dual
union all
select '528',
       'pat28',
       'prov1',
       '#id28',
       'proc1',
       421,
       37,
       362,
       22,
       date'2021-01-30'
from dual
union all
select '529',
       'pat29',
       'prov1',
       '#id29',
       'proc1',
       814,
       90,
       206,
       518,
       date'2021-01-31'
from dual;

insert into capabilities (skill_id, skill_name)
select 'skill1', 'File taxes'
from dual
union all
select 'skill2', 'Meet the press'
from dual
union all
select 'skill3', 'Organize spring cleaning'
from dual
union all
select 'skill4', 'Do teeth cleaning'
from dual
union all
select 'skill5', 'Reorder inventory'
from dual
union all
select 'skill6', 'Administer anesthetics'
from dual
union all
select 'skill7', 'Prescribe antibiotics'
from dual
union all
select 'skill8', 'Examine x rays of gums'
from dual
union all
select 'skill9', 'Teach patients flossing'
from dual
union all
select 'skill10', 'Take care of accounts'
from dual
union all
select 'skill11', 'Organize and manage events'
from dual
union all
select 'skill12', 'Supervise doctor schedule'
from dual;

insert into employee_skills
    (employee_id, skill_id)
select 'EMP01', 'skill1'
from dual
union all
select 'EMP01', 'skill3'
from dual
union all
select 'EMP02', 'skill2'
from dual
union all
select 'EMP02', 'skill3'
from dual
union all
select 'EMP03', 'skill2'
from dual
union all
select 'EMP03', 'skill3'
from dual
union all
select 'EMP04', 'skill1'
from dual
union all
select 'EMP04', 'skill2'
from dual
union all
select 'EMP04', 'skill3'
from dual
union all
select 'EMP04', 'skill4'
from dual
union all
select 'EMP04', 'skill5'
from dual
union all
select 'EMP05', 'skill4'
from dual
union all
select 'EMP05', 'skill5'
from dual
union all
select 'EMP06', 'skill4'
from dual
union all
select 'EMP06', 'skill6'
from dual
union all
select 'EMP07', 'skill4'
from dual
union all
select 'EMP07', 'skill7'
from dual
union all
select 'EMP08', 'skill4'
from dual
union all
select 'EMP08', 'skill8'
from dual
union all
select 'EMP09', 'skill4'
from dual
union all
select 'EMP09', 'skill9'
from dual
union all
select 'EMP10', 'skill1'
from dual
union all
select 'EMP10', 'skill10'
from dual
union all
select 'EMP10', 'skill2'
from dual
union all
select 'EMP10', 'skill3'
from dual
union all
select 'EMP10', 'skill4'
from dual
union all
select 'EMP10', 'skill5'
from dual
union all
select 'EMP11', 'skill11'
from dual
union all
select 'EMP11', 'skill5'
from dual
union all
select 'EMP12', 'skill12'
from dual
union all
select 'EMP12', 'skill6'
from dual
union all
select 'EMP13', 'skill1'
from dual
union all
select 'EMP13', 'skill7'
from dual
union all
select 'EMP14', 'skill1'
from dual
union all
select 'EMP14', 'skill8'
from dual
union all
select 'EMP15', 'skill1'
from dual
union all
select 'EMP15', 'skill9'
from dual
union all
select 'EMP16', 'skill1'
from dual
union all
select 'EMP16', 'skill10'
from dual
union all
select 'EMP17', 'skill11'
from dual
union all
select 'EMP17', 'skill2'
from dual
union all
select 'EMP18', 'skill12'
from dual
union all
select 'EMP18', 'skill2'
from dual
union all
select 'EMP19', 'skill2'
from dual
union all
select 'EMP19', 'skill6'
from dual
union all
select 'EMP20', 'skill1'
from dual
union all
select 'EMP20', 'skill2'
from dual
union all
select 'EMP20', 'skill3'
from dual
union all
select 'EMP20', 'skill4'
from dual
union all
select 'EMP20', 'skill5'
from dual
union all
select 'EMP20', 'skill6'
from dual
union all
select 'EMP21', 'skill3'
from dual
union all
select 'EMP21', 'skill6'
from dual;



insert into TASK_SHEET (SKILL_NAME)
select 'File taxes'
from dual
union all
select 'Meet the press'
from dual
union all
select 'Organize spring cleaning'
from dual
union all
select 'Do teeth cleaning'
from dual
union all
select 'Reorder inventory'
from dual;












