select 								--  взять 
	v.maker, 						--  данные из столбца maker таблицы vehicle 
	m.model							--  данные из столбца model таблицы motorcycle 
from motorcycle m					--  из таблицы motorcycle = m (alias)
join vehicle v on m.model = v.model	--  присоединить таблицу vehicle по общим столбцам model 
where m.horsepower > 150			--  где horsepower > 150 
	and m.price < 20000				--  и price < 20000 
	and m.type = 'Sport'			--  и тип 'Sport' 
order by m.horsepower desc;			--  отсортировать по убыванию по horsepower из таблицы motorcycle