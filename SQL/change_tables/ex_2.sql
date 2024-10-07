alter table person_discounts
add constraint ch_nn_person_id check (person_id is not null);

