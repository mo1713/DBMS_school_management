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

class StudentManager:
    def add_student_with_class(name, address, birthdate, email, note, class_per_id):
        try:
            result = session.execute(
                text("CALL AddStudentWithClass(:name, :address, :birthdate, :email, :note, :class_per_id)"),
                {"name": name, "address": address, "birthdate": birthdate, "email": email, "note": note, "class_per_id": class_per_id}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing AddStudentWithClass: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def delete_student(student_id):
        try:
            result = session.execute(
                text("CALL DeleteStudent(:student_id)"),
                {"student_id": student_id}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing DeleteStudent: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def update_student(student_id, name, address, birthdate, email, note):
        try:
            result = session.execute(
                text("CALL UpdateStudent(:student_id, :name, :address, :birthdate, :email, :note)"),
                {"student_id": student_id, "name": name, "address": address, "birthdate": birthdate, "email": email, "note": note}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing UpdateStudent: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def find_student_detail(student_id=None, student_name=None):
        try:
            result = session.execute(
                text("CALL FindStudentDetail(:student_id, :student_name)"),
                {"student_id": student_id, "student_name": student_name}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing FindStudentDetail: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def find_students_by_note(note_keyword=None):
        try:
            result = session.execute(
                text("CALL FindStudentsByNote(:note_keyword)"),
                {"note_keyword": note_keyword}
            )
            data = result.mappings().all()
            session.commit()
            return pd.DataFrame(data)
        except Exception as e:
            session.rollback()
            print(f"Error executing FindStudentsByNote: {e}")
            return pd.DataFrame()
        finally:
            result.close()

