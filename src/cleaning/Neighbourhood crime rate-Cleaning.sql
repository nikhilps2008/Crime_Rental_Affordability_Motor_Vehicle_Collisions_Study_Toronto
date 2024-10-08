select *
from neighbourhood_crime_rates;

-- Removing Unwanted Columns
-- Remove Duplicates
-- Remove Null Values or Blank Values
-- Add Columns based on the needs

-- Creating a new table for staging process

create table ncr
like neighbourhood_crime_rates;

insert ncr
select *
from neighbourhood_crime_rates;

select *
from ncr;

-- Checking Duplicates

select *, row_number() over(partition by area_name,hood_id) as row_num
from ncr;

with duplicate_cte as(select *, row_number() over(partition by area_name,hood_id) as row_num
from ncr)
select *
from duplicate_cte
where row_num>1;

-- No Duplicates

-- Remove Unwanted Collumns

alter table ncr
drop column OBJECTID_1,
drop column ASSAULT_2014,
drop column ASSAULT_2015,
drop column ASSAULT_2016,
drop column ASSAULT_2017,
drop column ASSAULT_2018,
drop column ASSAULT_RATE_2014,
drop column ASSAULT_RATE_2015,
drop column ASSAULT_RATE_2016,
drop column ASSAULT_RATE_2017,
drop column ASSAULT_RATE_2018,
drop column ASSAULT_RATE_2019,
drop column ASSAULT_RATE_2020,
drop column ASSAULT_RATE_2021,
drop column ASSAULT_RATE_2022,
drop column ASSAULT_RATE_2023,
drop column AUTOTHEFT_2014,
drop column AUTOTHEFT_2015,
drop column AUTOTHEFT_2016,
drop column AUTOTHEFT_2017,
drop column AUTOTHEFT_2018,
drop column AUTOTHEFT_RATE_2014,
drop column AUTOTHEFT_RATE_2015,
drop column AUTOTHEFT_RATE_2016,
drop column AUTOTHEFT_RATE_2017,
drop column AUTOTHEFT_RATE_2018,
drop column AUTOTHEFT_RATE_2019,
drop column AUTOTHEFT_RATE_2020,
drop column AUTOTHEFT_RATE_2021,
drop column AUTOTHEFT_RATE_2022,
drop column AUTOTHEFT_RATE_2023,
drop column BIKETHEFT_2014,
drop column BIKETHEFT_2015,
drop column BIKETHEFT_2016,
drop column BIKETHEFT_2017,
drop column BIKETHEFT_2018,
drop column BIKETHEFT_RATE_2014,
drop column BIKETHEFT_RATE_2016,
drop column BIKETHEFT_RATE_2017,
drop column BIKETHEFT_RATE_2018,
drop column BIKETHEFT_RATE_2019,
drop column BIKETHEFT_RATE_2020,
drop column BIKETHEFT_RATE_2021,
drop column BIKETHEFT_RATE_2022,
drop column BIKETHEFT_RATE_2023,
drop column BREAKENTER_2014,
drop column BREAKENTER_2015,
drop column BREAKENTER_2016,
drop column BREAKENTER_2017,
drop column BREAKENTER_2018,
drop column BREAKENTER_RATE_2014,
drop column BREAKENTER_RATE_2015,
drop column BREAKENTER_RATE_2016,
drop column BREAKENTER_RATE_2017,
drop column BREAKENTER_RATE_2018,
drop column BREAKENTER_RATE_2019,
drop column BREAKENTER_RATE_2020,
drop column BREAKENTER_RATE_2021,
drop column BREAKENTER_RATE_2022,
drop column BREAKENTER_RATE_2023,
drop column HOMICIDE_2014,
drop column HOMICIDE_2015,
drop column HOMICIDE_2016,
drop column HOMICIDE_2017,
drop column HOMICIDE_2018,
drop column HOMICIDE_RATE_2014,
drop column HOMICIDE_RATE_2015,
drop column HOMICIDE_RATE_2016,
drop column HOMICIDE_RATE_2017,
drop column HOMICIDE_RATE_2018,
drop column HOMICIDE_RATE_2019,
drop column HOMICIDE_RATE_2020,
drop column HOMICIDE_RATE_2021,
drop column HOMICIDE_RATE_2022,
drop column HOMICIDE_RATE_2023,
drop column ROBBERY_2014,
drop column ROBBERY_2015,
drop column ROBBERY_2016,
drop column ROBBERY_2017,
drop column ROBBERY_2018,
drop column ROBBERY_RATE_2014,
drop column ROBBERY_RATE_2015,
drop column ROBBERY_RATE_2016,
drop column ROBBERY_RATE_2017,
drop column ROBBERY_RATE_2018,
drop column ROBBERY_RATE_2019,
drop column ROBBERY_RATE_2020,
drop column ROBBERY_RATE_2021,
drop column ROBBERY_RATE_2022,
drop column ROBBERY_RATE_2023,
drop column SHOOTING_2014,
drop column SHOOTING_2015,
drop column SHOOTING_2016,
drop column SHOOTING_2017,
drop column SHOOTING_2018,
drop column SHOOTING_RATE_2014,
drop column SHOOTING_RATE_2015,
drop column SHOOTING_RATE_2016,
drop column SHOOTING_RATE_2017,
drop column SHOOTING_RATE_2018,
drop column SHOOTING_RATE_2019,
drop column SHOOTING_RATE_2020,
drop column SHOOTING_RATE_2021,
drop column SHOOTING_RATE_2022,
drop column SHOOTING_RATE_2023,
drop column THEFTFROMMV_2014,
drop column THEFTFROMMV_2015,
drop column THEFTFROMMV_2016,
drop column THEFTFROMMV_2017,
drop column THEFTFROMMV_2018,
drop column THEFTFROMMV_RATE_2014,
drop column THEFTFROMMV_RATE_2015,
drop column THEFTFROMMV_RATE_2016,
drop column THEFTFROMMV_RATE_2017,
drop column THEFTFROMMV_RATE_2018,
drop column THEFTFROMMV_RATE_2019,
drop column THEFTFROMMV_RATE_2020,
drop column THEFTFROMMV_RATE_2021,
drop column THEFTFROMMV_RATE_2022,
drop column THEFTFROMMV_RATE_2023,
drop column THEFTOVER_2014,
drop column THEFTOVER_2015,
drop column THEFTOVER_2016,
drop column THEFTOVER_2017,
drop column THEFTOVER_2018,
drop column THEFTOVER_RATE_2014,
drop column THEFTOVER_RATE_2015,
drop column THEFTOVER_RATE_2016,
drop column THEFTOVER_RATE_2017,
drop column THEFTOVER_RATE_2018,
drop column THEFTOVER_RATE_2019,
drop column THEFTOVER_RATE_2020,
drop column THEFTOVER_RATE_2021,
drop column THEFTOVER_RATE_2022,
drop column THEFTOVER_RATE_2023,
drop column Shape__Area,
drop column Shape__Length;

