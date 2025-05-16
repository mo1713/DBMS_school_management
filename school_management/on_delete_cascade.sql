USE school_management1;
DROP PROCEDURE IF EXISTS set_all_foreign_keys_on_delete_cascade;
DELIMITER //
CREATE PROCEDURE set_all_foreign_keys_on_delete_cascade()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE fk_table_name VARCHAR(64);
    DECLARE fk_constraint_name VARCHAR(64);
    DECLARE fk_column_name VARCHAR(64);
    DECLARE ref_table_name VARCHAR(64);
    DECLARE ref_column_name VARCHAR(64);
    
    -- Cursor để lấy tất cả các ràng buộc khóa ngoại
    DECLARE fk_cursor CURSOR FOR
        SELECT 
            TABLE_NAME,
            CONSTRAINT_NAME,
            COLUMN_NAME,
            REFERENCED_TABLE_NAME,
            REFERENCED_COLUMN_NAME
        FROM information_schema.KEY_COLUMN_USAGE
        WHERE TABLE_SCHEMA = DATABASE()
        AND REFERENCED_TABLE_NAME IS NOT NULL;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Bắt đầu giao dịch để đảm bảo tính toàn vẹn
    START TRANSACTION;

    -- Tạm thời vô hiệu hóa kiểm tra khóa ngoại
    SET FOREIGN_KEY_CHECKS = 0;

    OPEN fk_cursor;

    read_loop: LOOP
        FETCH fk_cursor INTO fk_table_name, fk_constraint_name, fk_column_name, ref_table_name, ref_column_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Xóa ràng buộc khóa ngoại cũ
        SET @drop_sql = CONCAT('ALTER TABLE ', fk_table_name, ' DROP FOREIGN KEY ', fk_constraint_name);
        PREPARE stmt FROM @drop_sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        -- Thêm lại ràng buộc với ON DELETE CASCADE
        SET @add_sql = CONCAT(
            'ALTER TABLE ', fk_table_name, 
            ' ADD CONSTRAINT ', fk_constraint_name, 
            ' FOREIGN KEY (', fk_column_name, ')',
            ' REFERENCES ', ref_table_name, ' (', ref_column_name, ')',
            ' ON DELETE CASCADE'
        );
        PREPARE stmt FROM @add_sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;

    CLOSE fk_cursor;

    -- Bật lại kiểm tra khóa ngoại
    SET FOREIGN_KEY_CHECKS = 1;

    -- Hoàn tất giao dịch
    COMMIT;
END //

DELIMITER ;
CALL set_all_foreign_keys_on_delete_cascade();