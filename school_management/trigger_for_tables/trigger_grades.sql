USE school_management1;
-- DROP TRIGGER IF EXISTS after_grades_insert;
DELIMITER //
CREATE TRIGGER after_grades_insert
AFTER INSERT ON grades
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'INSERT',
        'grades',
        CONCAT('New record added: GradeID=', NEW.GradeID, ', SubjectID=', NEW.SubjectID, ', StudentID=', NEW.StudentID, ', Score=', NEW.Score, ', Weight=', NEW.Weight, ', PerId=', NEW.perID)
    );
END //
DELIMITER ;
-- Trigger cho update bảng grades
-- DROP TRIGGER IF EXISTS after_grades_update;
DELIMITER //
CREATE TRIGGER after_grades_update
AFTER UPDATE ON grades
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'UPDATE',
        'grades',
        CONCAT('Record updated: GradeID=', NEW.GradeID, 
               ', Old GradeID=', OLD.GradeID, ', New GradeID=', NEW.GradeID,
               ', Old SubjectID=', OLD.SubjectID, ', New SubjectID=', NEW.StudentID , ', Old StudentID=', OLD.StudentID, ', New StudentID=', NEW.StudentID,
               ', Old Score=', OLD.Score, ', New Score=', NEW.Score , ', Old Weight=', OLD.Weight, ', New Weight=', NEW.Weight, 
               ', Old perID=', OLD.perID, ', New perID=', NEW.perID)
    );
END //
DELIMITER ;
-- Trigger cho delete dữ liệu bảng grades
-- DROP TRIGGER IF EXISTS after_grades_delete;
DELIMITER //
CREATE TRIGGER after_grades_delete
AFTER DELETE ON grades
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (action_type, table_name, log_message)
    VALUES (
        'DELETE',
        'grades',
        CONCAT('Record deleted: GradeID=', OLD.GradeID,', SubjectID=', OLD.SubjectID, ', StudentID=', OLD.StudentID, ', Score=', OLD.Score, ', Weight=', OLD.Weight,  ', perID=', OLD.perID)
    );
END //
DELIMITER ;
-- Test
/*INSERT INTO grades (GradeID, SubjectID, StudentID, Score, Weight, perID) VALUES (19, 5, 1, 6.2, 3, 4);
COMMIT;
UPDATE grades SET Score = 9 , PerId = 1  WHERE GradeID = 5;
COMMIT;
DELETE FROM grades WHERE GradeID = 4;
COMMIT;*/
-- SELECT * FROM activity_log;
-- SELECT * FROM grades;
