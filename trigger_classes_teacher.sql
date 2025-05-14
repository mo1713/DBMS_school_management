USE school_management1;
-- DROP TRIGGER IF EXISTS after_classes_teacher_insert;
DELIMITER //
CREATE TRIGGER after_classes_teacher_insert
AFTER INSERT ON classes_teacher
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'classes_teacher',
        CONCAT('New record added: id=', NEW.id, ', Class_perID=', NEW.Class_perID, ',TeacherID=', NEW.TeacherID)
    );
END //
DELIMITER ;
-- Trigger cho update bảng classes_teacher
-- DROP TRIGGER IF EXISTS after_classes_teacher_update;
DELIMITER //
CREATE TRIGGER after_classes_teacher_update
AFTER UPDATE ON classes_teacher
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'classes_teacher',
        CONCAT('Record updated: id=', NEW.id, 
               ', Old id=', OLD.id, ', New id=', NEW.id,
               ', Old Class_perID=', OLD.Class_perID, ', New Class_perID=', NEW.Class_perID,
               ', Old TeacherID=', OLD.TeacherID, ', New TeacherID=', NEW.TeacherID)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng classes_teacher
-- sDROP TRIGGER IF EXISTS after_classes_teacher_delete;
DELIMITER //
CREATE TRIGGER after_classes_teacher_delete
AFTER DELETE ON classes_teacher
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'classes_teacher',
        CONCAT('Record deleted: id=', OLD.id, ', Class_perID=', OLD.Class_perID, ', TeacherID=', OLD.TeacherID)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO classes_teacher (id, Class_perID, TeacherID) VALUES (77, 3 , 1);
COMMIT;
UPDATE classes_teacher SET Class_perID = 1 , TeacherID = 3  WHERE id = 77;
COMMIT;
DELETE FROM classes_teacher WHERE id = 2;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT *FROM classes_teacher;