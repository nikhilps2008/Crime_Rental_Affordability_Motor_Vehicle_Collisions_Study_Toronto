-- Final Datasets for EDA are mvc2,ncr,rdy,rd
-- we can combine mvc2,ncr,rd as they have common columns

select *
from mvc2;

select *
from ncr;

select *
from rdy;

select *
from rd;

-- 1. What is the trend of motor collisions over the years?

select year(DATE) as Year, count(DISTINCT CONCAT(DATE, ' ', TIME)) as Collisions
from mvc2
group by 1
order by 2 desc;

-- 2. Which Age demographic Drivers are more inclined to involved in motor vehicle collisions?

select INVAGE as Age_Group, count(DISTINCT CONCAT(DATE, ' ', TIME)) as Collisions
from mvc2
where INVTYPE='Driver'
group by 1
order by 2 desc;

-- 3. How many fatal accidents happened in the last 5 years?

select year(DATE) as Year,count(DISTINCT CONCAT(DATE, ' ', TIME)) as 'Fatal Collisions'
from mvc2
where ACCLASS='Fatal'
group by 1
order by 2 desc;

-- 4. Does visibility cause high amount of collisions? What was the road condition? If Visibility caused it, List them how much each year?

select year(DATE) as Year,RDSFCOND as Road_Condition,VISIBILITY,count(DISTINCT CONCAT(DATE, ' ', TIME)) as Collisions
from mvc2
where INVTYPE='Driver'
group by 1,2,3
order by 4 desc;

-- 5. How many collisions are caused by under the influence of alcohol and Speeding each year?

select year(DATE) as Year, count(DISTINCT CONCAT(DATE, ' ', TIME)) as Collisions
from mvc2
where (ALCOHOL='Yes' or SPEEDING='Yes') and INVTYPE='Driver' 
group by 1
order by 2 desc;

-- 6. Find out 5 neighbourhoods that had more collisions?

select NEIGHBOURHOOD_158 as Neighbourhood, count(DISTINCT CONCAT(DATE, ' ', TIME)) as Collisions
from mvc2 m
group by 1
order by 2 desc
limit 5;

-- 7. Find out 5 neighbourhoods that had more crime?

select AREA_NAME as Neighbourhood, 
Crime_2019+Crime_2020+Crime_2021+Crime_2022+Crime_2023 as Total_Crime
from ncr
order by 2 desc
limit 5;

-- 8. What is the trend of crime over the years?

SELECT 2019 AS Year, SUM(crime_2019) AS Crime FROM ncr
UNION ALL
SELECT 2020 AS Year, SUM(crime_2020) AS Crime FROM ncr
UNION ALL
SELECT 2021 AS Year, SUM(crime_2021) AS Crime FROM ncr
UNION ALL
SELECT 2022 AS Year, SUM(crime_2022) AS Crime FROM ncr
UNION ALL
SELECT 2023 AS Year, SUM(crime_2023) AS Crime FROM ncr;


-- 9. Find out the 7 neighbourhoods that have more autotheft?

select AREA_NAME as Neighbourhood, 
AUTOTHEFT_2019+AUTOTHEFT_2020+AUTOTHEFT_2021+AUTOTHEFT_2022+AUTOTHEFT_2023 as Total_Auto_Theft
from ncr
order by 2 desc
limit 7;

-- 10. Find out 5 neighbourhoods that have least theft crime?

select AREA_NAME as Neighbourhood, 
+THEFTFROMMV_2020+THEFTFROMMV_2021+THEFTFROMMV_2022+THEFTFROMMV_2023+THEFTOVER_2019+THEFTOVER_2020+THEFTOVER_2021+THEFTOVER_2022+THEFTOVER_2023 as Total_Theft
from ncr
order by 2
limit 5;

-- 11. What is the rental price trend over the years

select Year, average_rent as Rent
from rdy;

-- 12. Does different rent affect crime?

select n.AREA_NAME as Neighbourhood, Crime_2023 as Crime, r.One_Bed as Rent
from rd as r
join ncr as n
on r.hood_id=n.hood_id
order by 3 desc;

-- 13. Are there any relationship between collision and crime?

select m.NEIGHBOURHOOD_158 as Neighbourhood,count(DISTINCT CONCAT(DATE, ' ', TIME)) as Collisions, 
n.Crime_2019+n.Crime_2020+n.Crime_2021+n.Crime_2022+n.Crime_2023 as 'Total Crime'
from mvc2 m
join ncr n
on m.hood_158=n.hood_id
group by 1
order by 3 desc;

-- 14. Does Rich neighbourhood areas have more breakins and less Shooting?

select n.AREA_NAME as Neighbourhood,BREAKENTER_2019+BREAKENTER_2020+BREAKENTER_2021+BREAKENTER_2022+BREAKENTER_2023 as 'Break-In',SHOOTING_2019+SHOOTING_2020+SHOOTING_2021+SHOOTING_2022+SHOOTING_2023 as 'Shooting',
 r.One_Bed as Rent
from ncr n
join rd r
on n.HOOD_ID=r.Hood_ID
order by 4 desc;

-- 15. Find out 5 neighbourhoods that had less crime and collisions and rent on 2023?

select NEIGHBOURHOOD_158 as Neighbourhood, count(DISTINCT CONCAT(DATE, ' ', TIME)) as Collisions,Crime_2023 as Total_Crime, r.One_Bed as Rent
from mvc2 m
join ncr n
on m.HOOD_158=n.HOOD_ID
join rd r
on m.HOOD_158=r.HOOD_ID
where m.DATE>'2022-12-31'
group by 1
order by 3, 2, 4
limit 10;

-- KPI Cards

-- Collision

select count(DISTINCT CONCAT(DATE, ' ', TIME)) as 'Total Collisions'
from mvc2;

-- Crime

select sum(Crime_2019+Crime_2020+Crime_2021+Crime_2022+Crime_2023) as 'Total Crime'
from ncr;

-- Average Rent

select Avg(average_rent) as 'Average Rent'
from rdy;