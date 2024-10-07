select mn.pizza_name ,pz1.name AS pizzeria_name_1,    pz2.name AS pizzeria_name_2,
    mn.price
FROM menu mn
JOIN pizzeria pz1 ON mn.pizzeria_id = pz1.id
JOIN (
    SELECT menu.pizza_name, menu.price, menu.pizzeria_id, pizzeria.name     FROM menu 
    JOIN pizzeria ON menu.pizzeria_id = pizzeria.id) pz2 ON mn.price = pz2.price 
     AND mn.pizza_name = pz2.pizza_name
	 WHERE mn.pizzeria_id > pz2.pizzeria_id
ORDER BY pizza_name;
