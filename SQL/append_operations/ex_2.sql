select coalesce(person.name,'-') as person_name, 
visit_date, 
coalesce(pizzeria.name,'-') as pizzeria_name
from 
(select * from person_visits where 
visit_date = '2022-01-01' or visit_date = '2022-01-02'
or visit_date = '2022-01-03') as t1
full join person on t1.person_id = person.id
full join pizzeria on t1.pizzeria_id = pizzeria.id
order by person_name,visit_date,pizzeria_name;
