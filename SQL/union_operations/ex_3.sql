select t1.name as pizzeria_name from 
(((select pz.name  from menu AS mn
join person_order po on po.menu_id = mn.id
join person ps on ps.id = po.person_id
join pizzeria pz on pz.id = mn.pizzeria_id
where ps.gender = 'female') 
except
(select pz.name  from menu AS mn
join person_order po on po.menu_id = mn.id
join person ps on ps.id = po.person_id
join pizzeria pz on pz.id = mn.pizzeria_id
where ps.gender = 'male'))
union 
((select pz.name  from menu AS mn
join person_order po on po.menu_id = mn.id
join person ps on ps.id = po.person_id
join pizzeria pz on pz.id = mn.pizzeria_id
where ps.gender = 'male'
) 
except
(select pz.name  from menu AS mn
join person_order po on po.menu_id = mn.id
join person ps on ps.id = po.person_id
join pizzeria pz on pz.id = mn.pizzeria_id
where ps.gender = 'female'
))) as t1
group by t1.name
order by t1.name;
