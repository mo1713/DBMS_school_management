USE school_management1;
-- DROP TRIGGER IF EXISTS after_students_classes_insert;
DELIMITER //
CREATE TRIGGER after_students_classes_insert
AFTER INSERT ON students_classes
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'students_classes',
        CONCAT('New record added: id=', NEW.id, ', StudentID=', NEW.StudentID, ',Class_perID=', NEW.Class_perID)
    );
END //
DELIMITER ;
-- Trigger cho update bảng students_classes
-- DROP TRIGGER IF EXISTS after_students_classes_update;
DELIMITER //
CREATE TRIGGER after_students_classes_update
AFTER UPDATE ON students_classes
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'students_classes',
        CONCAT('Record updated: id=', NEW.id, 
               ', Old id=', OLD.id, ', New id=', NEW.id,
               ', Old StudentID=', OLD.StudentID, ', New StudentID=', NEW.StudentID,
               ', Old Class_perID=', OLD.Class_perID, ', New Class_perID=', NEW.Class_perID)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng students_classes
-- sDROP TRIGGER IF EXISTS after_students_classes_delete;
DELIMITER //
CREATE TRIGGER after_students_classes_delete
AFTER DELETE ON students_classes
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'students_classes',
        CONCAT('Record deleted: id=', OLD.id, ', StudentID=', OLD.StudentID, ', Class_perID=', OLD.Class_perID)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO students_classes (id, StudentID, Class_perID) VALUES (6, 4 , 2);
COMMIT;
UPDATE students_classes SET StudentID = 1 , Class_perID = 3  WHERE id = 6;
COMMIT;
DELETE FROM students_classes WHERE id = 2;
COMMIT;
*/
-- SELECT * FROM activity_log;
-- SELECT *FROM students_classes;