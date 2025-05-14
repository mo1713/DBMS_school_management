CREATE TABLE backup_trigger (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trigger_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER after_activity_log_insert
AFTER INSERT ON activity_log
FOR EACH ROW
BEGIN
    INSERT INTO backup_trigger (trigger_time) VALUES (NOW());
END//

DELIMITER ;