USE school_management;
SELECT * FROM classes;
CALL FindClass(NULL, 'Math 101', NULL, NULL);

CALL GetClassSchedule(1, 'Math 101', NULL , NULL);

CALL GetClassStudents(1, 'Math 101', NULL, NULL);

CALL sp_fee_detail_by_student(1);

CALL sp_total_by_student(1);

CALL FindClassByName('Math 101', NULL, NULL); 
CALL FindClassByName(NULL);   

CALL FindClassByID(1, NULL, NULL);   
CALL FindClassByID(NULL); 

CALL FindTeacherByName('Mr. A'); 
CALL FindTeacherByName(NULL);   -- Liệt kê tất cả giáo viên

CALL FindTeacherBySubject('Math'); 
CALL FindTeacherBySubject(NULL);   -- Liệt kê tất cả giáo viên có bộ môn

CALL UpdateTeacherSubject(6, 'Mo', 5); -- Cập nhật SubjectID thành 5

-- Cập nhật học sinh có StudentID = 1 sang lớp có ClassID = 2 trong kỳ 1, năm 2023.
CALL UpdateStudentClass(1, 2, 1, 2023);

CALL FindTeacherByNameAndSubject('Mo', 'Math');

CALL GetAllYears();

SHOW PROCEDURE STATUS WHERE Name = 'AddGrade';

CALL AddGrade(1, 1, 9 ,3, 1, 2024);

SELECT * FROM Grades;