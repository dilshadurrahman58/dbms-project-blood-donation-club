--CSE-3110 Mini-Project
--Md. Dilshadur Rahman
--Roll:1207058
--Date of Submission: 25/08/15

--drop table
drop table donate;
drop table assist_by;
drop table donor;
drop table patient;
drop table volunteer;

--create table donor
create table donor
(
      donor_id integer,
      donor_name varchar(20) not null,
      donor_bloodgroup varchar(5) check(donor_bloodgroup in('A+','B+','AB+','O+','A-','B-','AB-','O-')) not null,
      donor_age varchar(5),
      donor_address varchar(20),
      donor_sex varchar(10),
      primary key(donor_id)
);


--create table patient
create table patient
(
      patient_id integer,
	  patient_name varchar(20) not null,
	  patient_bloodgroup varchar(5) check(patient_bloodgroup in('A+','B+','AB+','O+','A-','B-','AB-','O-')) not null,
	  patient_age varchar(5),
	  patient_address varchar(20),
	  patient_sex varchar(10),
	  primary key(patient_id)
);


--create table volunteer
create table volunteer
(
      volunteer_id integer,
      volunteer_name varchar(20) not null,
      volunteer_address varchar(20),
      volunteer_age varchar(10) not null,
      primary key(volunteer_id)
);


--create table assist_by
create table assist_by
(     
	  patient_id integer,
      volunteer_id integer,
      primary key(patient_id),
      foreign key(patient_id) references patient(patient_id) on delete cascade,
      foreign key(volunteer_id) references volunteer(volunteer_id) on delete cascade
);



--create table donate
create table donate
(
      donor_id integer,
	  patient_id integer,
	  date_of_donation DATE,
	  quantity varchar(7),
	  primary key(donor_id,patient_id),
	  foreign key(donor_id) references donor(donor_id) on delete cascade,
	  foreign key(patient_id) references patient(patient_id) on delete cascade
);


--Alter table implementation**************************************************************************************************************************

ALTER TABLE donor 
add donor_record varchar(20);

ALTER TABLE donor
drop column donor_record;

ALTER TABLE donate
modify quantity varchar(10);

ALTER TABLE donate
modify quantity varchar(7);

ALTER TABLE volunteer
rename column volunteer_name to volunteer_n;

ALTER TABLE volunteer
rename column volunteer_n to volunteer_name;


--describe all tables
describe donor;
describe patient;
describe volunteer;
describe assist_by;
describe donate;



--Implementation of trigger*******************************************************************************************************************************
--this PL/SQL trigger part checks if the age of the donor is less than 15 or greater than 100

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER check_age_donor BEFORE INSERT OR UPDATE ON donor
FOR EACH ROW
DECLARE 
	donor_minimum_age CONSTANT integer := 15;
	donor_maximum_age CONSTANT integer := 100;
BEGIN 
	IF :NEW.donor_age<donor_minimum_age THEN 
		RAISE_APPLICATION_ERROR(-20000,'AGE BEING LOWER THAN 15 IS INVALID');
	ELSIF :NEW.donor_age>donor_maximum_age THEN 
		RAISE_APPLICATION_ERROR(-20000,'AGE MORE THAN 100 IS NOT ALLOWED');
	END IF;
END check_age_donor;
/

--insert values in donor table
insert into donor values (1,'Dolon','A+','20','BSMR Hall','Male');
insert into donor values (2,'Saif','B+','21','Rashid Hall','Male');
insert into donor values (3,'Prome','A+','23','Rokeya Hall','Female');
insert into donor values (4,'Rejuan','A-','25','BSMR Hall','Male');
insert into donor values (5,'Hanif','AB-','22','AEH Hall','Male');
insert into donor values (6,'Raihan','AB+','19','KHAJA Hall','Male');
insert into donor values (7,'Habib','A-','20','Lalon Shah Hall','Male');
insert into donor values (8,'Hanif','O-','21','Rokeya Hall','Female');
insert into donor values (9,'Keya','O+','25','Rokeya Hall','Female');
insert into donor values (10,'Rehenuma','AB-','22','Rokeya Hall','Female');
insert into donor values (11,'Ohona','O+','21','Rokeya Hall','Female');
insert into donor values (12,'Jui','AB+','24','Rokeya Hall','Female');



