-- Tạo bảng bảng với 3 cột INSERT, UPDATE, DELETE
USE school_management1;
DROP TABLE IF EXISTS activity_log;
CREATE TABLE activity_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(10), -- Loại hành động: INSERT, UPDATE, DELETE
    table_name VARCHAR(50), -- Tên bảng bị ảnh hưởng
    log_message TEXT,       -- Thông tin chi tiết (dữ liệu thay đổi, thời gian, v.v.)
    log_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP -- Thời gian thực hiện
);
/*Test table activity_log
USE school_management1;
SELECT id, action_type, table_name, log_message, log_timestamp
FROM activity_log
ORDER BY log_timestamp DESC;*/