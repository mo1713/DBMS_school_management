USE school_management1;
-- Trigger cho insert thông tin vào bảng classes
-- DROP TRIGGER IF EXISTS after_classes_insert;
DELIMITER //
CREATE TRIGGER after_classes_insert
AFTER INSERT ON classes
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'classes',
        CONCAT('New record added: ClassID=', NEW.ClassID, ', ClassName=', NEW.ClassName)
    );
END //
DELIMITER ;
-- Trigger cho update bảng classes
DROP TRIGGER IF EXISTS after_classes_update;
DELIMITER //
CREATE TRIGGER after_classes_update
AFTER UPDATE ON classes
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'classes',
        CONCAT('Record updated: ClassID=', NEW.ClassID, 
               ', Old ClassID=', OLD.ClassID, ', New ClassID=', NEW.ClassID, 
               ', OLD.ClassName=', NEW.ClassName, ', NEW.ClassName=', NEW.ClassName)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng classes
-- DROP TRIGGER IF EXISTS after_classes_delete;
DELIMITER //
CREATE TRIGGER after_classes_delete
AFTER DELETE ON classes
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'classes',
        CONCAT('Record deleted: ClassID=', OLD.ClassID, ', ClassName=', OLD.ClassName)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO classes (ClassID, Classname) VALUES (199, 'DSEB');
COMMIT;
UPDATE classes SET ClassName = 'T1Val' WHERE ClassID = 5;
COMMIT;
DELETE FROM classes WHERE ClassID = 5;
COMMIT;
INSERT INTO classes (ClassID, Classname) VALUES (100, 'mocute');
COMMIT;*/
SELECT * FROM activity_log;
-- SELECT * FROM classes;