DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;

DROP FUNCTION IF EXISTS fnc_trg_person_update_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit;

TRUNCATE person_audit;

CREATE OR REPLACE FUNCTION fnc_trg_audit() RETURNS TRIGGER AS $$

BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO person_audit VALUES (
        CURRENT_TIMESTAMP, 'I', NEW.ID, 
        NEW.name, NEW.age, NEW.gender, NEW.address
    );
    ELSEIF (TG_OP = 'UPDATE') THEN
        INSERT INTO person_audit VALUES (
        CURRENT_TIMESTAMP, 'U', OLD.ID, 
        OLD.name, OLD.age, OLD.gender, OLD.address
    );
    ELSEIF (TG_OP = 'DELETE') THEN
        INSERT INTO person_audit VALUES (
        CURRENT_TIMESTAMP, 'D', OLD.ID, 
        OLD.name, OLD.age, OLD.gender, OLD.address
    );
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_update_audit
AFTER UPDATE OR INSERT OR DELETE ON person
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk'); 
UPDATE person SET name = 'Bulat' WHERE id = 10; UPDATE person SET name = 'Damir' WHERE id = 10; 
DELETE FROM person WHERE id = 10;
