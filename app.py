from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import SQLAlchemyError

# Khởi tạo ứng dụng Flask và cấu hình kết nối database
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:11230571@localhost/school_management1'  # Đường dẫn kết nối MySQL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Tắt tính năng không cần thiết để tối ưu hiệu suất
db = SQLAlchemy(app)  # Khởi tạo SQLAlchemy để làm việc với database

# Định nghĩa các model (bảng) trong database
class Student(db.Model):
    __tablename__ = 'Students'
    StudentID = db.Column(db.Integer, primary_key=True)
    StudentName = db.Column(db.String(255), nullable=False)
    Address = db.Column(db.String(255))
    BirthDate = db.Column(db.Date)
    Email = db.Column(db.String(255))

class Teacher(db.Model):
    __tablename__ = 'Teachers'
    TeacherID = db.Column(db.Integer, primary_key=True)
    TeacherName = db.Column(db.String(255), nullable=False)
    SubjectID = db.Column(db.Integer, db.ForeignKey('Subjects.SubjectID'))
    Email = db.Column(db.String(255))

class Class(db.Model):
    __tablename__ = 'Classes'
    ClassID = db.Column(db.Integer, primary_key=True)
    ClassName = db.Column(db.String(255), nullable=False)

class Subject(db.Model):
    __tablename__ = 'Subjects'
    SubjectID = db.Column(db.Integer, primary_key=True)
    SubjectName = db.Column(db.String(255), nullable=False)

class Grade(db.Model):
    __tablename__ = 'Grades'
    GradeID = db.Column(db.Integer, primary_key=True)
    StudentID = db.Column(db.Integer, db.ForeignKey('Students.StudentID'), nullable=False)
    SubjectID = db.Column(db.Integer, db.ForeignKey('Subjects.SubjectID'), nullable=False)
    Class_perID = db.Column(db.Integer, db.ForeignKey('Class_period.id'), nullable=False)  # Thêm Class_perID để chia điểm theo kỳ
    Score = db.Column(db.Float, nullable=False)
    Weight = db.Column(db.Integer, nullable=False)

class StudentsClasses(db.Model):
    __tablename__ = 'Students_Classes'
    id = db.Column(db.Integer, primary_key=True)
    StudentID = db.Column(db.Integer, db.ForeignKey('Students.StudentID'), nullable=False)
    ClassID = db.Column(db.Integer, db.ForeignKey('Classes.ClassID'), nullable=False)
    Class_perID = db.Column(db.Integer, db.ForeignKey('Class_period.id'), nullable=False)  # Thêm Class_perID để liên kết kỳ

class ClassesTeacher(db.Model):
    __tablename__ = 'Classes_Teacher'
    id = db.Column(db.Integer, primary_key=True)
    Class_perID = db.Column(db.Integer, db.ForeignKey('Class_period.id'), nullable=False)
    TeacherID = db.Column(db.Integer, db.ForeignKey('Teachers.TeacherID'), nullable=False)

class ClassPeriod(db.Model):
    __tablename__ = 'Class_period'
    id = db.Column(db.Integer, primary_key=True)
    ClassID = db.Column(db.Integer, db.ForeignKey('Classes.ClassID'), nullable=False)
    Period = db.Column(db.Integer, nullable=False)  # Kỳ học
    Homeroom_TeacherID = db.Column(db.Integer, db.ForeignKey('Teachers.TeacherID'))

class Schedule(db.Model):
    __tablename__ = 'Schedules'
    id = db.Column(db.Integer, primary_key=True)
    Class_perID = db.Column(db.Integer, db.ForeignKey('Class_period.id'), nullable=False)
    TeacherID = db.Column(db.Integer, db.ForeignKey('Teachers.TeacherID'), nullable=False)
    TimeSlotID = db.Column(db.Integer, db.ForeignKey('TimeSlots.id'), nullable=False)
    WeekNumber = db.Column(db.Integer, nullable=False)

class Money(db.Model):
    __tablename__ = 'Money'
    id = db.Column(db.Integer, primary_key=True)
    StudentID = db.Column(db.Integer, db.ForeignKey('Students.StudentID'), nullable=False)
    Paid = db.Column(db.Integer, nullable=False)  # Số tiền đã trả
    Debt = db.Column(db.Integer, nullable=False)  # Nợ

