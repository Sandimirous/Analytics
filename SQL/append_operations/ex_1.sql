SELECT gs::date AS missing_date
FROM generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') AS gs(date)
LEFT JOIN person_visits ON person_visits.visit_date = gs::date 
AND (person_visits.person_id = '1' or person_visits.person_id = '2')
GROUP BY gs::date
HAVING COUNT(person_visits.person_id) = 0
ORDER BY missing_date;
