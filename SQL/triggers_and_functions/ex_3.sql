CREATE OR REPLACE FUNCTION func_minimum(
    arr VARIADIC NUMERIC[]
) RETURNS NUMERIC AS $$

DECLARE
    min_value NUMERIC;
    i INT;
BEGIN
    min_value := arr[1];
    foreach i in array arr LOOP
        IF i < min_value THEN
            min_value := i;
        END IF;
    END LOOP;
    RETURN min_value;
END;

$$ LANGUAGE plpgsql;

SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
