USE school_management1;
-- DROP TRIGGER IF EXISTS after_teachers_insert;
DELIMITER //
CREATE TRIGGER after_teachers_insert
AFTER INSERT ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'teachers',
        CONCAT('New record added: TeacherID=', NEW.TeacherID, ', TeacherName=', NEW.TeacherName, ', SubjectID=', NEW.SubjectID, ', Email=', NEW.Email)
    );
END //
DELIMITER ;
-- Trigger cho update bảng teachers
-- DROP TRIGGER IF EXISTS after_teachers_update;
DELIMITER //
CREATE TRIGGER after_teachers_update
AFTER UPDATE ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'teachers',
        CONCAT('Record updated: TeacherID=', NEW.TeacherID, 
               ', Old TeacherID=', OLD.TeacherID, ', New TeacherID=', NEW.TeacherID,
               ', Old TeacherName=', OLD.TeacherName, ', New TeacherName=', NEW.TeacherName,
               ', Old SubjectID=', OLD.SubjectID, ', New SubjectID=', NEW.SubjectID , ', Old Email=', OLD.Email, ', New Email=', NEW.Email)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng teachers
-- DROP TRIGGER IF EXISTS after_teachers_delete;
DELIMITER //
CREATE TRIGGER after_teachers_delete
AFTER DELETE ON teachers
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'teachers',
        CONCAT('Record deleted: TeacherID=', OLD.TeacherID,', TeacherName=', OLD.TeacherName, ', SubjectID=', OLD.SubjectID, ', Email=', OLD.Email)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO teachers (TeacherID, TeacherName, SubjectID, Email) VALUES (7, 'Xinh Gai', 2, 'huhu@example.net');
COMMIT;
UPDATE teachers SET SubjectID = 5 , Email = 'hana@gmail.com'  WHERE TeacherID = 7;
COMMIT;
DELETE FROM teachers WHERE TeacherID = 5;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT * FROM teachers;