SELECT person1.name AS person_name1, person2.name AS person_name2,person1.address
AS common_address FROM
person AS person1
CROSS JOIN person AS person2 
WHERE person1.address = person2.address AND person1.id > person2.id
ORDER BY person_name1 , person_name2, person1.address;
