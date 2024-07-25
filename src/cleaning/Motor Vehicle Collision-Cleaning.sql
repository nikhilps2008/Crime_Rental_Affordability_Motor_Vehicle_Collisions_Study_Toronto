select *
from motor_vehicle_collisions;

-- Remove Duplicates
-- Standardize the data
-- Remove Null Values or Blank Values
-- Remove any Unwanted Columns
-- Creating a new table for the staging process

create table MVC
like motor_vehicle_collisions;

insert mvc
select *
from motor_vehicle_collisions;

select *
from mvc;

Select * , row_number() over(partition by DATE,TIME,STREET1,STREET2,DISTRICT,HOOD_158,DIVISION) as row_num
from mvc; 

With duplicate_cte as(Select * , row_number() over(partition by _id,DATE,TIME,STREET1,STREET2,DISTRICT,HOOD_158,DIVISION) as row_num
from mvc)
select *
from duplicate_cte;

CREATE TABLE `mvc2` (
  `_id` int DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `TIME` text,
  `STREET1` text,
  `STREET2` text,
  `OFFSET` text,
  `ROAD_CLASS` text,
  `DISTRICT` text,
  `ACCLOC` text,
  `TRAFFCTL` text,
  `VISIBILITY` text,
  `LIGHT` text,
  `RDSFCOND` text,
  `ACCLASS` text,
  `IMPACTYPE` text,
  `INVTYPE` text,
  `INVAGE` text,
  `INJURY` text,
  `FATAL_NO` text,
  `INITDIR` text,
  `VEHTYPE` text,
  `MANOEUVER` text,
  `DRIVACT` text,
  `DRIVCOND` text,
  `PEDTYPE` text,
  `PEDACT` text,
  `PEDCOND` text,
  `CYCLISTYPE` text,
  `CYCACT` text,
  `CYCCOND` text,
  `PEDESTRIAN` text,
  `CYCLIST` text,
  `AUTOMOBILE` text,
  `MOTORCYCLE` text,
  `TRUCK` text,
  `TRSN_CITY_VEH` text,
  `EMERG_VEH` text,
  `PASSENGER` text,
  `SPEEDING` text,
  `AG_DRIV` text,
  `REDLIGHT` text,
  `ALCOHOL` text,
  `DISABILITY` text,
  `HOOD_158` int DEFAULT NULL,
  `NEIGHBOURHOOD_158` text,
  `HOOD_140` int DEFAULT NULL,
  `NEIGHBOURHOOD_140` text,
  `DIVISION` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from mvc2;

insert into mvc2
Select * , row_number() over(partition by DATE,TIME,STREET1,STREET2,DISTRICT,HOOD_158,DIVISION) as row_num
from mvc; 

select *
from mvc2;

select *
from mvc2
where date < '2019-01-01';

Delete 
from mvc2
where date < '2019-01-01';

select *
from mvc2;

-- Standardizing Data

select trim(neighbourhood_158)
from mvc2;

update mvc2
set neighbourhood_158 = trim(neighbourhood_158);

SELECT 
    time,
    CASE 
        when length(time) = 2 then concat('00:',SUBSTRING(time, 1, 2),':00')
        WHEN LENGTH(time) = 3 THEN CONCAT('0', SUBSTRING(time, 1, 1), ':', SUBSTRING(time, 2, 2), ':00')
        WHEN LENGTH(time) = 4 THEN CONCAT(SUBSTRING(time, 1, 2), ':', SUBSTRING(time, 3, 2), ':00')
    END AS New_time
FROM mvc2;


UPDATE mvc2
SET time = CASE 
        when length(time) = 2 then concat('00:',SUBSTRING(time, 1, 2),':00')
        WHEN LENGTH(time) = 3 THEN CONCAT('0', SUBSTRING(time, 1, 1), ':', SUBSTRING(time, 2, 2), ':00')
        WHEN LENGTH(time) = 4 THEN CONCAT(SUBSTRING(time, 1, 2), ':', SUBSTRING(time, 3, 2), ':00')
    END;
    
alter table mvc2
modify column TIME time;

select *
from mvc2;

-- Removing Null and Blank Values

Select *
from mvc2
where DATE is null;

-- Removing Unwanted Columns
alter table mvc2
drop column _id,
drop column OFFSET,
drop column ACCLOC,
drop column INITDIR,
drop  column VEHTYPE,
drop column MANOEUVER,
drop column DRIVACT,
drop column DRIVCOND,
drop column PEDTYPE,
drop column PEDACT,
drop column PEDCOND,
drop column CYCLISTYPE,
drop column CYCACT,
drop column CYCCOND,
drop column PEDESTRIAN,
drop column CYCLIST,
drop column AUTOMOBILE,
drop column MOTORCYCLE,
drop column TRUCK,
drop column TRSN_CITY_VEH,
drop column EMERG_VEH,
drop column PASSENGER,
drop column REDLIGHT,
drop column DISABILITY,
drop column HOOD_140,
drop column NEIGHBOURHOOD_140,
drop column TRAFFCTL,
drop column IMPACTYPE;

select *
from mvc2;
