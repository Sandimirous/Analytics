select t1.name as pizzeria_name from 
((select pz.name , COUNT(pv.visit_date) from pizzeria  AS pz
join person_visits pv on pv.pizzeria_id = pz.id
join person ps on ps.id = pv.person_id
where ps.gender = 'male'
group by pz.name 
EXCEPT ALL
select pz.name , COUNT(pv.visit_date) from pizzeria  AS pz
join person_visits pv on pv.pizzeria_id = pz.id
join person ps on ps.id = pv.person_id
where ps.gender = 'female'
group by pz.name) 
union all
(select pz.name , COUNT(pv.visit_date) from pizzeria  AS pz
join person_visits pv on pv.pizzeria_id = pz.id
join person ps on ps.id = pv.person_id
where ps.gender = 'female'
group by pz.name 
EXCEPT ALL
select pz.name , COUNT(pv.visit_date) from pizzeria  AS pz
join person_visits pv on pv.pizzeria_id = pz.id
join person ps on ps.id = pv.person_id
where ps.gender = 'male'
group by pz.name)) as t1
group by t1.name
order by t1.name;

--логика такая:выбираем из названий пиццерий которые чаще посещали мужчины
--потом чаще всего женщины
--результат объединяем 
--а где было одинаковое кол-во раз не войдет
