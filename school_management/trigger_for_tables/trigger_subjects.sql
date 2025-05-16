USE school_management1;
-- DROP TRIGGER IF EXISTS after_subjects_insert;
DELIMITER //
CREATE TRIGGER after_subjects_insert
AFTER INSERT ON subjects
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'subjects',
        CONCAT('New record added: SubjectID=', NEW.SubjectID, ', SubjectName=', NEW.SubjectName)
    );
END //
DELIMITER ;
-- Trigger cho update bảng subjects
-- DROP TRIGGER IF EXISTS after_subjects_update;
DELIMITER //
CREATE TRIGGER after_subjects_update
AFTER UPDATE ON subjects
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'subjects',
        CONCAT('Record updated: SubjectID=', NEW.SubjectID, 
               ', Old SubjectID=', OLD.SubjectID, ', New SubjectID=', NEW.SubjectID, 
               ', Old SubjectName=', OLD.SubjectName, ', New SubjectName=', NEW.SubjectName)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng subjects
-- DROP TRIGGER IF EXISTS after_subjects_delete;
DELIMITER //
CREATE TRIGGER after_subjects_delete
AFTER DELETE ON subjects
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'subjects',
        CONCAT('Record deleted: SubjectID=', OLD.SubjectID, ', SubjectName=', OLD.SubjectName)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO subjects (SubjectID, SubjectName) VALUES (88, 'haha');
COMMIT;
UPDATE subjects SET SubjectName = 'hihi' WHERE SubjectID = 3;
COMMIT;
DELETE FROM subjects WHERE SubjectID = 4;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT * FROM subjects;