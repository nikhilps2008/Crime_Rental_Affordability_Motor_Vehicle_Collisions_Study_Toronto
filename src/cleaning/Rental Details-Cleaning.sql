select *
from rental_details;

-- Removing Unwanted Columns
-- Remove Duplicates
-- Remove Null Values or Blank Values
-- Add Columns based on the needs

-- Creating a new table for staging process

create table rd
like rental_details;

insert rd
select *
from rental_details;

select *
from rd;

-- Checking Duplicates

select *,row_number() over(partition by Neighbourhood,Hood_ID) as row_num
from rd; 

with duplicate_cte as(select *,row_number() over(partition by Neighbourhood,Hood_ID) as row_num
from rd)
select *
from duplicate_cte
where row_num > 1;

-- No duplicates

-- Remove Unwanted Collumns

alter table rd
drop column Type1,
drop column Type2,
drop column Type3,
drop column Type32;

select *
from rd;

-- Removing Null values

Select *
from rd
where Neighbourhood is null or Hood_ID is null;

-- No null values

select *
from rd;