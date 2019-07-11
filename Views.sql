
--View for the Head of Missions
CREATE VIEW Missionary_vw
AS
SELECT      first_name || ' ' || last_name "MISSIONARY NAME",
            mt.type_description "MISSIONAY TYPE",
            l.city "CITY OF SERVICE",
            c.country_name "NATION",
            TRUNC((SYSDATE - m.member_since)/365) "YEARS OF SERVICE"
FROM        members m
JOIN        member_types mt
ON          mt.type_id = m.member_type
JOIN        locations l
ON          l.location_id = m.location_id
JOIN        countries c
ON          c.country_id = l.country_id
WHERE       mt.type_description NOT IN('Alumni')
AND         m.manager_id = 1290;
select * from missionary_vw;


















--View for head of education Hanson
CREATE VIEW Student_enrolement_vw
AS
SELECT      m.first_name || ' ' || m.last_name "STUDENT NAME",
            ps.course_reference "ENROLED IN",
            p.description "MAJOR",
            s.acdmc_level "ACADEMIC LEVEL",
            m.member_since "STUDENT SINCE",
            (SELECT last_name FROM members where member_id = ps.instructor_id) "PROGRAM INSTRUCTOR"
FROM        students s
JOIN        members m
ON          m.member_id =s.student_id
JOIN        program_sections ps
ON          ps.section_id = s.enrolement
JOIN        programs p
ON          p.program_id = ps.program_id;

            
select * from STUDENT_ENROLEMENT_VW;