--insert values in patient table
insert into patient values (1,'Ashik','A+','22','BSMR Hall','Male');
insert into patient values (2,'Rifat','AB+','25','AEH Hall','Male');
insert into patient values (3,'Aney','O+','23','Rokeya Hall','Female');
insert into patient values (4,'Snigdha','O-','21','Rokeya Hall','Female');
insert into patient values (5,'Nigar','O+','25','Rokeya Hall','Female');
insert into patient values (6,'Otoshi','AB-','21','Rokeya Hall','Female');
insert into patient values (7,'Maya','O+','21','Rokeya Hall','Female');
insert into patient values (8,'Rejaul','A+','23','KHAJA Hall','Male');
insert into patient values (9,'Reza','B+','21','Rashid Hall','Male');
insert into patient values (10,'Smrity','O+','22','Rokeya Hall','Female');
insert into patient values (11,'Mim','A+','20','FH Hall','Male');
insert into patient values (12,'Rahat','B+','24','AEH Hall','Male');
insert into patient values (13,'Disha','O+','24','Rokeya Hall','Female');
insert into patient values (14,'Rahi','AB+','21','FH Hall','Male');




--insert values in volunteer table
insert into volunteer values (1,'Saju','Lalon Shah Hall','23');
insert into volunteer values (2,'Nasim','AEH Hall','20');
insert into volunteer values (3,'Fuad','FH Hall','21');
insert into volunteer values (4,'Mithun','Lalon Shah Hall','24');
insert into volunteer values (5,'Tara','Rokeya Hall','23');
insert into volunteer values (6,'Rubina','Rokeya Hall','20');
insert into volunteer values (7,'Lipi','Rokeya Hall','21');
insert into volunteer values (8,'Akhi','Rokeya Hall','22');
insert into volunteer values (9,'Mohona','Rokeya Hall','25');
insert into volunteer values (10,'Japan','BSMR Hall','23');
insert into volunteer values (11,'Shin','Rashid Hall','20');
insert into volunteer values (12,'Joni','BSMR Hall','22');
insert into volunteer values (13,'Hasan','FH Hall','21');
insert into volunteer values (14,'Abid','Rashid Hall','23');



--insert values in assist_by table
insert into assist_by values (1,5);
insert into assist_by values (2,2);
insert into assist_by values (3,2);
insert into assist_by values (4,2);
insert into assist_by values (5,5);
insert into assist_by values (6,6);
insert into assist_by values (7,7);
insert into assist_by values (8,8);
insert into assist_by values (9,9);
insert into assist_by values (10,10);
insert into assist_by values (11,11);
insert into assist_by values (12,12);


--insert values in donate table
insert into donate values (1,1,'22-JUN-2013','1 bag');
insert into donate values (2,2,'23-JUL-2014','2 bag');
insert into donate values (3,3,'21-APR-2015','1 bag');
insert into donate values (4,4,'15-JAN-2013','1 bag');
insert into donate values (5,5,'01-FEB-2015','2 bag');
insert into donate values (6,6,'26-APR-2014','1 bag');
insert into donate values (7,7,'03-MAR-2010','1 bag');
insert into donate values (8,8,'17-MAY-2011','2 bag');
insert into donate values (9,9,'21-SEP-2012','1 bag');
insert into donate values (10,10,'27-OCT-2013','1 bag');
insert into donate values (11,11,'10-NOV-2015','2 bag');
insert into donate values (12,12,'25-APR-2014','1 bag');



--select all

select * from donor;
select * from patient;
select * from volunteer;
select * from assist_by;
select * from donate;

--Simple query

select donor_id,donor_bloodgroup,donor_name from donor WHERE donor_name='Dolon';
UPDATE donor SET donor_name='Pagla',donor_address='FH Hall' WHERE donor_name='Saif';
SELECT * from donor;

UPDATE donor SET donor_name='Saif',donor_address='BSMR Hall' WHERE donor_id=2;
SELECT * from donor;

--**********************************************************************************************************************************************************

--lab 4 implementation
SELECT donor_id,donor_name,donor_address,donor_bloodgroup from donor;
SELECT volunteer_id,volunteer_name,volunteer_address from volunteer;
SELECT patient_id,patient_name,patient_address,patient_bloodgroup from patient;

--use of distinct keyword
SELECT distinct (donor_name) from donor;

--use of less than/greater than keyword
SELECT volunteer_name from volunteer where volunteer_id<6;
SELECT donor_name,donor_bloodgroup from donor where donor_id>6;