class TimeSlot(db.Model):
    __tablename__ = 'TimeSlots'
    id = db.Column(db.Integer, primary_key=True)
    DayOfWeek = db.Column(db.String(10), nullable=False)
    StartTime = db.Column(db.Time, nullable=False)
    EndTime = db.Column(db.Time, nullable=False)

# Route mặc định để kiểm tra backend
@app.route('/')
def home():
    return jsonify({"message": "Backend is running, database connected successfully!"})  # Trả về thông báo backend hoạt động

# Các route quản lý học sinh (Student Management)
@app.route('/students', methods=['GET'])
def get_students():
    # Lấy danh sách tất cả học sinh
    try:
        students = Student.query.all()
        result = [{"StudentID": s.StudentID, "StudentName": s.StudentName, "Email": s.Email} for s in students]
        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500

@app.route('/students', methods=['POST'])
def add_student():
    # Thêm một học sinh mới vào bảng Students
    try:
        data = request.get_json()
        new_student = Student(
            StudentName=data['StudentName'],
            Address=data.get('Address'),
            BirthDate=data.get('BirthDate'),
            Email=data.get('Email')
        )
        db.session.add(new_student)
        db.session.commit()
        return jsonify({"message": "Student added successfully", "StudentID": new_student.StudentID}), 201
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/students/<int:student_id>', methods=['PUT'])
def update_student(student_id):
    # Cập nhật thông tin học sinh
    try:
        data = request.get_json()
        student = Student.query.get(student_id)
        if not student:
            return jsonify({"error": "Student not found"}), 404
        student.StudentName = data.get('StudentName', student.StudentName)
        student.Address = data.get('Address', student.Address)
        student.BirthDate = data.get('BirthDate', student.BirthDate)
        student.Email = data.get('Email', student.Email)
        db.session.commit()
        return jsonify({"message": "Student updated successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/students/<int:student_id>', methods=['DELETE'])
def delete_student(student_id):
    # Xóa một học sinh khỏi bảng Students
    try:
        student = Student.query.get(student_id)
        if not student:
            return jsonify({"error": "Student not found"}), 404
        db.session.delete(student)
        db.session.commit()
        return jsonify({"message": "Student deleted successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

# Các route quản lý tiền (Money Management)
@app.route('/money', methods=['GET'])
def get_money():
    # Lấy danh sách thông tin tiền của tất cả học sinh
    try:
        money_records = Money.query.all()
        result = [{"id": m.id, "StudentID": m.StudentID, "Paid": m.Paid, "Debt": m.Debt} for m in money_records]
        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500

@app.route('/money', methods=['POST'])
def add_money():
    # Thêm thông tin tiền cho học sinh
    try:
        data = request.get_json()
        new_money = Money(
            StudentID=data['StudentID'],
            Paid=data['Paid'],
            Debt=data['Debt']
        )
        db.session.add(new_money)
        db.session.commit()
        return jsonify({"message": "Money record added successfully", "id": new_money.id}), 201
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/money/<int:money_id>', methods=['PUT'])
def update_money(money_id):
    # Cập nhật thông tin tiền của học sinh
    try:
        data = request.get_json()
        money = Money.query.get(money_id)
        if not money:
            return jsonify({"error": "Money record not found"}), 404
        money.Paid = data.get('Paid', money.Paid)
        money.Debt = data.get('Debt', money.Debt)
        db.session.commit()
        return jsonify({"message": "Money updated successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/money/<int:money_id>', methods=['DELETE'])
def delete_money(money_id):
    # Xóa thông tin tiền của học sinh
    try:
        money = Money.query.get(money_id)
        if not money:
            return jsonify({"error": "Money record not found"}), 404
        db.session.delete(money)
        db.session.commit()
        return jsonify({"message": "Money deleted successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

# Học phí đã đóng và còn nợ của học sinh
@app.route('/students/finance-summary', methods=['GET'])
def finance_summary():
    try:
        students = Student.query.all()
        result = []

        for student in students:
            payments = Money.query.filter_by(StudentID=student.StudentID).all()
            total_paid = sum(p.Paid for p in payments)
            total_debt = sum(p.Debt for p in payments)
            result.append({
                "StudentID": student.StudentID,
                "StudentName": student.StudentName,
                "TotalPaid": total_paid,
                "TotalDebt": total_debt
            })

        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500


# Các route quản lý thời gian biểu (TimeSlots Management)
@app.route('/timeslots', methods=['GET'])
def get_timeslots():
    # Lấy danh sách tất cả thời gian biểu
    try:
        timeslots = TimeSlot.query.all()
        result = [{"id": ts.id, "DayOfWeek": ts.DayOfWeek, "StartTime": ts.StartTime, "EndTime": ts.EndTime} for ts in timeslots]
        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500

@app.route('/timeslots', methods=['POST'])
def add_timeslot():
    # Thêm một thời gian biểu mới
    try:
        data = request.get_json()
        new_timeslot = TimeSlot(
            DayOfWeek=data['DayOfWeek'],
            StartTime=data['StartTime'],
            EndTime=data['EndTime']
        )
        db.session.add(new_timeslot)
        db.session.commit()
        return jsonify({"message": "Timeslot added successfully", "id": new_timeslot.id}), 201
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/timeslots/<int:timeslot_id>', methods=['PUT'])
def update_timeslot(timeslot_id):
    # Cập nhật thông tin thời gian biểu
    try:
        data = request.get_json()
        timeslot = TimeSlot.query.get(timeslot_id)
        if not timeslot:
            return jsonify({"error": "Timeslot not found"}), 404
        timeslot.DayOfWeek = data.get('DayOfWeek', timeslot.DayOfWeek)
        timeslot.StartTime = data.get('StartTime', timeslot.StartTime)
        timeslot.EndTime = data.get('EndTime', timeslot.EndTime)
        db.session.commit()
        return jsonify({"message": "Timeslot updated successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/timeslots/<int:timeslot_id>', methods=['DELETE'])
def delete_timeslot(timeslot_id):
    # Xóa một thời gian biểu
    try:
        timeslot = TimeSlot.query.get(timeslot_id)
        if not timeslot:
            return jsonify({"error": "Timeslot not found"}), 404
        db.session.delete(timeslot)
        db.session.commit()
        return jsonify({"message": "Timeslot deleted successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

# Các route quản lý lớp học (Class Management) theo kỳ
@app.route('/classes/<int:class_id>/periods', methods=['GET'])
def get_classes():
    # Lấy danh sách tất cả lớp học từ bảng Classes
    try:
        classes = Class.query.all()
        result = [{"ClassID": c.ClassID, "ClassName": c.ClassName} for c in classes]
        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500
    
def get_class_periods(class_id):
    # Lấy danh sách kỳ học của một lớp cụ thể
    try:
        periods = ClassPeriod.query.filter_by(ClassID=class_id).all()
        result = [{"id": p.id, "Period": p.Period, "Homeroom_TeacherID": p.Homeroom_TeacherID} for p in periods]
        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500

@app.route('/classes', methods=['POST'])
def add_class():
    # Thêm một lớp học mới vào bảng Classes
    try:
        data = request.get_json()
        new_class = Class(ClassName=data['ClassName'])
        db.session.add(new_class)
        db.session.commit()
        return jsonify({"message": "Class added successfully", "ClassID": new_class.ClassID}), 201
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500
    
@app.route('/classes/<int:class_id>/periods', methods=['POST'])
def add_class_period(class_id):
    # Thêm một kỳ học mới cho lớp
    try:
        data = request.get_json()
        new_period = ClassPeriod(ClassID=class_id, Period=data['Period'], Homeroom_TeacherID=data.get('Homeroom_TeacherID'))
        db.session.add(new_period)
        db.session.commit()
        return jsonify({"message": "Period added successfully", "id": new_period.id}), 201
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/classes/<int:class_id>/periods/<int:per_id>', methods=['PUT'])
def update_class_period(class_id, per_id):
    # Cập nhật thông tin kỳ học của lớp
    try:
        data = request.get_json()
        period = ClassPeriod.query.get(per_id)
        if not period or period.ClassID != class_id:
            return jsonify({"error": "Period not found"}), 404
        period.Period = data.get('Period', period.Period)
        period.Homeroom_TeacherID = data.get('Homeroom_TeacherID', period.Homeroom_TeacherID)
        db.session.commit()
        return jsonify({"message": "Period updated successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500
    
@app.route('/classes/<int:class_id>/students', methods=['GET'])
def get_class_students(class_id):
    # Lấy danh sách học sinh trong một lớp theo kỳ học cụ thể (yêu cầu Class_perID)
    try:
        per_id = request.args.get('per_id')  # Lấy kỳ học từ query parameter
        if per_id:
            students = Student.query.join(StudentsClasses).filter(StudentsClasses.ClassID == class_id, StudentsClasses.Class_perID == per_id).all()
        else:
            students = Student.query.join(StudentsClasses).filter(StudentsClasses.ClassID == class_id).all()
        result = [{"StudentID": s.StudentID, "StudentName": s.StudentName, "Email": s.Email} for s in students]
        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500
    
# Các route quản lý điểm (Grade Management) theo kỳ
@app.route('/grades', methods=['POST'])
def add_grade():
    # Thêm điểm mới cho học sinh theo kỳ học
    try:
        data = request.get_json()
        new_grade = Grade(
            StudentID=data['StudentID'],
            SubjectID=data['SubjectID'],
            Class_perID=data['Class_perID'],  # Thêm Class_perID để xác định kỳ
            Score=data['Score'],
            Weight=data['Weight']
        )
        db.session.add(new_grade)
        db.session.commit()
        return jsonify({"message": "Grade added successfully", "GradeID": new_grade.GradeID}), 201
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500
    
@app.route('/grades/<int:grade_id>', methods=['PUT'])
def update_grade(grade_id):
    # Cập nhật điểm của một học sinh theo kỳ
    try:
        data = request.get_json()
        grade = Grade.query.get(grade_id)
        if not grade:
            return jsonify({"error": "Grade not found"}), 404
        grade.Score = data.get('Score', grade.Score)
        grade.Weight = data.get('Weight', grade.Weight)
        db.session.commit()
        return jsonify({"message": "Grade updated successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/grades/<int:grade_id>', methods=['DELETE'])
def delete_grade(grade_id):
    # Xóa một bản ghi điểm theo kỳ
    try:
        grade = Grade.query.get(grade_id)
        if not grade:
            return jsonify({"error": "Grade not found"}), 404
        db.session.delete(grade)
        db.session.commit()
        return jsonify({"message": "Grade deleted successfully"}), 200
    except SQLAlchemyError as e:
        db.session.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/students/<int:student_id>/grades', methods=['GET'])
def get_student_grades(student_id):
    # Lấy danh sách điểm của một học sinh theo kỳ học
    try:
        per_id = request.args.get('per_id')  # Lấy kỳ học từ query parameter
        if per_id:
            grades = Grade.query.filter_by(StudentID=student_id, Class_perID=per_id).all()
        else:
            grades = Grade.query.filter_by(StudentID=student_id).all()
        result = [{"GradeID": g.GradeID, "SubjectID": g.SubjectID, "Class_perID": g.Class_perID, "Score": g.Score, "Weight": g.Weight} for g in grades]
        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500

@app.route('/students/<int:student_id>/average-score', methods=['GET'])
def get_average_score(student_id):
    #Tính điểm trung bình của các học sinh theo kì học
    try:
        class_per_id = request.args.get('class_per_id')
        query = Grade.query.filter_by(StudentID=student_id)
        if class_per_id:
            query = query.filter_by(Class_perID=class_per_id)
        grades = query.all()

        if not grades:
            return jsonify({"message": "No grades found for the student."}), 404

        total_score = sum(g.Score * g.Weight for g in grades)
        total_weight = sum(g.Weight for g in grades)
        average = total_score / total_weight if total_weight != 0 else 0

        return jsonify({
            "StudentID": student_id,
            "AverageScore": round(average, 2),
            "ClassPeriodID": class_per_id
        })
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500


# Các route xử lý lịch học và phân công giáo viên theo kỳ
@app.route('/classes/<int:class_id>/schedules', methods=['GET'])
def get_class_schedules(class_id):
    # Lấy danh sách lịch học của một lớp theo kỳ
    try:
        per_id = request.args.get('per_id')  # Lấy kỳ học từ query parameter
        if per_id:
            schedules = Schedule.query.filter_by(Class_perID=per_id).all()
        else:
            class_periods = ClassPeriod.query.filter_by(ClassID=class_id).all()
            class_per_ids = [cp.id for cp in class_periods]
            schedules = Schedule.query.filter(Schedule.Class_perID.in_(class_per_ids)).all()
        result = [{"id": s.id, "Class_perID": s.Class_perID, "TeacherID": s.TeacherID, "WeekNumber": s.WeekNumber} for s in schedules]
        return jsonify(result)
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500


# Chạy ứng dụng Flask
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)  # Chạy server trên cổng 5000 với chế độ debug


