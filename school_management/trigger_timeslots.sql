USE school_management1;
-- DROP TRIGGER IF EXISTS after_timeslots_insert;
DELIMITER //
CREATE TRIGGER after_timeslots_insert
AFTER INSERT ON timeslots
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'timeslots',
        CONCAT('New record added: id=', NEW.id, ', DayOfWeek=', NEW.DayOfWeek, ', StartTime=', NEW.StartTime, ', EndTime=', NEW.EndTime)
    );
END //
DELIMITER ;
-- Trigger cho update bảng timeslots
-- DROP TRIGGER IF EXISTS after_timeslots_update;
DELIMITER //
CREATE TRIGGER after_timeslots_update
AFTER UPDATE ON timeslots
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'timeslots',
        CONCAT('Record updated: id=', NEW.id, 
               ', Old id=', OLD.id, ', New id=', NEW.id,
               ', Old DayOfWeek=', OLD.DayOfWeek, ', New DayOfWeek=', NEW.DayOfWeek,
               ', Old StartTime=', OLD.StartTime, ', New StartTime=', NEW.StartTime , ', Old EndTime=', OLD.EndTime, ', New EndTime=', NEW.EndTime)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng timeslots
-- DROP TRIGGER IF EXISTS after_timeslots_delete;
DELIMITER //
CREATE TRIGGER after_timeslots_delete
AFTER DELETE ON timeslots
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'timeslots',
        CONCAT('Record deleted: id=', OLD.id,', DayOfWeek=', OLD.DayOfWeek, ', StartTime=', OLD.StartTime, ', EndTime=', OLD.EndTime)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO timeslots (id, DayOfWeek, StartTime, EndTime) VALUES (10, 'Monday', '06:00:00', '09:00:00');
COMMIT;
UPDATE timeslots SET StartTime = '05:00:00'  WHERE id = 10;
COMMIT;
DELETE FROM timeslots WHERE id = 5;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT * FROM timeslots;