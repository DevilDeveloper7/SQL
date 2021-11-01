/*1. Необходимо вытянуть из HTML тегов информацию следующим образом, используя строковые функции
1) в первом теге id книги 
2) в теге h1 категория 
3) в теге с классом title название книги
4) в теге с классом author автор книги
5) в теге с классом price цена книги 
Необходимо написать запрос, который позволит достать значение из поля value для каждого
пункта в отдельный тег и по возможности очистить и привести к оптимальному типу данных. */
select 
    substr(value, instr(value,'<p>')+3,instr(substr(value, instr(value,'<p>')+3,instr(value,'/p>')),'</')-1) as id,
    substr(value, instr(value,'<h1>')+4, instr(substr(value,instr(value,'<h1>')+3,instr(value,'</h1>')),'</h1>')-2) as category,
    substr(value,instr(value,'title')+7,instr(value,'</p>',instr(value,'title')) - instr(value,'title')-7) as title,
    substr(value,instr(value,'author')+8,instr(value,'</p>',instr(value,'author')) - instr(value,'author')-8) as author,
    substr(value,instr(value,'price')+7,instr(value,'</p>',instr(value,'price')) - instr(value,'price')-8) as price

from data;