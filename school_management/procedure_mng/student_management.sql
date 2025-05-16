-- Student_management
USE school_management1;

-- Thêm học sinh vào một lớp cụ thể 
DELIMITER //
CREATE PROCEDURE AddStudentWithClass(
    IN p_StudentName VARCHAR(100),
    IN p_Address VARCHAR(255),
    IN p_BirthDate DATE,
    IN p_Email VARCHAR(255),
    IN p_Note TEXT,
    IN p_Class_perID INT -- ID của lớp học kỳ
)
BEGIN
    -- 1. Thêm học sinh vào bảng students
    INSERT INTO students (StudentName, Address, BirthDate, Email, Note)
    VALUES (p_StudentName, p_Address, p_BirthDate, p_Email, p_Note);
    
    -- 2. Lấy ID học sinh mới thêm
    SET @NewStudentID = LAST_INSERT_ID();

    -- 3. Gán học sinh vào lớp cụ thể
    INSERT INTO students_classes (StudentID, Class_perID)
    VALUES (@NewStudentID, p_Class_perID);

    -- 4. Trả kết quả
    SELECT 
        @NewStudentID AS NewStudentID,
        p_Class_perID AS AssignedClass_perID;
END //
DELIMITER ;

-- Cập nhật thông tin học sinh
DELIMITER //
CREATE PROCEDURE UpdateStudent(
    IN p_StudentID INT,
    IN p_StudentName VARCHAR(100),
    IN p_Address VARCHAR(255),
    IN p_BirthDate DATE,
    IN p_Email VARCHAR(255),
    IN p_Note TEXT
)
BEGIN
    UPDATE students
    SET StudentName = p_StudentName,
        Address = p_Address,
        BirthDate = p_BirthDate,
        Email = p_Email,
        Note = p_Note
    WHERE StudentID = p_StudentID;

    SELECT ROW_COUNT() AS AffectedRows;
END //
DELIMITER ;

-- Xóa học sinh
DELIMITER //
CREATE PROCEDURE UpdateStudent(
    IN p_StudentID INT,
    IN p_StudentName VARCHAR(100),
    IN p_Address VARCHAR(255),
    IN p_BirthDate DATE,
    IN p_Email VARCHAR(255),
    IN p_Note TEXT
)
BEGIN
    UPDATE students
    SET StudentName = p_StudentName,
        Address = p_Address,
        BirthDate = p_BirthDate,
        Email = p_Email,
        Note = p_Note
    WHERE StudentID = p_StudentID;

    SELECT ROW_COUNT() AS AffectedRows;
END //
DELIMITER ;

-- Tra cứu thông tin cụ thể của học sinh thông qua StudentID và StudentName
DELIMITER //
CREATE PROCEDURE FindStudentDetail(
    IN p_StudentID INT,
    IN p_StudentName VARCHAR(100)
)
BEGIN
    SELECT 
        s.StudentID,
        s.StudentName,
        s.Address,
        s.BirthDate,
        s.Email,
        s.Note,
        c.ClassName,
        ap.Term,
        ap.Year
    FROM students s
    LEFT JOIN students_classes sc ON s.StudentID = sc.StudentID
    LEFT JOIN class_period cp ON sc.Class_perID = cp.id
    LEFT JOIN classes c ON cp.ClassID = c.ClassID
    LEFT JOIN academic_period ap ON cp.PerID = ap.PerID
    WHERE (p_StudentID IS NOT NULL AND s.StudentID = p_StudentID)
       OR (p_StudentID IS NULL AND (p_StudentName IS NULL OR s.StudentName LIKE CONCAT('%', p_StudentName, '%')))
    ORDER BY s.StudentName, ap.Year DESC, ap.Term DESC;
END //
DELIMITER ;

-- Tìm kiếm danh sách học sinh thông qua note( các note sẽ kiểu " cảnh báo học tập", "học lại"...)
DELIMITER //
CREATE PROCEDURE FindStudentsByNote(
    IN p_NoteKeyword TEXT
)
BEGIN
    SELECT 
        s.StudentID,
        s.StudentName,
        s.Address,
        s.BirthDate,
        s.Email,
        s.Note
    FROM students s
    WHERE p_NoteKeyword IS NULL 
       OR s.Note LIKE CONCAT('%', p_NoteKeyword, '%')
    ORDER BY s.StudentName;
END //
DELIMITER ;

