Решение:
select
    case 
        when GENDER = 'F' or gender =  'Female'
        then 'Женщина'
        when gender = 'Male' or gender  = 'M'
        then 'Мужчина'
    end gender,
    regexp_substr(email, '^\w+[@]\w+[.]\w+') as email,
    regexp_replace(regexp_substr(email,'[+]?[- 0-9]+$'),'[ -]','') as phone,
    
    case 
        when first_name is null
        then regexp_substr(last_name,'^\w+')
        when last_name is null
        then regexp_substr(first_name,'\w+$')
        else first_name
    end first_name,
    case 
        when last_name is null
        then regexp_substr(first_name,'\w+$')
        when first_name is null
        then regexp_substr(last_name,'\w+$')
        else last_name
    end last_name
from data;
/*
Условие:

create table dataSource (
first_name varchar(255),
last_name varchar(255),
email varchar(255),
gender varchar(255)
);insert into dataSource (first_name, last_name, email, gender) values
(null, 'Hilda Sodo', 'hsodo1o@surveymonkey.com', 'F');
insert into dataSource (first_name, last_name, email, gender) values
('Torin Cardus', null, 'tcardus21@ow.ly', 'Male');
insert into dataSource (first_name, last_name, email, gender) values
(null, 'Artur MacShane', 'amacshane2d@princeton.edu', 'M');
insert into dataSource (first_name, last_name, email, gender) values
('Freedman Krause', null, 'fkrause5t@dagondesign.com', 'Male');
insert into dataSource (first_name, last_name, email, gender) values
(null, 'Lemmers Remington', 'rlemmers70@tripod.com', 'Male');
insert into dataSource (first_name, last_name, email, gender) values
('Tucker', 'Crauford', 'tcraufords@chicagotribune.com +7 9346553 221', 'M');
insert into dataSource (first_name, last_name, email, gender) values
('Winfield', 'Sharpe', 'wsharpe5k@amazon.co.jp +7-912-321-84-43', 'Male');
insert into dataSource (first_name, last_name, email, gender) values
('Caresa', 'Symmers', '+79824433556', 'F');
insert into dataSource (first_name, last_name, email, gender) values
('Rosita', 'McGing', 'rmcging5@nps.gov 89235428443', 'Female');
insert into dataSource (first_name, last_name, email, gender) values
('Elinor', 'Barca', 'ebarca54@ning.com 89022338843', 'Female');
insert into dataSource (first_name, last_name, email, gender) values
('Paxon', 'Rimington', '89094235643', 'Male');
insert into dataSource (first_name, last_name, email, gender) values
('Truda', 'Biffin', 'tbiffin89@wired.com', 'F');
insert into dataSource (first_name, last_name, email, gender) values
('Noland', 'Buesden', '893265432 85', 'Male');
insert into dataSource (first_name, last_name, email, gender) values
('Brana Champion', null, 'bchampiondv@csmonitor.com', 'Female');select * from dataSource1.
Сформировать единый вид для поля Gender.
Мужской пол должен иметь значение 'Мужчина', а женский 'Женщина'2.
Сформировать для поля Email единый вид.
Если в поле есть почта и телефон - оставить только почту.
Если есть только номер - оставить тип Null, если есть только почта - ее и оставить.
Привести имя в нужнвй вид.
Там где значение имена null - вытянуть его из фамилии.
Если в поле есть имя и фамилия - оставить только имя*/