--use of and/or keyword
SELECT donor_name,donor_address,donor_age,donor_bloodgroup from donor
where donor_bloodgroup='A+' or donor_bloodgroup='B+';

SELECT patient_name,patient_age from patient
where patient_bloodgroup='A+' and (patient_address='KHAJA Hall' or patient_address='BSMR Hall');

--use of range search condition

--between keyword
SELECT donor_name,donor_address,donor_bloodgroup from donor where donor_id between 1 and 6;

--not between keyword

SELECT volunteer_name,volunteer_address,volunteer_age from volunteer 
where volunteer_id not between 1 and 6;

--greater/less than and equal
SELECT patient_name,patient_address,patient_bloodgroup,patient_age,patient_sex from patient 
where patient_id>=6 and patient_id<=10;

--set membership
--in keyword
SELECT donor_name,donor_address,donor_bloodgroup,donor_age from donor
where donor_id in(1,3,5,7);

--not in keyword
SELECT patient_id,patient_name,patient_address,patient_age from patient 
where patient_bloodgroup not in('A+','B+','O+');


--like/not like
--like
SELECT * from donor WHERE donor_name LIKE '%n';
SELECT * from volunteer WHERE volunteer_name LIKE 'G%';

--not like
SELECT * from volunteer WHERE volunteer_name NOT LIKE 'G%';
SELECT * from volunteer WHERE volunteer_name NOT LIKE '%ha%';

--order by
SELECT * from patient order by patient_name;
SELECT donor_id,donor_address,donor_bloodgroup from donor order by donor_bloodgroup;
SELECT donor_id,donor_address,donor_bloodgroup from donor order by donor_bloodgroup desc;
SELECT volunteer_name,volunteer_address from volunteer
order by volunteer_name,volunteer_id;

--MAX keyword
SELECT MAX(donor_age) from donor;
SELECT MAX(volunteer_age) from volunteer;
SELECT MAX(patient_age) from patient;

--MIN keyword
SELECT MIN(donor_age) from donor;
SELECT MIN(volunteer_age) from volunteer;
SELECT MIN(patient_age) from patient;

--COUNT,AVG and NVL keyword
SELECT count(*),count(volunteer_age) from volunteer;
SELECT count(*),count(patient_name),AVG(patient_age) from patient;
SELECT count(*),count(donor_id),AVG(NVL(donor_age,0)) from donor;
SELECT count(distinct donor_bloodgroup) from donor;
SELECT count(all donor_bloodgroup) from donor;

--SUM keyword
SELECT SUM(volunteer_age) from volunteer;
SELECT SUM(patient_age) from patient;
SELECT SUM(donor_age) from donor;

--group by and HAVING clause
SELECT donor_bloodgroup,SUM(donor_age) from donor
WHERE donor_id<6 group by donor_bloodgroup;

SELECT volunteer_address,SUM(volunteer_age) from volunteer
group by volunteer_address;

SELECT volunteer_address,SUM(volunteer_age) from volunteer
group by volunteer_address 
HAVING volunteer_address in('Rokeya Hall','FH Hall','BSMR Hall');

SELECT patient_bloodgroup,SUM(patient_age) from patient group by patient_bloodgroup
HAVING patient_bloodgroup NOT IN('A+','B+','AB+');

--******************************************************************************************************************************************************

--implementing LAB 5 : SUBQUERY and SET operations
SELECT donor_name,donor_address,donor_age from donor WHERE donor_name 
IN(SELECT donor_name from donor where donor_bloodgroup IN('A+','B+','O+'));

SELECT v.volunteer_name,v.volunteer_age,a.volunteer_id
from volunteer v,assist_by a 
where v.volunteer_id=a.volunteer_id;

SELECT volunteer_name,volunteer_address,volunteer_age from volunteer where volunteer_id=
(SELECT volunteer_id from assist_by  where patient_id=2);

SELECT patient_name,patient_address,patient_bloodgroup from patient where patient_id 
IN(SELECT patient_id from assist_by where volunteer_id=2);

SELECT patient_name,patient_address,patient_bloodgroup from patient where patient_id
IN(SELECT patient_id from donate where quantity='2 bag');

--*********************************************************************************************************************************************************
--lab 6 implementation
--join operation
SELECT assist_by.patient_id,volunteer.volunteer_name,assist_by.volunteer_id
from volunteer JOIN assist_by on volunteer.volunteer_id=assist_by.volunteer_id; 

