USE school_management1;
-- DROP TRIGGER IF EXISTS after_schedules_insert;
DELIMITER //
CREATE TRIGGER after_schedules_insert
AFTER INSERT ON schedules
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'schedules',
        CONCAT('New record added: id=', NEW.id, ', Class_perID=', NEW.Class_perID, ', id=', NEW.Class_perID, ', TeacherID=', NEW.TeacherID, ', TimeSlotID=', NEW.TimeSlotID, ', WeekNumber=', NEW.WeekNumber)
    );
END //
DELIMITER ;
-- Trigger cho update bảng schedules
-- DROP TRIGGER IF EXISTS after_schedules_update;
DELIMITER //
CREATE TRIGGER after_schedules_update
AFTER UPDATE ON schedules
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'schedules',
        CONCAT('Record updated: id=', NEW.id, 
               ', Old id=', OLD.id, ', New id=', NEW.id,
               ', Old Class_perID=', OLD.Class_perID, ', New Class_perID=', NEW.Class_perID,
               ', Old TeacherID=', OLD.TeacherID, ', New TeacherID=', NEW.TeacherID , ', Old TimeSlotID=', OLD.TimeSlotID, ', New TimeSlotID=', NEW.TimeSlotID, 
               ', Old WeekNumber=', OLD.WeekNumber, ', New WeekNumber=', NEW.WeekNumber)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng schedules
-- DROP TRIGGER IF EXISTS after_schedules_delete;
DELIMITER //
CREATE TRIGGER after_schedules_delete
AFTER DELETE ON schedules
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'schedules',
        CONCAT('Record deleted: id=', OLD.id,', Class_perID=', OLD.Class_perID, ', TeacherID=', OLD.TeacherID, ', TimeSlotID=', OLD.TimeSlotID, ', WeekNumber', OLD.WeekNumber)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO schedules (id, Class_perID, TeacherID, TimeSlotID, WeekNumber) VALUES (5, 1, 1, 1, 1);
COMMIT;
UPDATE schedules SET TeacherID = '3'  WHERE id = 5;
COMMIT;
DELETE FROM schedules WHERE id = 3;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT * FROM schedules;