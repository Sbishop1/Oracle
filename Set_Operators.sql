--
----set 1
----where roles and member types are the same
--select ROLE_DESCRIPTION "Member Description" from member_roles 
--intersect
--SELECT TYPE_DESCRIPTION FROM member_types 




--
----set2
----divisions that do not yet have their own dedicated center
--select    division_name 
--FROM      divisions
--WHERE     division_id IN 
--            (SELECT division_id FROM divisions
--            MINUS
--            SELECT  divison_id FROM centers)
--AND division_name NOT IN ('Executive')           
--


