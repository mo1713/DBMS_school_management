
import pymysql
import pandas as pd
import os
import tempfile
from db import Connect

class MoneyManager:
    @staticmethod
    def get_fee_summary_by_period() -> pd.DataFrame:
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('sp_fee_summary_by_period')
            for result in cursor.stored_results():
                data = result.fetchall()
            return float(data["TotalDebt"].iloc[0]), float(data["TotalPaid"].iloc[0]), float(data["TotalValue"].iloc[0])
        except Exception as e:
            print(f"Error in get_fee_summary_by_period: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def get_fee_summary_by_student() -> pd.DataFrame:
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('sp_fee_summary_by_student')
            for result in cursor.stored_results():
                data = result.fetchall()
            return pd.DataFrame(data)
        except Exception as e:
            print(f"Error in get_fee_summary_by_student: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def get_fee_detail_by_student(student_id: int) -> pd.DataFrame:
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('sp_fee_detail_by_student', [student_id])
            for result in cursor.stored_results():
                data = result.fetchall()
            return pd.DataFrame(data)
        except Exception as e:
            print(f"Error in get_fee_detail_by_student: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def get_fee_by_class_term_year(term: int, year: int) -> pd.DataFrame:
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('sp_fee_by_class_term_year', [term, year])
            for result in cursor.stored_results():
                data = result.fetchall()
            return pd.DataFrame(data)
        except Exception as e:
            print(f"Error in get_fee_by_class_term_year: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def get_fee_total_by_class(term: int, year: int) -> pd.DataFrame:
        conn = Connect.connect_db()
        if not conn:
            return pd.DataFrame()
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.callproc('sp_fee_total_by_class', [term, year])
            for result in cursor.stored_results():
                data = result.fetchall()
            return pd.DataFrame(data)
        except Exception as e:
            print(f"Error in get_fee_total_by_class: {e}")
            return pd.DataFrame()
        finally:
            cursor.close()
            conn.close()

    @staticmethod
    def export_by_class_to_excel(df: pd.DataFrame, filename="money_by_class.xlsx"):
        try:
            if not os.path.isabs(filename):
                temp_dir = tempfile.gettempdir()
                file_path = os.path.join(temp_dir, filename)
            else:
                file_path = filename

            with pd.ExcelWriter(file_path, engine='openpyxl') as writer:
                for class_name, group_df in df.groupby("ClassName"):
                    safe_name = class_name[:31].replace('/', '-')
                    group_df.to_excel(writer, sheet_name=safe_name, index=False)

            return file_path
        except Exception as e:
            print(f"Error exporting by class to Excel: {e}")
            return None
