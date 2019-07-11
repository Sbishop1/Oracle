/*
3 table join #1
finds all missionaries who are volunteers 
and the city where they work out of. 
*/
--
--SELECT  m.first_name || ' ' || last_name NAME, 
--        t.type_description TYPE, 
--        r.role_description ROLE,
--        l.city
--FROM    members m
--JOIN    member_roles r
--ON      m.member_role = r.role_id
--JOIN    member_types t
--ON      m.member_type = t.type_id
--JOIN    locations l
--ON      l.location_id = m.location_id
--WHERE   t.type_description = 'Volunteer'
--AND     r.role_description = 'Missionary';
--

/*
3 table join#2
finds the head of each divsion, 
the outpost type, the outpost address and country,
that are related to emergency and disaster care
*/

--SELECT    m.first_name || ' ' || m.last_name "Division Head",
--          d.division_name,
--          c.center_type Center,
--          l.street_address ||', '||
--          l.city ||' '||
--          l.state_province Address,
--          l.postal_code,
--          co.country_name Country
--FROM      divisions d
--JOIN      members m
--ON        m.member_id = d.divison_head
--JOIN      locations l
--ON        l.location_id = m.location_id
--JOIN      centers c
--ON        c.center_id = l.center_id
--JOIN      countries co
--ON        co.country_id = l.country_id
--WHERE     d.division_name LIKE '%Disaster%'
--OR        d.division_name LIKE '%Emergency%';



--Subquery
--finds the orgnizations exectives and thier years of service

--SELECT  first_name ||' '||last_name "Executive Roster",
--        TRUNC((sysdate - member_since)/365) "Years of Service"
--FROM    members
--WHERE   member_role 
--IN      (SELECT role_id 
--        FROM member_roles 
--        WHERE role_description = 'Executive');
--

/*simple join 1*/

--select  m.first_name ||' '||m.last_name "Student",
--        ps.course_reference "Current Enrolled Course"
--FROM    students s
--JOIN    members m
--ON      m.member_id = s.student_id
--JOIN    program_sections ps
--ON      ps.section_id = s.enrolement
--
----simple join 2
--SELECT  course_reference,
--        m.last_name "Instructor"
--FROM    program_sections ps
--JOIN    members m
--ON      m.member_id = ps.instructor_id



/**********Aggregates and Reports************************/

--aggregate 1
--counts the number of members in each city
SELECT  City, COUNT(*) "MEMBERS PER" 
FROM members m
JOIN    locations l
ON      l.location_id = m.location_id
GROUP BY CITY
ORDER BY 2 DESC;









--aggregate 2
--returns the number of cities that are teaching students
SELECT  COUNT(*) "Cities with students" from 
        (SELECT DISTINCT location_id FROM members m
        JOIN    students s
        ON      s.student_id = m.member_id);





--aggregate 3
--average and combined years of service for surgeons
SELECT DISTINCT
    'Aggregate of surgeons' AS "Description", 
    (SELECT  
            ROUND(AVG(TRUNC((sysdate - member_since)/365)),0) "Combined years of service"
    FROM    members
    WHERE   member_role =  (SELECT    role_ID
                            FROM      member_roles
                            WHERE     role_description = 'Surgeon')
    AND     member_type =  (SELECT    type_ID
                            FROM      member_types
                            WHERE     type_description = 'Employee')) "Average years of service",
    
    (SELECT  SUM(TRUNC((sysdate - member_since)/365))
    FROM    members
    WHERE   member_role =  (SELECT    role_ID
                            FROM      member_roles
                            WHERE     role_description = 'Surgeon')
    AND     member_type =  (SELECT    type_ID
                            FROM      member_types
                            WHERE     type_description = 'Employee')) "Combined years of service"
FROM members;













--aggregate 4
--Number of direct reports per manager
SELECT  DISTINCT m.last_name "Manager", count(m.member_id) "Count of direct reports" 
FROM    members m
JOIN    members mgr
ON      mgr.manager_id = m.member_id
GROUP BY    m.last_name;











--report 1
-- name and location of the surgeons
SELECT  m.first_name ||' '||m.last_name "NAME",
        mr.role_description,
        c.country_name
FROM    members m
JOIN    member_roles mr
ON      mr.role_id = m.member_role 
JOIN    locations l
ON       l.location_id = m.location_id
JOIN    countries c
ON      c.country_id = l.country_id
WHERE   mr.role_description LIKE 'Surg%';



--report 2
-- countries with no missionaries
SELECT DISTINCT c.country_name
FROM    countries c
JOIN    locations l
ON      l.country_id = c.country_id
JOIN    members m
ON      m.location_id = l.location_id
JOIN    member_roles mr
ON      mr.role_id = m.member_role
WHERE   mr.role_description != 'Missionary';



--report 3
--contries the have centers of Radiololgy, labratory, and Nerological care
SELECT  co.country_name, c.center_type
FROM    centers c
JOIN    locations l
ON      l.center_id = c.center_id
JOIN    countries co
ON      co.country_id = l  .country_id
WHERE   c.center_type IN('Radiology','Labs','Nerological Center');




--Report 4
--Instructors of the verious programs
SELECT  DISTINCT m.first_name ||' '||m.last_name "Instructor",
        p.description "Program"
FROM    members m
JOIN    program_sections ps
ON      ps.instructor_id = m.member_id
JOIN    programs p
ON      p.program_id = ps.program_id;





--report 5
--members who are managers but not executives and city where they work 
SELECT  DISTINCT m.first_name ||' '||m.last_name "Managers",
        mr.role_description "Role",
        city "Office"
FROM    members m
JOIN    members mgr
ON      mgr.manager_id = m.member_id
JOIN    member_roles mr
ON      mr.role_id = m.member_role
JOIN    locations l
ON      l.location_id = m.location_id
WHERE   mr.role_description != 'Executive';






----report 6
---- all members who are not students, employees nor volunteers
SELECT  m.first_name ||' '||m.last_name "members",
        mt.type_description "Member Type"
FROM    members m
JOIN    member_types mt
ON      mt.type_id = m.member_type
WHERE   mt.type_description NOT IN('Employee', 'Student','Volunteer');






----report 7
----returns the full address of locations in the same country as the headquarters
SELECT  l.street_address ||' '|| l.city ||' '|| l.state_province "Mailing Address",
        postal_code,
        c.country_name,
        ce.center_type
FROM    Locations l
JOIN    countries c
ON      c.country_id = l.country_id
JOIN    centers ce
ON      ce.center_id = l.center_id
WHERE   c.country_id = (SELECT  country_id 
                        FROM locations
                        WHERE  center_id = (SELECT center_id
                                            FROM   centers
                                            WHERE   center_type = 'ECHC headquarters'));
