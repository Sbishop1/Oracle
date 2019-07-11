
--country data
INSERT INTO COUNTRIES
VALUES('&Country_ID', '&Country_NAME');
Select * FROM COUNTRIES;

--
--Member type data
INSERT INTO member_types
VALUES(course_project_seq.nextval,
        '&Member_type_description');
Select * FROM member_types;



--Member role data
INSERT INTO member_roles
VALUES(course_project_seq.nextval,
        '&Member_role_description');
Select * FROM member_roles;




INSERT INTO divisions
    VALUES(course_project_seq.nextval,
    '&Description',
    '&Division_head');
SELECT * FROM divisions;

--
--

INSERT INTO centers
    VALUES(course_project_seq.nextval,
    '&Description',
    (SELECT division_id
        FROM divisions WHERE 
        LOWER(division_name) = LOWER('&divsion')));
SELECT * FROM centers;    

--
INSERT INTO LOCATIONS
    VALUES(course_project_seq.nextval,
          '&Street_Address',
          '&City',
          '&State_Provence',
          '&Postal_Code',
          (SELECT       country_id
                FROM    countries
                WHERE   country_id = UPPER('&Country_ID')),
          (SELECT       center_id
                FROM    centers
                WHERE   LOWER(center_type) = LOWER('&Center_ID')));
            select * from locations;    
--            
--            

INSERT INTO MEMBERS
    VALUES(
            course_project_seq.nextval,
            '&First_name',
            '&Last_name',
            (SELECT     type_id
                FROM    MEMBER_TYPES
                WHERE   LOWER(type_description) = LOWER('&Member_type')),
            (SELECT     role_id
                FROM    MEMBER_ROLES
                WHERE   LOWER(role_description) = LOWER('&Role_type')),
             (SELECT    member_id
                FROM    members
                WHERE   last_name = LOWER('&Manager_id')),
            TO_DATE('&Member_since','DD-MON-YYYY'),
            TO_NUMBER('&location_id'));
select * from members;

Update MEMBERS
SET manager_id = 1290
where member_id IN (
1192,
1203,
1211,
1221,
1233,
1237,
1241,
1244,
1251,
1291
);
select * from members where manager_id IS NOT NULL;
commit;




--
INSERT INTO PROGRAM_SECTIONS
    VALUES(course_project_seq.nextval,
            '&course_ref',
            TO_NUMBER('&instructer_id'),
            TO_NUMBER('&location_id'),
            TO_NUMBER('&program_id'));
SELECT * FROM program_sections;
--



--    UPDATE program_sections
--    SET PROGRAM_ID = 1323
--    WHERE SECTION_ID IN (1315,1316);
--    select * from program_sections;
    
    
--    UPDATE DIVISIONS
--    SET divison_head = 1190
--    where division_id = 1178;
--    SELECT * FROM DIVISIONS;
--    







INSERT INTO PROGRAMS
    VALUES(course_project_seq.nextval,
            '&description');
SELECT * FROM PROGRAMS;











--
INSERT INTO students
VALUES( TO_NUMBER('&member_id'),
        TO_NUMBER('&program_id'),
        ('&student_level'),
        TO_NUMBER('&enrolement')
);
select * from students;
    commit;
    
    
    
    
    
    
    
    
    
    
    
    
    
    