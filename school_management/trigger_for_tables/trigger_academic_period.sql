USE school_management1;
-- DROP TRIGGER IF EXISTS after_academic_period_insert;
DELIMITER //
CREATE TRIGGER after_academic_period_insert
AFTER INSERT ON academic_period
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'academic_period',
        CONCAT('New record added: PerId=', NEW.PerId, ', Term=', NEW.Term, ',Year=', NEW.Year)
    );
END //
DELIMITER ;
-- Trigger cho update bảng academic_period
-- DROP TRIGGER IF EXISTS after_academic_period_update;
DELIMITER //
CREATE TRIGGER after_academic_period_update
AFTER UPDATE ON academic_period
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'academic_period',
        CONCAT('Record updated: PerId=', NEW.PerId, 
               ', Old PerId=', OLD.PerId, ', New PerId=', NEW.PerId,
               ', Old Term=', OLD.Term, ', New Term=', NEW.Term,
               ', Old Year=', OLD.Year, ', New Year=', NEW.Year)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng academic_period
-- sDROP TRIGGER IF EXISTS after_academic_period_delete;
DELIMITER //
CREATE TRIGGER after_academic_period_delete
AFTER DELETE ON academic_period
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'academic_period',
        CONCAT('Record deleted: PerId=', OLD.PerId, ', Term=', OLD.Term, ', Year=', OLD.Year)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO academic_period (PerId, Term, Year) VALUES (77, 3 , 1);
COMMIT;
UPDATE academic_period SET Term = 1 , Year = 3  WHERE PerId = 77;
COMMIT;
DELETE FROM academic_period WHERE PerId = 2;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT *FROM academic_period;