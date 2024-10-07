DROP TABLE if EXISTS person_audit;

CREATE TABLE person_audit (
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type_event CHAR(1) NOT NULL,
    ROW_ID BIGINT NOT NULL,
    name VARCHAR,
    age INTEGER,
    gender VARCHAR,
    address VARCHAR,
    CONSTRAINT ch_type_event CHECK (type_event IN ('I', 'U', 'D'))
);

CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO person_audit VALUES (
        CURRENT_TIMESTAMP, 'I', NEW.ID, 
        NEW.name, NEW.age, NEW.gender, NEW.address
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS fnc_trg_person_insert_audit ON person;
CREATE TRIGGER trg_person_insert_audit
AFTER INSERT ON person 
FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');
