-- I will create a table of States as A dimension Table and get data from the staging layer 

create table Dim_States (
State_PK int primary key identity(1,1),
State_Code varchar(20) not null,
State_Name varchar(100)
)


insert into dim_states (state_code,state_name)
select distinct stateid,state_name from staging.cons_states

update dim_states set state_code = upper(state_code),state_name = initcap(state_name)

select * from dim_states


-- I will create a table of Sectors as A dimension Table and get data from the staging layer 

create table Dim_Sectors (
Sector_PK int primary key identity(1,1),
Sector_Code varchar(20) not null,
Sector_Name varchar(100)
)

insert into dim_sectors (sector_code,sector_name)
select distinct sector_id,sector_name from staging.cons_states


update dim_sectors set sector_code = upper(sector_code),sector_name = initcap(sector_name)

select * from dim_sectors



-- I will create a table as a dimension date and put the data in it 

create table dim_date (
date_PK int primary key,
date varchar(50) not null,
year int not null,
month int not null,
month_name varchar(50) not null,
quarter int not null
)

insert into dim_date
select 
    to_number(to_char(dateadd(month, seq4(), '2004-01-01'), 'yyyymm')),
    to_char(dateadd(month, seq4(), '2004-01-01'), 'yyyy-mm'),
    year(dateadd(month, seq4(), '2004-01-01')),
    month(dateadd(month, seq4(), '2004-01-01')),
    to_char(dateadd(month, seq4(), '2004-01-01'), 'MMMM'),
    quarter(dateadd(month, seq4(), '2004-01-01'))
from table(generator(rowcount => 252))
where dateadd(month, seq4(), '2004-01-01') <= '2024-12-01'

select * from dim_date

-- I will create The Fact Table of Consumption

create table Fact_Cons (
Cons_id int primary key identity (1,1),
date varchar(50) not null,
date_Fk int not null,
State_Fk int not null,
Sector_Fk int not null,
Sales Decimal(20,2) not null,
Sales_unit varchar(50) not null
)


-- I will transfer the data from staging layer to the fact table

insert into Fact_Cons (date,date_Fk,State_Fk,Sector_Fk,Sales,Sales_unit) 
select c.date,d.date_pk,s.state_pk,ds.sector_pk,c.sales,c.sales_unit from staging.cons_states c
left join dim_date d
on c.date = d.date
left join dim_states s
on c.stateid = s.state_code and c.state_name = s.state_name 
left join dim_sectors ds
on c.sector_id = ds.sector_code and c.sector_name = ds.sector_name


select * from fact_cons 


alter table FACT_CONS add foreign key (date_fk) references dim_date(date_pk)

alter table FACT_CONS add foreign key (state_fk) references dim_states(state_pk)

alter table FACT_CONS add foreign key (sector_fk) references dim_sectors(sector_pk)

-- I will make a table of Sectors in Table of Types as dimension table 

create table dim_types_sectors (
Sector_Pk int primary key identity (1,1),
Sector_number int not null,
Sector_name varchar(100) not null
)

insert into dim_types_sectors (Sector_number,sector_name)
select distinct sector_id ,sector_name from staging.types_states


select * from dim_types_sectors


-- I will create a table of Types as a dimension table 

create table dim_source (
source_Pk int primary key identity (1,1),
source_Type varchar(50) not null,
source_desc varchar(150) not null
)


insert into dim_source (source_type,source_desc)
select distinct source_type,source_desc from staging.types_states

select * from dim_source 


-- Now I will create a table of Types as a Fact table and put the data from the staging in it 

create table Fact_Types (
type_id int primary key identity(1,1),
date varchar(100) not null,
date_fk int not null,
State_Fk int not null,
Sector_Fk int not null,
Source_Fk int not null,
quantity decimal(20,4),
unit varchar(100) not null
)


insert into Fact_Types (date,date_fk,state_fk,sector_fk,source_fk,quantity,unit)
select t.date,d.date_pk,s.state_pk,ts.sector_pk,so.source_pk,t.quantity,t.unit from staging.types_states t
left join dim_states s
on t.stateid = s.state_code 
left join dim_date d 
on t.date = d.date 
left join dim_types_sectors ts
on t.sector_id = ts.sector_number and t.sector_name = ts.sector_name 
left join dim_source so 
on t.source_type = so.source_type and t.source_desc = so.source_desc


select * from fact_types where type_id=1


-- add foreign keys 

alter table fact_types add foreign key (date_fk) references dim_date(date_pk)

alter table fact_types add foreign key (state_fk) references dim_states(state_pk)

alter table fact_types add foreign key (sector_fk) references dim_types_sectors(sector_pk)

alter table fact_types add foreign key (source_fk) references dim_source(source_pk)


-- I will create a Table of GDP and Population as a Fact Table 

create table GDP_POP_Fact (
pop_gdp_id int primary key identity (1,1),
state_fk int,
date varchar(100) not null,
date_fk int,
population decimal(20,4) not null,
GDP decimal(15,2) not null 
)


-- Now i will transfer the data from the staging layer to core layer 

insert into GDP_POP_Fact (state_fk,date,date_fk,population,GDP)
select s.state_pk,p.date,d.date_pk,p.population,g.gdp from staging.all_pop p 
inner join staging.gdp_states g
on p.date = g.date and p.state = g.geoname 
left join dim_states s 
on p.state = s.state_name 
left join dim_date d 
on p.date = d.date 


select * from GDP_POP_FACT


-- add foreign keys 

alter table gdp_pop_fact add foreign key (state_fk) references dim_states (state_pk)

alter table gdp_pop_fact add foreign key (date_fk) references dim_date (date_pk)

-------------------------------------------------------------

select * from staging.gdp_states where geoname = 'United States'

