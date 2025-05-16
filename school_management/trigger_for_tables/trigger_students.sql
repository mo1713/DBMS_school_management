USE school_management1;
-- DROP TRIGGER IF EXISTS after_students_insert;
DELIMITER //
CREATE TRIGGER after_students_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'students',
        CONCAT('New record added: StudentID=', NEW.StudentID, ', StudentName=', NEW.StudentName, ', StudentID=', NEW.StudentName, ', Address=', NEW.Address, ', BirthDate=', NEW.BirthDate, ', Email=', NEW.Email)
    );
END //
DELIMITER ;
-- Trigger cho update bảng students
-- DROP TRIGGER IF EXISTS after_students_update;
DELIMITER //
CREATE TRIGGER after_students_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'students',
        CONCAT('Record updated: StudentID=', NEW.StudentID, 
               ', Old StudentID=', OLD.StudentID, ', New StudentID=', NEW.StudentID,
               ', Old StudentName=', OLD.StudentName, ', New StudentName=', NEW.StudentName,
               ', Old Address=', OLD.Address, ', New Address=', NEW.Address , ', Old BirthDate=', OLD.BirthDate, ', New BirthDate=', NEW.BirthDate, 
               ', Old Email=', OLD.Email, ', New Email=', NEW.Email)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng students
-- DROP TRIGGER IF EXISTS after_students_delete;
DELIMITER //
CREATE TRIGGER after_students_delete
AFTER DELETE ON students
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'students',
        CONCAT('Record deleted: StudentID=', OLD.StudentID,', StudentName=', OLD.StudentName, ', Address=', OLD.Address, ', BirthDate=', OLD.BirthDate, ', Email', OLD.Email)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO students (StudentID, StudentName, Address, BirthDate, Email) VALUES (80, 'Thanh Mo', 'Bac Giang', '2005-06-01', 'mo@gmail.com');
COMMIT;
UPDATE students SET Address = 'Hanoi' , BirthDate = '2009-05-31'  WHERE StudentID = 5;
COMMIT;
DELETE FROM students WHERE StudentID = 3;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT * FROM students;