from sqlalchemy import create_engine, MetaData, text
from sqlalchemy.orm import sessionmaker
import pandas as pd
import os
import tempfile
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Retrieve database credentials from environment variables
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")

# Validate environment variables
if not all([DB_USER, DB_PASS, DB_HOST, DB_NAME]):
    raise ValueError("Missing one or more database environment variables")

# Create SQLAlchemy engine and session
engine = create_engine(f"mysql+mysqlconnector://{DB_USER}:{DB_PASS}@{DB_HOST}/{DB_NAME}")
metadata = MetaData()
Session = sessionmaker(autocommit=False, autoflush=False, bind=engine)
session = Session()

class ClassManager:
    # Add a new class
    def add_class(class_name, note):
        try:
            result = session.execute(
                text("CALL AddClass(:class_name, :note)"),
                {"class_name": class_name, "note": note}
            )
            new_id = result.mappings().first()['new_id']
            session.commit()
            return new_id
        except Exception as e:
            session.rollback()
            print(f"Error: {e}")
            return None
        finally:
            result.close()

    # Update a class
    def update_class(class_id, class_name, note):
        try:
            result = session.execute(
                text("CALL UpdateClass(:class_id, :class_name, :note)"),
                {"class_id": class_id, "class_name": class_name, "note": note}
            )
            affected_rows = result.mappings().first()['affected_rows']
            session.commit()
            return affected_rows
        except Exception as e:
            session.rollback()
            print(f"Error: {e}")
            return 0
        finally:
            result.close()

    # Delete a class
    def delete_class(class_id):
        try:
            result = session.execute(
                text("CALL DeleteClass(:class_id)"),
                {"class_id": class_id}
            )
            affected_rows = result.mappings().first()['affected_rows']
            session.commit()
            return affected_rows
        except Exception as e:
            session.rollback()
            print(f"Error: {e}")
            return 0
        finally:
            result.close()

    def get_class_list(search_name=None, limit=10):
        """
        Retrieve a list of classes with homeroom teacher, academic period, student count, and notes.
        
        Args:
            search_name (str, optional): Filter classes by name (partial match).
            limit (int): Number of records to return.
        
        Returns:
            pandas.DataFrame: DataFrame containing class details.
        """
        try:
            result = session.execute(
                text("CALL GetClassList(:search_name, :limit)"),
                {"search_name": search_name, "limit": limit}
            )
            classes = result.mappings().all()
            df = pd.DataFrame(classes)
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing GetClassList: {e}")
            return pd.DataFrame()
        finally:
            result.close()

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
        try:
            result = session.execute(
                text("CALL FindClass(:class_id, :class_name)"),
                {"class_id": class_id, "class_name": class_name}
            )
            classes = result.mappings().all()
            df = pd.DataFrame(classes)
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing FindClass: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def get_class_students(class_id=None, class_name=None):
        """
        Retrieve a list of students for a specific class.
        
        Args:
            class_id (int): The ClassID of the class to fetch students for.
        
        Returns:
            pandas.DataFrame: DataFrame containing student details (StudentID, StudentName, Address, BirthDate, Email).
        """
        try:
            result = session.execute(
                text("CALL GetClassStudents(:class_id, :class_name)"),
                {"class_id": class_id, "class_name": class_name}
            )
            students = result.mappings().all()
            df = pd.DataFrame(students)
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing GetClassStudents: {e}")
            return pd.DataFrame()
        finally:
            result.close()

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
        try:
            result = session.execute(
                text("CALL GetClassSchedule(:class_id, :per_id)"),
                {"class_id": class_id, "per_id": per_id}
            )
            schedules = result.mappings().all()
            df = pd.DataFrame(schedules)
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing GetClassSchedule: {e}")
            return pd.DataFrame()
        finally:
            result.close()

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