SELECT volunteer_id,assist_by.patient_id,volunteer.volunteer_name
from volunteer NATURAL JOIN assist_by; --this query gives the same result

--SELECT volunteer_name,patient_name from volunteer CROSS JOIN patient; --cross join

--join operations

--inner join
SELECT a.patient_id,v.volunteer_name,a.volunteer_id
from volunteer v INNER JOIN assist_by a on v.volunteer_id=a.volunteer_id; 

--left outer join
SELECT volunteer.volunteer_name,volunteer.volunteer_address,assist_by.volunteer_id,assist_by.patient_id
from volunteer LEFT OUTER JOIN assist_by 
on volunteer.volunteer_id=assist_by.volunteer_id;

--right outer join
SELECT assist_by.volunteer_id,assist_by.patient_id,volunteer.volunteer_name,volunteer.volunteer_address
from assist_by RIGHT OUTER JOIN volunteer 
on assist_by.volunteer_id=volunteer.volunteer_id;

--full outer join
SELECT assist_by.volunteer_id,assist_by.patient_id,volunteer.volunteer_name,volunteer.volunteer_address
from assist_by FULL OUTER JOIN volunteer 
on assist_by.volunteer_id=volunteer.volunteer_id;


--*******************************************************************************************************************************************************
--LAB 7 and 8
--Implementation of PL/SQL

--this query finds the maximum donor_age from donor table
SET SERVEROUTPUT ON 
DECLARE
max_age_donor donor.donor_age%type;
BEGIN
SELECT MAX(donor_age) into max_age_donor
FROM donor;
DBMS_OUTPUT.PUT_LINE('The maximum age of donor is : '||
max_age_donor);
END;
/

--this query finds the average of the ages of the patient table
SET SERVEROUTPUT ON
DECLARE
average_age_patient integer;
BEGIN
SELECT AVG(patient_age) into average_age_patient
FROM patient;
DBMS_OUTPUT.PUT_LINE('The average of the ages of the donor_age is: '||
average_age_patient);
END;
/

--this query finds the distinct volunteer_address from the volunteer table
SET SERVEROUTPUT ON
DECLARE
	dif_address number;
BEGIN
	SELECT COUNT(distinct volunteer_address) into dif_address from volunteer;
	DBMS_OUTPUT.PUT_LINE('The number of different volunteer address is: ' 
		|| dif_address);
END;
/

--**************************************************************************************************************************************************

--PL/SQL update using procedure 
SELECT * from donor;
create OR replace procedure upd_donor (
	d_name donor.donor_name%type,
	d_address donor.donor_address%type) is
BEGIN
	UPDATE donor SET donor_address=d_address WHERE donor_name=d_name;
	if sql%notfound then
		raise_application_error(-20202, 'no donor updated');
	end if;
	COMMIT;
end upd_donor;
/
show errors

BEGIN
	upd_donor('Rejuan', 'FH Hall');
END;
/

SELECT * from donor;

SELECT * from patient;


--use of PL/SQL delete usnig procedure
create or replace procedure del_patient (
	p_id patient.patient_id%type) is
begin
	DELETE from patient where patient_id=p_id;
	if sql%notfound then
		raise_application_error(-20203, 'no patient deleted');
	end if;
	COMMIT;
end del_patient;
/
show errors

BEGIN
	del_patient(14);
END;
/

SELECT * from patient;



--use of PL/SQL insert using procedure

SELECT * from patient;

create OR replace procedure insert_patient (
	p_id patient.patient_id%type,
	p_name patient.patient_name%type,
	p_bloodgroup patient.patient_bloodgroup%type,
	p_age patient.patient_age%type,
	p_address patient.patient_address%type,
	p_sex patient.patient_sex%type

	) IS
BEGIN
	INSERT  into patient VALUES
		(
			p_id, p_name, p_bloodgroup, p_age, p_address,p_sex
		);

	if sql%notfound then
		raise_application_error(-20000, 'no patient inserted');
	end if;
	COMMIT;
end insert_patient;
/
show errors

begin 
	insert_patient(15, 'Riya','O-',20,'Rokeya Hall','Female');
end;
/

SELECT * from patient;

--****************************************************************************************************************************************************

--use of PL/SQL function

