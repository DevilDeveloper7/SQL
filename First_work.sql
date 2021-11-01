/*1. Объединения данных
1)Используя таблицу hr.employees, hr.departments 
Выведите имя менеджера каждого департмента и его зарплату
2) Используя таблицы oe.orders, oe.customers и hr.employees
Вывести имена покупателей и продавцов, которые сделали заказ, где статус заказа имеет значение 3
3)Используя таблицу hr.employees, hr.departments и hr.locations
Вывести имена сотрудников, чей департмент находится в провинции штата 'Техасс'*/
1) 
select * from hr.employees;
select * from hr.departments

select
t2.department_id,
t2.department_name,
t1.salary,t1.first_name,
t1.last_name
from hr.departments t2
inner join hr.employees t1
on t1.department_id = t2.department_id;

2)
select
t2.cust_first_name,
t3.first_name,
t1.order_status
from oe.customers t2
inner join oe.orders t1
on t1.customer_id = t2.customer_id
inner join hr.employees t3
on t3.employee_id = t1.sales_rep_id
where order_status = '3';

3)
select 
t1.first_name,
t1.last_name,
t2.department_id,
t3.location_id,
t3.state_province
from hr.employees t1
inner join hr.departments t2
on t1.department_id = t2.department_id
inner join hr.locations t3
on t2.location_id = t3.location_id
where t3.state_province = 'Texas';
