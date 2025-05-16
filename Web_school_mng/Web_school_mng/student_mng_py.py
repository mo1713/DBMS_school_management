import mysql.connector
from mysql.connector import Error
import pandas as pd
import os
import tempfile
from db import Connect

class StudentManager:
    @staticmethod
    def add_student_with_class(name, address, birthdate, email, note, class_per_id):
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('AddStudentWithClass', [name, address, birthdate, email, note, class_per_id])
            for result in cursor.stored_results():
                data = result.fetchall()
            conn.commit()
            return pd.DataFrame(data)
        except Error as e:
            print(f"Error executing AddStudentWithClass: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def delete_student(student_id):
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('DeleteStudent', [student_id])
            for result in cursor.stored_results():
                data = result.fetchall()
            conn.commit()
            return pd.DataFrame(data)
        except Error as e:
            print(f"Error executing DeleteStudent: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def update_student(student_id, name, address, birthdate, email, note):
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('UpdateStudent', [student_id, name, address, birthdate, email, note])
            for result in cursor.stored_results():
                data = result.fetchall()
            conn.commit()
            return pd.DataFrame(data)
        except Error as e:
            print(f"Error executing UpdateStudent: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def find_student_detail(student_id=None, student_name=None):
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('FindStudentDetail', [student_id, student_name])
            for result in cursor.stored_results():
                data = result.fetchall()
            return pd.DataFrame(data)
        except Error as e:
            print(f"Error executing FindStudentDetail: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def find_students_by_note(note_keyword=None):
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()

        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('FindStudentsByNote', [note_keyword])
            warning= []
            for result in cursor.stored_results():
                warning = result.fetchall()
            return pd.DataFrame(warning)
        except Error as e:
            print(f"Error executing FindStudentsByNote: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