alter table ncr
drop column BIKETHEFT_RATE_2015;

select *
from ncr;

-- Adding new columns for different compaison and calculation requirements

ALTER TABLE ncr
ADD COLUMN Crime_2019  INT,
ADD COLUMN Crime_2020  INT,
ADD COLUMN Crime_2021  INT,
ADD COLUMN Crime_2022  INT,
ADD COLUMN Crime_2023  INT,
ADD COLUMN Crime_Percent_2023  float;

UPDATE ncr
SET 
Crime_2019 = assault_2019+autotheft_2019+biketheft_2019+breakenter_2019+homicide_2019+robbery_2019+shooting_2019+theftfrommv_2019+theftover_2019,
Crime_2020 = assault_2020+autotheft_2020+biketheft_2020+breakenter_2020+homicide_2020+robbery_2020+shooting_2020+theftfrommv_2020+theftover_2020,
Crime_2021 = assault_2021+autotheft_2021+biketheft_2021+breakenter_2021+homicide_2021+robbery_2021+shooting_2021+theftfrommv_2021+theftover_2021,
Crime_2022 = assault_2022+autotheft_2022+biketheft_2022+breakenter_2022+homicide_2022+robbery_2022+shooting_2022+theftfrommv_2022+theftover_2022,
Crime_2023 = assault_2023+autotheft_2023+biketheft_2023+breakenter_2023+homicide_2023+robbery_2023+shooting_2023+theftfrommv_2023+theftover_2023,
Crime_Percent_2023 = (crime_2023/population_2023)*100;

-- Null Value Removal

Select *
from ncr
where crime_2023 is null or crime_2023 = '';

select *
from ncr;


