BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employee CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE capabilities CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE employee_skills CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE TASK_SHEET CASCADE CONSTRAINTS';
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