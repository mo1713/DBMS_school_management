from Management1 import Manager

# Thêm điểm mới cho SubjectID=10, StudentID=101, Score=9.0, Weight=3, Term=1, Year=2023
df = Manager.add_grade(subject_id=1, student_id=1, score=9.0, weight=3, term=1, year=2024)
print(df)  # In DataFrame với cột AffectedRows (1 nếu thành công, 0 nếu không tìm thấy PerId)

