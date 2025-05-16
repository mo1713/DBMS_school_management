USE school_management1;
-- DROP TRIGGER IF EXISTS after_class_period_insert;
DELIMITER //
CREATE TRIGGER after_class_period_insert
AFTER INSERT ON class_period
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'class_period',
        CONCAT('New record added: id=', NEW.id, ', ClassID=', NEW.ClassID, ', PerId=', NEW.PerId, ', Homeroom_TeacherID=', NEW.Homeroom_TeacherID)
    );
END //
DELIMITER ;
-- Trigger cho update bảng class_period
-- DROP TRIGGER IF EXISTS after_class_period_update;
DELIMITER //
CREATE TRIGGER after_class_period_update
AFTER UPDATE ON class_period
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'class_period',
        CONCAT('Record updated: id=', NEW.id, 
               ', Old id=', OLD.id, ', New id=', NEW.id,
               ', Old ClassID=', OLD.ClassID, ', New ClassID=', NEW.ClassID,
               ', Old PerId=', OLD.PerId, ', New PerId=', NEW.PerId , 
               ', Old Homeroom_TeacherID=', OLD.Homeroom_TeacherID, ', New Homeroom_TeacherID=', NEW.Homeroom_TeacherID)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng class_period
-- DROP TRIGGER IF EXISTS after_class_period_delete;
DELIMITER //
CREATE TRIGGER after_class_period_delete
AFTER DELETE ON class_period
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'class_period',
        CONCAT('Record deleted: id=', OLD.id,', ClassID=', OLD.ClassID, ', PerId=', OLD.PerId, ', Homeroom_TeacherID=', OLD.Homeroom_TeacherID)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO class_period (id, ClassID, PerId, Homeroom_TeacherID) VALUES (10, 3, 3, 3);
COMMIT;
UPDATE class_period SET PerId = '4'  WHERE id = 10;
COMMIT;
DELETE FROM class_period WHERE id = 1;
COMMIT;
*/
-- SELECT * FROM activity_log;
-- SELECT * FROM class_period;