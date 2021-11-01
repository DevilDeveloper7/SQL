alter table source_data
rename column field1 to id;

update source_data
set price = replace(substr(price, 1, instr(price, '₽')-1), ' ', ''), 
ПРОБЕГ = replace(substr(ПРОБЕГ, 1, instr(ПРОБЕГ, 'км')-1), ' ', '');
create table engine as
    select
        id,
        case
            when instr(ДВИГАТЕЛЬ,'/') is not null
            then substr(ДВИГАТЕЛЬ,1,3)
        end МОЩНОСТЬ,
        case 
            when instr(ДВИГАТЕЛЬ,'/',1,2) is not null
            then substr(ДВИГАТЕЛЬ,instr(ДВИГАТЕЛЬ,'/ ',1,1)+2,3)
        end ОБЬЕМ,
        case
            when  instr(ДВИГАТЕЛЬ,'/',-1,1) is not null
            then substr(ДВИГАТЕЛЬ,instr(ДВИГАТЕЛЬ,'/',1,2)+2,8)
        end ТИП_ТОПЛИВА
from source_data;
--приведение к 3НФ двигателя
select * from engine;

create view count_year as
    select distinct
        ГОД_ВЫПУСКА,
        (select
            count(t2.ГОД_ВЫПУСКА)
            from source_data t2
            where t1.ГОД_ВЫПУСКА = t2.ГОД_ВЫПУСКА
            ) as count_cars
    from source_data t1;
select * from count_year;


create view middle_price as 
select 
  (
    select 
      count(price) 
    from 
      source_data 
    where 
      price > (
        select 
          avg(price) 
        from 
          source_data
      )
  ) as HightPrice, 
  (
    select 
      count(price) as LowPrice 
    from 
      source_data 
    where 
      price < (
        select 
          avg(price) 
        from 
          source_data
      )
  ) as LowPrice 
from 
  source_data
  WHERE ROWNUM = 1;
select * from middle_price;


create view difference as 
 select (select 
  abs(
    avg(t1.price) - avg(t2.price)
  ) 
from 
  (
    select 
      price, 
      id 
    from 
      source_data 
    where 
      ТАМОЖНЯ = 'Растаможен'
  ) t1 
  inner join (
    select 
      price, 
      id
    from 
      source_data 
    where 
      ТАМОЖНЯ != 'Растаможен'
  ) t2 on 1 = 1) as diff
from source_data
where rownum =1;
select * from difference;

alter table source_data
drop (UNNAMED_0, ДВИГАТЕЛЬ);

select * from source_data;