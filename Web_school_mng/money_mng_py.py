import pymysql
import pandas as pd
import os
import tempfile

def get_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='11230571',
        database='school_management1'
    )

class MoneyManager:
    def get_fee_summary_by_period() -> pd.DataFrame:
        conn = get_connection()
        df = pd.read_sql("CALL sp_fee_summary_by_period()", conn)
        conn.close()
        return df

    def get_fee_summary_by_student() -> pd.DataFrame:
        conn = get_connection()
        df = pd.read_sql("CALL sp_fee_summary_by_student()", conn)
        conn.close()
        return df

    def get_fee_detail_by_student(student_id: int) -> pd.DataFrame:
        conn = get_connection()
        query = f"CALL sp_fee_detail_by_student({student_id})"
        df = pd.read_sql(query, conn)
        conn.close()
        return df


    def get_fee_by_class_term_year(term: int, year: int) -> pd.DataFrame:
        conn = get_connection()
        query = f"CALL sp_fee_by_class_term_year({term}, {year})"
        df = pd.read_sql(query, conn)
        conn.close()
        return df

    def get_fee_total_by_class(term: int, year: int) -> pd.DataFrame:
        conn = get_connection()
        query = f"CALL sp_fee_total_by_class({term}, {year})"
        df = pd.read_sql(query, conn)
        conn.close()
        return df

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

