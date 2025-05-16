import mysql.connector
from mysql.connector import Error
import pandas as pd
import os
import tempfile
from db import Connect

class TeacherManager:
    @staticmethod
    def add_teacher(name, subject_id, email):
        conn = Connect.connect_db()
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

    @staticmethod
    def update_teacher(teacher_id, name, subject_id, email):
        conn = Connect.connect_db()
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
    
    @staticmethod
    def delete_teacher(teacher_id):
        conn = Connect.connect_db()
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

    @staticmethod
    def find_teacher(teacher_id=None, teacher_name=None):
        conn = Connect.connect_db()
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
    @staticmethod
    def get_all_teachers():
        conn = Connect.connect_db()
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


    @staticmethod
    def get_teacher_schedule(teacher_id, term, year):
        conn = Connect.connect_db()
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

    @staticmethod
    def export__to_excel(df, filename="teacher_export.xlsx"):
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
 
