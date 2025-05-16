import mysql.connector
import subprocess
import os
import datetime
import shutil
import time
from pathlib import Path

# Cấu hình MySQL
MYSQL_CONFIG = {
    'user': 'root', 
    'password': '11230571',  
    'host': 'localhost',
    'database': 'school_management1'
}

# Cấu hình sao lưu
BACKUP_DIR = r'D:\Backup_database'  # Thư mục trên ổ cứng máy
#ONEDRIVE_DIR = r'C:\Users\YourUsername\OneDrive\Backups'  # Thư mục OneDrive
DB_NAME = 'school_management1'
RETENTION_DAYS = 7  # Giữ file sao lưu 7 ngày
CHECK_INTERVAL = 5  # Kiểm tra backup_trigger mỗi 5 giây

def check_backup_trigger():
    try:
        # Kết nối MySQL
        conn = mysql.connector.connect(**MYSQL_CONFIG)
        cursor = conn.cursor()
        
        # Kiểm tra bảng backup_trigger
        cursor.execute("SELECT COUNT(*) FROM backup_trigger")
        trigger_count = cursor.fetchone()[0]
        
        if trigger_count > 0:
            # Tạo file sao lưu
            timestamp = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
            backup_file = os.path.join(BACKUP_DIR, f'{DB_NAME}_backup_{timestamp}.sql')
            
            # Chạy mysqldump
            subprocess.run([
                'mysqldump',
                f'--user={MYSQL_CONFIG["user"]}',
                f'--password={MYSQL_CONFIG["password"]}',
                f'--host={MYSQL_CONFIG["host"]}',
                DB_NAME
            ], stdout=open(backup_file, 'w'), check=True)
            
            # Sao chép file sang OneDrive
            #onedrive_file = os.path.join(ONEDRIVE_DIR, f'{DB_NAME}_backup_{timestamp}.sql')
            #shutil.copy(backup_file, onedrive_file)
            
            # Xóa bản ghi trong backup_trigger
            cursor.execute("DELETE FROM backup_trigger")
            conn.commit()
            
            # Xóa file sao lưu cũ
            cleanup_old_backups()
            
        cursor.close()
        conn.close()
        
    except mysql.connector.Error as e:
        print(f"MySQL Error: {e}")
    except subprocess.CalledProcessError as e:
        print(f"mysqldump Error: {e}")
    except Exception as e:
        print(f"Error: {e}")

def cleanup_old_backups():
    cutoff_date = datetime.datetime.now() - datetime.timedelta(days=RETENTION_DAYS)
    backup_path = Path(BACKUP_DIR)
    
    for file in backup_path.glob(f'{DB_NAME}_backup_*.sql'):
        file_mtime = datetime.datetime.fromtimestamp(file.stat().st_mtime)
        if file_mtime < cutoff_date:
            file.unlink()

if __name__ == "__main__":
    # Đảm bảo thư mục sao lưu tồn tại
    os.makedirs(BACKUP_DIR, exist_ok=True)
    #os.makedirs(ONEDRIVE_DIR, exist_ok=True)
    
    print(f"Starting backup daemon, checking every {CHECK_INTERVAL} seconds...")
    while True:
        check_backup_trigger()
        time.sleep(CHECK_INTERVAL)
