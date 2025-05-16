-- Teacher management
USE school_management1;

-- Thêm giáo viên
DELIMITER //
CREATE PROCEDURE AddTeacher(
    IN p_TeacherName VARCHAR(255),
    IN p_SubjectID INT,
    IN p_Email VARCHAR(255)
)
BEGIN
    INSERT INTO teachers (TeacherName, SubjectID, Email)
    VALUES (p_TeacherName, p_SubjectID, p_Email);

    SELECT LAST_INSERT_ID() AS NewTeacherID;
END //
DELIMITER ;

-- Update thông tin giáo viên
DELIMITER //
CREATE PROCEDURE UpdateTeacher(
    IN p_TeacherID INT,
    IN p_TeacherName VARCHAR(255),
    IN p_SubjectID INT,
    IN p_Email VARCHAR(255)
)
BEGIN
    UPDATE teachers
    SET TeacherName = p_TeacherName,
        SubjectID = p_SubjectID,
        Email = p_Email
    WHERE TeacherID = p_TeacherID;

    SELECT ROW_COUNT() AS AffectedRows;
END //
DELIMITER ;

-- Xóa giáo viên
DELIMITER //
CREATE PROCEDURE DeleteTeacher(
    IN p_TeacherID INT
)
BEGIN
    DELETE FROM teachers
    WHERE TeacherID = p_TeacherID;

    SELECT ROW_COUNT() AS AffectedRows;
END //
DELIMITER ;

-- Tìm kiếm thông tin giảng viên 
DELIMITER //
CREATE PROCEDURE FindTeacher(
    IN p_TeacherID INT,
    IN p_TeacherName VARCHAR(255)
)
BEGIN
    SELECT 
        t.TeacherID,
        t.TeacherName,
        t.Email,
        s.SubjectName
    FROM teachers t
    LEFT JOIN subjects s ON t.SubjectID = s.SubjectID
    WHERE (p_TeacherID IS NOT NULL AND t.TeacherID = p_TeacherID)
       OR (p_TeacherID IS NULL AND (p_TeacherName IS NULL OR t.TeacherName LIKE CONCAT('%', p_TeacherName, '%')))
    ORDER BY t.TeacherName;
END //
DELIMITER ;

-- Lịch giảng dạy của giáo viên 
DELIMITER //
CREATE PROCEDURE GetTeacherSchedule(
    IN p_TeacherID INT,
    IN p_Term INT,
    IN p_Year INT
)
BEGIN
    SELECT 
        t.TeacherName,
        s.SubjectName,
        c.ClassName,
        ts.DayOfWeek,
        ts.StartTime,
        ts.EndTime,
        sch.WeekNumber,
        ap.Term,
        ap.Year
    FROM schedules sch
    INNER JOIN teachers t ON sch.TeacherID = t.TeacherID
    INNER JOIN subjects s ON t.SubjectID = s.SubjectID
    INNER JOIN class_period cp ON sch.Class_perID = cp.id
    INNER JOIN classes c ON cp.ClassID = c.ClassID
    INNER JOIN timeslots ts ON sch.TimeSlotID = ts.id
    INNER JOIN academic_period ap ON cp.PerID = ap.PerID
    WHERE sch.TeacherID = p_TeacherID 
      AND ap.Term = p_Term 
      AND ap.Year = p_Year
    ORDER BY ts.DayOfWeek, ts.StartTime;
END //
DELIMITER ;

-- Danh sách giáo viên 
DELIMITER //
CREATE PROCEDURE GetAllTeachers()
BEGIN
    SELECT 
        t.TeacherID,
        t.TeacherName,
        t.Email,
        s.SubjectName
    FROM teachers t
    LEFT JOIN subjects s ON t.SubjectID = s.SubjectID
    ORDER BY t.TeacherName;
END //
DELIMITER ;




