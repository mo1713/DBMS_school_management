# DBMS_school_management

Code gồm 3 phần: Data input ( sử dụng SQLALchemy); model cho các table trong ERD, tạo route chức các function quản lý ( sử dụng flask)

**Data input**

Trạng thái: Done

Sử dụng SQLAIchemy để inout data tuef SQL sang pyhon.

**Model**

Trang thái: ? ( Có lẽ cần chỉnh sửa thêm)

Build model dựa theo các table trong ERD( done), đang suy nghĩ thêm về relationship có cần thêm vào không.

**Route**

Tình trạng: On going

Gồm các phần(draft)

1. Class Management( Lấy danh sách các lớp học; xóa, sửa, thêm lớp học; lấy danh sách học sinh của một lớp qua trung gian Student_Classes; điểm trung bình từng môn của một lớp; danh sách giáo viện bộ môn của lớp)
2. Student Management( Thêm, xóa học sinh; cập nhật thông tin học sinh)
3. Money Management( Lấy danh sách thông tin tiền của tất cả học sinh; học phí dã đóng và còn nợ của học sinh)
4. Grade management( Thêm điểm mới cho học sinh theo kỳ học; tính điểm trug bình của học sinh theo kỳ học)
5. Teacher management ( Lịch dạy của giáo viên, danh sách lớp phụ trách giảng dạy, lương)
