import mysql.connector
from mysql.connector import Error
import pandas as pd
import os
import tempfile

def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="11230571",
        database="school_management1"
    )

class TeacherManager:

    def add_teacher(name, subject_id, email):
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('AddTeacher', [name, subject_id, email])
            for result in cursor.stored_results():
                data = result.fetchall()
            conn.commit()
            return pd.DataFrame(data)
        except Error as e:
            print(f"Error executing AddTeacher: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    def update_teacher(teacher_id, name, subject_id, email):
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('UpdateTeacher', [teacher_id, name, subject_id, email])
            for result in cursor.stored_results():
                data = result.fetchall()
            conn.commit()
            return pd.DataFrame(data)
        except Error as e:
            print(f"Error executing UpdateTeacher: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()
    
    def delete_teacher(teacher_id):
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('DeleteTeacher', [teacher_id])
            for result in cursor.stored_results():
                data = result.fetchall()
            conn.commit()
            return pd.DataFrame(data)
        except Error as e:
            print(f"Error executing DeleteTeacher: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    def find_teacher(teacher_id=None, teacher_name=None):
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('FindTeacher', [teacher_id, teacher_name])
            for result in cursor.stored_results():
                data = result.fetchall()
            return pd.DataFrame(data)
        except Error as e:
            print(f"Error executing FindTeacher: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    def get_all_teachers():
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('GetAllTeachers')
            teacher = []
            for result in cursor.stored_results():
                teacher = result.fetchall()
            df = pd.DataFrame(teacher)
            return df
        except Error as e:
            print(f"Error executing GetAllTeachers: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()


    
    def get_teacher_schedule(teacher_id, term, year):
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('GetTeacherSchedule', [teacher_id, term, year])
            teachersch = []
            for result in cursor.stored_results():
                teachersch = result.fetchall()
            df = pd.DataFrame(teachersch)
            return df
        except Error as e:
            print(f"Error executing GetTeacherSchedule: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    def export_to_excel(df, filename="teacher_export.xlsx"):
        try:
            # Create a temporary file path if filename is not absolute
            if not os.path.isabs(filename):
                temp_dir = tempfile.gettempdir()
                file_path = os.path.join(temp_dir, filename)
            else:
                file_path = filename
            # Export DataFrame to Excel
            df.to_excel(file_path, index=False, engine='openpyxl')
            return file_path
        except Exception as e:
            print(f"Error exporting to Excel: {e}")
            return None
 
