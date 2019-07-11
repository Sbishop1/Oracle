
--project sequence

CREATE SEQUENCE Course_Project_seq
START WITH     1000
INCREMENT BY   1
MINVALUE 1000
NOMAXVALUE
CACHE 100
NOCYCLE;

--pr0ject indexes

CREATE INDEX mem_name_idx
ON members(first_name, last_name);

CREATE INDEX m_role_desc_idx
ON member_roles(role_description);

CREATE INDEX address_idx
ON locations(street_address,city,state_province,postal_code);

