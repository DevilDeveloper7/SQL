/*1. Решить 6 задач на тему агрегации и объединения данных.
Необходимо решить ряд задач:
1)Таблица OE.CUSTOMERS. Сформируйте новое поле GENDER_GROUP, при условии, если гендер мужского пола - значение 1, если женского - значение 0.
2)Таблица OE.CUSTOMERS OE.orders hr.employees
Выведите имена покупателей и продавцов, которые сделали заказ, где у одного продавца сделал покупку минимум дважды один покупатель
3) Таблица  OLYM.OLYM_MEDALS и OLYM.OLYM_GAMES
Посчитать количество (золотых, серебряных, бронзовых) медалей, полученные в Сиднее (2000 год)
4) OLYM.OLYM_MEDALS и OLYM.OLYM_GAMES  OLYM.OLYM_ATHLETES  OLYM.OLYM_ATHLETE_GAMES
Вывести имена атлетов, которые получили золотые медали в Лос-Анджелесе (84 год)
5)Определить пол, который получил наибольшее количество золотых медалей в Атланте
6)hr.employees, hr.departments , hr.locations
Определить название города, где количество сотрудников больше среднего значения */
1.select
cust_first_name,
cust_last_name,
gender,
    case gender
        when 'M'
        then 1
        else 0
        end as gender_group
        
from oe.customers
where material_status = 'single';

2.select
	employee,
	customer,
	num
from
(
	select
	t3.first_name as employee,
	t1.cust_first_name as customer,
	count(t1.cust_first_name) as num
	from oe.customers t1
	inner join oe.orders t2
	on t1.customer_id = t2.customer_id
	inner join hr.employees t3
	on t2.sales_rep_id = t3.employee_id
	group by t3.first_name, t1.cust_first_name)
where num >= 2

3.select
    t1.medal,
    count(t1.medal) as medals
from olym.olym_medals t1
inner join (
    select 
        id
    from olym.olym_games
    where id = 24 and city = 'Sydney'
    ) t2
on t1.event_id = t2.id
group by medal;

4.
select 
    t1.athlete_game_id,
    t1.medal,
    t2.id,
    t2.athlete_name,
    t3.id,
    t3.city
from olym.olym_medals t1
inner join olym.olym_athletes t2
on t1.athlete_game_id = t2.id
inner join olym.olym_games t3
on t1.event_id = t3.id
where t3.id = 20 and t3.city = 'Los Angeles' and t1.medal = 'Gold';

5.
select count(athlete_gender) as countGender, athlete_gender from (
select 
    t1.athlete_gender,
    t2.medal,
    t3.city
from olym.olym_athletes t1
inner join olym.olym_medals t2
on t1.id  = t2.athlete_game_id
inner join olym.olym_games t3
on t2.event_id = t3.id
where t3.city = 'Atlanta' and t2.medal = 'Gold'
)

group by athlete_gender
having count(athlete_gender) > 1;