insert into person_discounts(id,person_id,pizzeria_id,discount)
(
select ROW_NUMBER() OVER() as id,
person_id,pz.id, case 
when count(po.person_id) = 1 then 10.5
when count(po.person_id) = 2 then 22
else 30
end as discount
from person_order po
join menu mn on mn.id = po.menu_id 
join pizzeria pz on pz.id = mn.pizzeria_id
group by person_id,pz.id
order by person_id
);
