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

class MoneyManager:
    def get_fee_summary_by_period() -> pd.DataFrame:
        try:
            result = session.execute(text("CALL sp_fee_summary_by_period()"))
            df = pd.DataFrame(result.mappings().all())
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing sp_fee_summary_by_period: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def get_fee_summary_by_student() -> pd.DataFrame:
        try:
            result = session.execute(text("CALL sp_fee_summary_by_student()"))
            df = pd.DataFrame(result.mappings().all())
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing sp_fee_summary_by_student: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def get_fee_detail_by_student(student_id: int) -> pd.DataFrame:
        try:
            result = session.execute(
                text("CALL sp_fee_detail_by_student(:student_id)"),
                {"student_id": student_id}
            )
            df = pd.DataFrame(result.mappings().all())
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing sp_fee_detail_by_student: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def get_fee_by_class_term_year(self, term: int, year: int) -> pd.DataFrame:
        try:
            result = session.execute(
                text("CALL sp_fee_by_class_term_year(:term, :year)"),
                {"term": term, "year": year}
            )
            df = pd.DataFrame(result.mappings().all())
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing sp_fee_by_class_term_year: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def get_fee_total_by_class(term: int, year: int) -> pd.DataFrame:
        try:
            result = session.execute(
                text("CALL sp_fee_total_by_class(:term, :year)"),
                {"term": term, "year": year}
            )
            df = pd.DataFrame(result.mappings().all())
            session.commit()
            return df
        except Exception as e:
            session.rollback()
            print(f"Error executing sp_fee_total_by_class: {e}")
            return pd.DataFrame()
        finally:
            result.close()

    def export_by_class_to_excel(df: pd.DataFrame, filename="money_by_class.xlsx"):
        try:
            # Nếu không phải đường dẫn tuyệt đối → dùng thư mục tạm
            if not os.path.isabs(filename):
                temp_dir = tempfile.gettempdir()
                file_path = os.path.join(temp_dir, filename)
            else:
                file_path = filename

            # Ghi từng lớp vào 1 sheet
            with pd.ExcelWriter(file_path, engine='openpyxl') as writer:
                for class_name, group_df in df.groupby("ClassName"):
                    # Tên sheet tối đa 31 ký tự
                    safe_name = class_name[:31].replace('/', '-')
                    group_df.to_excel(writer, sheet_name=safe_name, index=False)

            return file_path
        except Exception as e:
            print(f"Error exporting by class to Excel: {e}")
            return None

