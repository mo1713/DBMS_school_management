-- Class management 
USE school_management1;

-- Procedure to add a new class
DELIMITER //
CREATE PROCEDURE AddClass(
    IN p_ClassName VARCHAR(255),
    IN p_Note TEXT
)
BEGIN
    INSERT INTO classes (ClassName, Note)
    VALUES (p_ClassName, p_Note);
    SELECT LAST_INSERT_ID() AS NewClassID;
END //
DELIMITER ;

-- Procedure to update an existing class
DELIMITER //
CREATE PROCEDURE UpdateClass(
    IN p_ClassID INT,
    IN p_ClassName VARCHAR(255),
    IN p_Note TEXT
)
BEGIN
    UPDATE classes
    SET ClassName = p_ClassName,
        Note = p_Note
    WHERE ClassID = p_ClassID;
    SELECT ROW_COUNT() AS AffectedRow;
END //
DELIMITER ;

-- Procedure to delete a class
DELIMITER //
CREATE PROCEDURE DeleteClass(
    IN p_ClassID INT
)
BEGIN
    DELETE FROM classes
    WHERE ClassID = p_ClassID;
    SELECT ROW_COUNT() AS AffectedRows;
END //
DELIMITER ;

-- Stored Procedure to get class list with teacher and student count
DELIMITER //
CREATE PROCEDURE GetClassList(
    IN p_SearchName VARCHAR(255), -- Search by class name (NULL for all)
    IN p_Limit INT             -- Number of records to return
)
BEGIN
    SELECT 
        c.ClassID,
        c.ClassName,
        t.TeacherName AS HomeroomTeacher,
        ap.Term,
        ap.Year,
        COUNT(sc.StudentID) AS StudentCount,
        c.Note
    FROM Classes c
    INNER JOIN Class_period cp ON c.ClassID = cp.ClassID
    INNER JOIN Teachers t ON cp.Homeroom_TeacherID = t.TeacherID
    INNER JOIN Academic_period ap ON cp.PerId = ap.PerId
    LEFT JOIN Students_Classes sc ON cp.id = sc.Class_perID
    WHERE p_SearchName IS NULL OR c.ClassName LIKE CONCAT('%', p_SearchName, '%')
    GROUP BY c.ClassID, c.ClassName, t.TeacherName, ap.Term, ap.Year
    ORDER BY c.ClassName
    LIMIT p_Limit;
END //
DELIMITER ;
-- Tìm lớp theo ClassName hoặc ClassID
DELIMITER //
CREATE PROCEDURE FindClass(
    IN p_ClassID INT,             -- Search by ClassID (NULL for no filter)
    IN p_ClassName VARCHAR(255)   -- Search by ClassName (NULL for no filter)
)
BEGIN
    SELECT 
        c.ClassID,
        c.ClassName,
        t.TeacherName AS HomeroomTeacher,
        ap.Term,
        ap.Year,
        COUNT(sc.StudentID) AS StudentCount,
        c.Note
    FROM Classes c
    INNER JOIN Class_period cp ON c.ClassID = cp.ClassID
    INNER JOIN Teachers t ON cp.Homeroom_TeacherID = t.TeacherID
    INNER JOIN Academic_period ap ON cp.PerId = ap.PerId
    LEFT JOIN Students_Classes sc ON cp.id = sc.Class_perID
    WHERE (p_ClassID IS NOT NULL AND c.ClassID = p_ClassID)
       OR (p_ClassID IS NULL AND (p_ClassName IS NULL OR c.ClassName LIKE CONCAT('%', p_ClassName, '%')))
    GROUP BY c.ClassID, c.ClassName, c.Note, t.TeacherName, ap.Term, ap.Year
    ORDER BY c.ClassName, ap.Year, ap.Term;
END //
DELIMITER ;

-- Hiện danh sách học sinh của lớp đó
DELIMITER //
CREATE PROCEDURE GetClassStudents(
    IN p_ClassID INT,              -- ClassID to fetch students for
	IN p_ClassName VARCHAR(255)
)

BEGIN
    SELECT 
        s.StudentID,
        s.StudentName,
        s.Address,
        s.BirthDate,
        s.Email,
        s.Note
    FROM Students s
    INNER JOIN Students_Classes sc ON s.StudentID = sc.StudentID
    INNER JOIN Class_period cp ON sc.Class_perID = cp.id
    INNER JOIN Classes c ON cp.ClassID = c.ClassID
    WHERE (p_ClassID IS NOT NULL AND c.ClassID = p_ClassID)
       OR (p_ClassID IS NULL AND (p_ClassName IS NULL OR c.ClassName LIKE CONCAT('%', p_ClassName, '%')))
    GROUP BY s.StudentID, s.StudentName, s.Address, s.BirthDate, s.Email
    ORDER BY s.StudentName;
END //
DELIMITER ;

-- Thời khóa biểu của một lớp
DELIMITER //
CREATE PROCEDURE GetClassSchedule(
    IN p_ClassID INT,
    IN p_PerId INT
)
BEGIN
    SELECT 
        c.ClassName,
        t.TeacherName,
        s.SubjectName,
        ts.DayOfWeek,
        ts.StartTime,
        ts.EndTime,
        sch.WeekNumber
    FROM Schedules sch
    INNER JOIN Class_period cp ON sch.Class_perID = cp.id
    INNER JOIN Classes c ON cp.ClassID = c.ClassID
    INNER JOIN Teachers t ON sch.TeacherID = t.TeacherID
    INNER JOIN Subjects s ON t.SubjectID = s.SubjectID
    INNER JOIN TimeSlots ts ON sch.TimeSlotID = ts.id
    WHERE cp.ClassID = p_ClassID 
    AND cp.PerId = p_PerId
    ORDER BY ts.DayOfWeek, ts.StartTime;
END //
DELIMITER ;
