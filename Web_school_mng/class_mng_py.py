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

class ClassManager:
    # Add a new class
    def add_class(class_name, note):
        try:
            conn = connect_db()
            cursor = conn.cursor()
            cursor.callproc('AddClass', [class_name, note])
            for result in cursor.stored_results():
                new_id = result.fetchone()[0]
            conn.commit()
            return new_id
        except Error as e:
            print(f"Error: {e}")
            return None
        finally:
            cursor.close()
            conn.close()

    # Update a class
    def update_class(class_id, class_name, note):
        try:
            conn = connect_db()
            cursor = conn.cursor()
            cursor.callproc('UpdateClass', [class_id, class_name, note])
            for result in cursor.stored_results():
                affected_rows = result.fetchone()[0]
            conn.commit()
            return affected_rows
        except Error as e:
            print(f"Error: {e}")
            return 0
        finally:
            cursor.close()
            conn.close()

    # Delete a class
    def delete_class(class_id):
        try:
            conn = connect_db()
            cursor = conn.cursor()
            cursor.callproc('DeleteClass', [class_id])
            for result in cursor.stored_results():
                affected_rows = result.fetchone()[0]
            conn.commit()
            return affected_rows
        except Error as e:
            print(f"Error: {e}")
            return 0
        finally:
            cursor.close()
            conn.close()


    def get_class_list(search_name=None, limit=10):
        """
        Retrieve a list of classes with homeroom teacher, academic period, student count, and notes.
        
        Args:
            search_name (str, optional): Filter classes by name (partial match).
            limit (int): Number of records to return.
        
        Returns:
            pandas.DataFrame: DataFrame containing class details.
        """
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('GetClassList', [search_name, limit])
            classes = []
            for result in cursor.stored_results():
                classes = result.fetchall()
            # Convert list of dictionaries to DataFrame
            df = pd.DataFrame(classes)
            return df
        except Error as e:
            print(f"Error executing GetClassList: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()


    def find_class(class_id=None, class_name=None):
        """
        Find classes by ClassID or ClassName.
        
        Args:
            class_id (int, optional): Exact ClassID to search for.
            class_name (str, optional): Partial ClassName to search for.
        
        Returns:
            pandas.DataFrame: DataFrame containing matching class details (ClassID, ClassName, Notes, 
                            HomeroomTeacher, Term, Year, StudentCount).
        """
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            # Ensure class_id is None if not provided or invalid
            class_id = class_id if class_id is not None else None
            cursor.callproc('FindClass', [class_id, class_name])
            classes = []
            for result in cursor.stored_results():
                classes = result.fetchall()
            df = pd.DataFrame(classes)
            return df
        except Error as e:
            print(f"Error executing FindClass: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    def get_class_students(class_id=None, class_name=None):
        """
        Retrieve a list of students for a specific class.
        
        Args:
            class_id (int): The ClassID of the class to fetch students for.
        
        Returns:
            pandas.DataFrame: DataFrame containing student details (StudentID, StudentName, Address, BirthDate, Email).
        """
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('GetClassStudents', [class_id, class_name])
            students = []
            for result in cursor.stored_results():
                students = result.fetchall()
            df = pd.DataFrame(students)
            return df
        except Error as e:
            print(f"Error executing GetClassStudents: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()


    def get_class_schedule(class_id, per_id):
        """
        Lấy lịch học của một lớp dựa trên ClassID và PerId bằng stored procedure GetClassSchedule.
        
        Parameters:
        - class_id: ID của lớp.
        - per_id (int): ID của kỳ học.
        
        Returns:
        - pandas.DataFrame: DataFrame chứa lịch học với các cột ClassName, TeacherName, SubjectName, 
                            DayOfWeek, StartTime, EndTime, WeekNumber.
        """
        conn = connect_db()
        if not conn:
            return pd.DataFrame()
        
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('GetClassSchedule', [class_id, per_id])
            schedules = []
            for result in cursor.stored_results():
                schedules = result.fetchall()
            # Convert list of dictionaries to DataFrame
            df = pd.DataFrame(schedules)
            return df
        except Error as e:
            print(f"Error executing GetClassSchedule: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    def export_to_excel(df, filename="classes_export.xlsx"):
        """
        Export a DataFrame to an Excel file.
        
        Args:
            df (pandas.DataFrame): DataFrame to export.
            filename (str): Name of the output Excel file (default: 'classes_export.xlsx').
        
        Returns:
            str: Path to the generated Excel file, or None if failed.
        """
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

