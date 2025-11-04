-- I will create a table of consumption 


create table cons_states (
date varchar(100),
stateid varchar(5),
State_Name varchar(100),
Sector_id varchar(10),
Sector_Name varchar(100),
Sales decimal(20,3),
Unit varchar(100)
)


-- I will create a table of Types of Source 


create table Types_states (
date varchar(100),
stateid varchar(5),
State_Name varchar(100),
Sector_id varchar(10),
Sector_Name varchar(100),
Source_Type varchar(100),
Quantity decimal(8,2),
Unit varchar(100)
)



-- I will create a Table of Population from 2005-2010 


create table pop_5_10 (
State  varchar(100),
date datetime,
population decimal(15,2)
)



-- From 2011-2020

create table pop_11_20 (
State  varchar(100),
date datetime,
population decimal(15,2)
)


-- From 2021-2024

create table pop_21_24 (
State  varchar(100),
date datetime,
population decimal(15,2)
)


-- I will create a table of GPD 

create table GPD_states (
GeoName varchar(100),
date datetime,
GDP decimal(15,2)
)

