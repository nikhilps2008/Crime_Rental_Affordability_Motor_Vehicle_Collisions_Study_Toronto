select *
from rental_data_yearly;

-- Removing Unwanted Columns
-- Remove Duplicates
-- Remove Null Values or Blank Values
-- Add Columns based on the needs

-- Creating a new table for staging process

create table rdy
like rental_data_yearly;

insert rdy
select *
from rental_data_yearly;

Select *
from rdy;

-- Checking Duplicates

select *, row_number() over(partition by Year) as row_num
from rdy;

with duplicate_cte as(select *, row_number() over(partition by Year) as row_num
from rdy)
select  *
from duplicate_cte
where row_num>1;

-- There are no duplicate rows

-- Remove Unwanted Collumns

alter table rdy
drop column Type,
drop column Type2,
drop column Type3,
drop column Total,
drop column Type4,
drop column Type5;

Select *
from rdy;

-- Standardizing Data

SELECT year(Year) as Year_New
from rdy;

update rdy
set Year= year(Year);

select *
from rdy
where year <  2019;

delete 
from rdy
where Year < 2019;

select *
from rdy;

-- Adding new columns for different compaison and calculation requirements

alter table rdy
add column average_rent int;

alter table rdy
modify Year int; 

update rdy
set average_rent = (1_Bedroom+2_Bedroom+3_Bedroom)/3;

select *
from rdy;