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

class TeacherManager:
    def add_teacher(name, subject_id, email):
        try:
            result = session.execute(
                text("CALL AddTeacher(:name, :subject_id, :email)"),
                {"name": name, "subject_id": subject_id, "email": email}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing AddTeacher: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def update_teacher(teacher_id, name, subject_id, email):
        try:
            result = session.execute(
                text("CALL UpdateTeacher(:teacher_id, :name, :subject_id, :email)"),
                {"teacher_id": teacher_id, "name": name, "subject_id": subject_id, "email": email}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing UpdateTeacher: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def delete_teacher(teacher_id):
        try:
            result = session.execute(
                text("CALL DeleteTeacher(:teacher_id)"),
                {"teacher_id": teacher_id}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing DeleteTeacher: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def find_teacher(teacher_id=None, teacher_name=None):
        try:
            result = session.execute(
                text("CALL FindTeacher(:teacher_id, :teacher_name)"),
                {"teacher_id": teacher_id, "teacher_name": teacher_name}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing FindTeacher: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def get_all_teachers():
        try:
            result = session.execute(text("CALL GetAllTeachers()"))
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing GetAllTeachers: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def get_teacher_schedule(teacher_id, term, year):
        try:
            result = session.execute(
                text("CALL GetTeacherSchedule(:teacher_id, :term, :year)"),
                {"teacher_id": teacher_id, "term": term, "year": year}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing GetTeacherSchedule: {e}")
            return pd.DataFrame()
        finally:
            result.close()

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

