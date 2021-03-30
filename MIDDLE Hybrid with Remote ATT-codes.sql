SELECT
s.lastfirst, 
s.student_number, 
ps_customfields.getStudentsCF(s.id,'Contact1_Homephone'),
ps_customfields.getStudentsCF(s.id,'Contact1_Cellphone'),
CASE(ps_customfields.getStudentsCF(s.id,'cohort'))
    WHEN 'A' THEN 'Blue'
    WHEN 'B' THEN 'Orange'
    WHEN 'C' THEN 'Combine'
    ELSE 'non-slection' END cohort,
ac.att_code, 
a.att_date,
CASE WHEN ( (ps_customfields.getStudentsCF(s.id,'cohort')) = 'A' AND 
    ( (to_char(TO_DATE('%param1%'),'D')) = '2' OR (to_char(TO_DATE('%param1%'),'D')) = '3' )) THEN 'A'
    WHEN ((ps_customfields.getStudentsCF(s.id,'cohort')) = 'B' AND ( (to_char(TO_DATE('%param1%'),'D')) = '5' OR (to_char(TO_DATE('%param1%'),'D')) = '6' )) THEN 'B'
    ELSE 'U'
    END SchoolInPersonDay

FROM Students s JOIN Attendance a ON s.id = a.studentid AND a.schoolid = s.schoolid
JOIN Attendance_Code ac ON a.attendance_codeid = ac.id

WHERE
a.att_Mode_Code =  'ATT_ModeMeeting' AND
s.enroll_status = 0 AND
s.schoolid = ~(curschoolid) AND
ac.att_code LIKE 'R_%' AND
-- ps_customfields.getStudentsCF(s.id,'FULL_DISTANCE_LEARN') IS NULL AND
-- ps_customfields.getStudentsCF(s.id,'cohort') IN ('A', 'C') AND
a.att_date = TO_DATE( '%param1%') AND
-- ps_customfields.getStudentsCF(s.id,'cohort') = '%param2%' AND
(to_char(TO_DATE('%param1%'),'D'))  != 4  AND
CASE WHEN ( (ps_customfields.getStudentsCF(s.id,'cohort')) = 'A' AND 
    ( (to_char(TO_DATE('%param1%'),'D')) = '2' OR (to_char(TO_DATE('%param1%'),'D')) = '3' )) THEN 'A'
    WHEN ((ps_customfields.getStudentsCF(s.id,'cohort')) = 'B' AND ( (to_char(TO_DATE('%param1%'),'D')) = '5' OR (to_char(TO_DATE('%param1%'),'D')) = '6' )) THEN 'B'
    ELSE 'U'
    END = ps_customfields.getStudentsCF(s.id,'cohort') 

ORDER BY s.lastfirst

