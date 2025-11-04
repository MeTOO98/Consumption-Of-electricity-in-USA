select * from CONS_STATES

-- The Table Cons_States if the Sector_Name is Other there is no sales so i will drop rows if the sector is others 

select sum(sales) from cons_states where sector_name = 'other' 


delete from CONS_STATES where sector_name = 'other'

select * from CONS_STATES where sales is null

-- here I make every column with the correct format

select date,upper(stateid),initcap(state_name),upper(sector_id),lower(sector_name),sales,lower(sales_unit) from CONS_STATES


-- I will transfer the data to the table of Dim_States in the core layer 

select distinct stateid,state_name into Core.DIM_STATES
from cons_states

-- I will make the columns (Stateid,statename,sectorid,sectorname) in the right format to make joining to create fact table 

update cons_states set stateid = upper(stateid),state_name=initcap(state_name),sector_id=upper(sector_id),sector_name=initcap(sector_name) 

-- Now i will go to Types of Source Table 

select * from types_states

-- I want to check if every state in this table in dim_states that i created 

update types_states set stateid = upper(stateid) , state_name = initcap(state_name)


select distinct stateid from types_states where stateid not in (select state_code from core.dim_states)

select distinct state_code,state_name from core.dim_states

update types_states set stateid = 'PACN' where stateid = 'PCN' 

update types_states set stateid = 'PACC' where stateid = 'PCC'

-- insert the the data in this table to state dimension 

insert into core.dim_states (state_code,state_name)
select distinct stateid,state_name from types_states where stateid not in (select state_code from core.dim_states)


update types_states set sector_name = initcap(sector_name)


select distinct sector_id from types_states

update types_states set stateid = upper(stateid),state_name=initcap(state_name)


update core.dim_states set state_code = upper(state_code)


select * from core.dim_types_sectors


update core.dim_types_sectors set sector_name = initcap(sector_name)


select * from types_states

-- Now i will transfer the data of GDP and population to the core layer 

select * from gdp_states


select * from pop_21_24


-- first i will make the three tables of population one Table 

select distinct state from pop_5_10

select * from pop_5_10

update pop_5_10 set state = replace(state,'.','') 

update pop_5_10 set state = initcap(state)

alter table pop_5_10 add column new_Date varchar(100)

update pop_5_10 set new_Date = to_varchar(date)

alter table pop_5_10 drop column date
alter table pop_5_10 rename column new_date TO date

update pop_5_10 set date = to_char(TO_TIMESTAMP(POP_5_10.DATE, 'YYYY-MM-DD HH24:MI:SS.FF3'),'YYYY-MM')

---------------

select distinct state from pop_11_20

update pop_11_20 set state = replace(state,'.','') 

update pop_11_20 set state = initcap(state)

alter table pop_11_20 add column new_Date varchar(100)

update pop_11_20 set new_Date = to_varchar(date)

alter table pop_11_20 drop column date
alter table pop_11_20 rename column new_date TO date

update pop_11_20 set date = to_char(TO_TIMESTAMP(POP_11_20.DATE, 'YYYY-MM-DD HH24:MI:SS.FF3'),'YYYY-MM')

select * from pop_11_20

------------------

select * from pop_21_24

select distinct state from pop_21_24

update pop_21_24 set state = replace(state,'.','') 

update pop_21_24 set state = initcap(state)

alter table pop_21_24 add column new_Date varchar(100)

update pop_21_24 set new_Date = to_varchar(date)

alter table pop_21_24 drop column date
alter table pop_21_24 rename column new_date TO date

update pop_21_24 set date = to_char(TO_TIMESTAMP(POP_21_24.DATE, 'YYYY-MM-DD HH24:MI:SS.FF3'),'YYYY-MM')

------------------------------
create table all_pop (
state varchar(100),
population decimal(20,4),
data varchar(100)
)


insert into all_pop 
select * from pop_5_10
union 
select * from pop_11_20 
union 
select * from pop_21_24


select * from all_pop where state ='Alabama'

------------------------


select * from gdp_states

select distinct geoname from gdp_states

update gdp_states set geoname = initcap(geoname)

alter table gdp_states add column new_Date varchar(100)

update gdp_states set new_Date = to_varchar(date)

alter table gdp_states drop column date
alter table gdp_states rename column new_date TO date

update gdp_states set date = to_char(TO_TIMESTAMP(gdp_states.DATE, 'YYYY-MM-DD HH24:MI:SS.FF3'),'YYYY-MM')


-------------------------


select distinct geoname from gdp_states where geoname not in (select distinct state from all_pop)

-------------------------

select * from all_pop


select distinct state from all_pop where state not in (select distinct state_name from core.dim_states)



select distinct state from all_pop p 
inner join gdp_states g
on p.data = g.date and p.state = g.geoname 
where state not in (select distinct state_name from core.dim_states)

---------------------------------

alter table all_pop rename column data TO date

