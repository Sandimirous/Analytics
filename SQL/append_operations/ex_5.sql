SELECT pr.name 
FROM person pr
JOIN person_order po ON po.person_id = pr.id
JOIN menu mn ON mn.id = po.menu_id
WHERE pr.gender = 'female' AND mn.pizza_name IN ('pepperoni pizza', 'cheese pizza')
GROUP BY pr.name
HAVING COUNT(DISTINCT mn.pizza_name) = 2
ORDER BY pr.name;
