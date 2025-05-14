USE school_management1;
-- DROP TRIGGER IF EXISTS after_money_insert;
DELIMITER //
CREATE TRIGGER after_money_insert
AFTER INSERT ON money
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'money',
        CONCAT('New record added: id=', NEW.id, ', StudentID=', NEW.StudentID, ', PerID=', NEW.PerID, ', Value=', NEW.Value, ', Paid=', NEW.Paid, ', Debt=', NEW.Debt)
    );
END //
DELIMITER ;
-- Trigger cho update bảng money
-- DROP TRIGGER IF EXISTS after_money_update;
DELIMITER //
CREATE TRIGGER after_money_update
AFTER UPDATE ON money
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'money',
        CONCAT('Record updated: id=', NEW.id, 
               ', Old id=', OLD.id, ', New id=', NEW.id,
               ', Old StudentID=', OLD.StudentID, ', New StudentID=', NEW.StudentID , ', Old PerID=', OLD.PerID, ', New PerID=', NEW.PerID,
               ', Old Value=', OLD.Value, ', New Value=', NEW.Value , ', Old Paid=', OLD.Paid, ', New Paid=', NEW.Paid, 
               ', Old Debt=', OLD.Debt, ', New Debt=', NEW.Debt)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng money
-- DROP TRIGGER IF EXISTS after_money_delete;
DELIMITER //
CREATE TRIGGER after_money_delete
AFTER DELETE ON money
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'money',
        CONCAT('Record deleted: id=', OLD.id,', StudentID=', OLD.StudentID, ', PerID=', OLD.PerID, ', Value=', OLD.Value, ', Paid=', OLD.Paid,  ', Debt=', OLD.Debt)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO money (id, StudentID, PerID, Value, Paid, Debt) VALUES (6, 5, 4, 1500000, 1000000, 500000);
COMMIT;
UPDATE money SET Value = 9 , Debt = 1  WHERE id = 5;
COMMIT;
DELETE FROM money WHERE id = 4;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT * FROM money;