--this function takes a volunteer_id as parameter and
--returns the name of the corresponding volunteer
SET SERVEROUTPUT ON
create OR replace function get_volunteer_name (
v_id volunteer.volunteer_id%type) return varchar is
name volunteer.volunteer_name%type;
BEGIN
	SELECT volunteer_name into name from volunteer WHERE volunteer_id=v_id;
	if sql%notfound then
		DBMS_OUTPUT.PUT_LINE('no such volunteer found in the system');
	end if;
	COMMIT;
	return name;
END;
/
show errors
BEGIN
	DBMS_OUTPUT.PUT_LINE('Volunteer Name is ' || get_volunteer_name(10));
END;
/

--this fuction takes donor_id as parameter and returns the quantity of corresponding donation

CREATE OR REPLACE FUNCTION get_quantity(d_id donate.donor_id%type) 
RETURN varchar IS 
	quan donate.quantity%type;
BEGIN
	SELECT quantity INTO quan FROM donate WHERE donor_id=d_id;
	RETURN quan;
END;
/

DECLARE
	id integer;
BEGIN
	id:=1; 
	DBMS_OUTPUT.PUT_LINE('Quantity of donation of '|| id || ' is ' || get_quantity(id));
END;
/

--use of PL/SQL function without parameter

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION volunteer_avg_age RETURN integer IS
   average volunteer.volunteer_age%type;

BEGIN
  SELECT AVG(NVL(volunteer_age,0)) INTO average FROM volunteer;
  RETURN average;
END;
/

SET SERVEROUTPUT ON
BEGIN
DBMS_OUTPUT.PUT_LINE('Average volunteer age: ' || volunteer_avg_age);
END;
/

--**********************************************************************************************************************************************************
--use of CURSOR

--this PL/SQL part selects patient_id,patient_name,patient_address,patient_bloodgroup from all the rows of the patient table
--normal cursor

DECLARE
   p_id patient.patient_id%type;
   p_name patient.patient_name%type;
   p_addr patient.patient_address%type;
   p_bld patient.patient_bloodgroup%type;
   CURSOR p_patient is
      SELECT patient_id, patient_name, patient_address,patient_bloodgroup FROM patient;
BEGIN
   OPEN p_patient;
   LOOP
      FETCH p_patient into p_id, p_name, p_addr,p_bld;
      EXIT WHEN p_patient%notfound;
      DBMS_OUTPUT.PUT_LINE(p_id || '    ' || p_name || '    ' || p_addr|| '    ' || p_bld);
   END LOOP;
   CLOSE p_patient;
END;
/

--this PL/SQL part selects all from the donor table
DECLARE
   d_id donor.donor_id%type;
   d_name donor.donor_name%type;
   d_add donor.donor_address%type;
   d_age donor.donor_age%type; 
   d_bld donor.donor_bloodgroup%type;
   d_sex donor.donor_sex%type;
   CURSOR d_donor is
      SELECT donor_id, donor_name, donor_address,donor_age,donor_bloodgroup,donor_sex FROM donor;
BEGIN
   OPEN d_donor;
   LOOP
      FETCH d_donor into d_id,d_name,d_add,d_age,d_bld,d_sex;
      EXIT WHEN d_donor%notfound;
      DBMS_OUTPUT.PUT_LINE(d_id || '    ' || d_name || '    ' || d_add|| '    ' || d_age || '    '|| d_bld || '    ' 
      || d_sex);
   END LOOP;
   CLOSE d_donor;
END;
/

--this PL/SQL part selects donor_name,donor_bloodgroup from all the rows of donor table
--here i used cursor based records

SET SERVEROUTPUT ON;
DECLARE
  CURSOR dolon_cur IS SELECT donor_name, donor_bloodgroup FROM donor;
  donor_rec dolon_cur%ROWTYPE;

BEGIN
OPEN dolon_cur;
      LOOP
        FETCH dolon_cur INTO donor_rec;
        EXIT WHEN dolon_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE ('Donor Name : ' || donor_rec.donor_name || '  Blood Group:  ' || donor_rec.donor_bloodgroup);
      END LOOP;
      CLOSE dolon_cur;   
END;
/

--**********************************************************************************************************************************************************
--implementation of last lab
--use of COMMIT
COMMIT;

insert into volunteer values (16,'Roja','FH Hall','22');
savepoint volunteer1;
insert into volunteer values (17,'Eden','BSMR Hall','20');
savepoint volunteer2;

--use of ROLLBACK

SELECT * from volunteer;
delete from volunteer;
ROLLBACK to volunteer2;
SELECT * from volunteer;

--**********************************************************************************************************************************************************