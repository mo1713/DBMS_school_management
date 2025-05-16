-- Money management
USE school_management1;

-- Tổng thu và tổng nợ theo từng kỳ học
DELIMITER $$
CREATE PROCEDURE sp_fee_summary_by_period()
BEGIN
    SELECT 
        ap.Term,
        ap.Year,
        SUM(m.Value) AS TotalValue,
        SUM(m.Paid) AS TotalPaid,
        SUM(m.Debt) AS TotalDebt
    FROM Money m
    JOIN Academic_period ap ON m.PerID = ap.PerId
    GROUP BY ap.Term, ap.Year
    ORDER BY ap.Year, ap.Term;
END$$
DELIMITER ;

-- Tổng thu và nợ của mỗi học sinh 
DELIMITER $$
CREATE PROCEDURE sp_total_by_student()
BEGIN
    SELECT 
        s.id AS StudentID,
        s.Name AS StudentName,
        SUM(m.Value) AS TotalFee,
        SUM(m.Paid) AS TotalPaid,
        SUM(m.Debt) AS TotalDebt
    FROM money m
    JOIN students s ON m.StudentID = s.id
    GROUP BY m.StudentID
    ORDER BY s.Name;
END$$
DELIMITER ;

-- Chi tiết học phí của một học sinh theo từng kỳ học 
DELIMITER $$
CREATE PROCEDURE sp_fee_detail_by_student(IN p_StudentID INT)
BEGIN
    SELECT 
        ap.Term,
        ap.Year,
        m.Value,
        m.Paid,
        m.Debt
    FROM Money m
    JOIN Academic_period ap ON m.PerID = ap.PerId
    WHERE m.StudentID = p_StudentID
    ORDER BY ap.Year, ap.Term;
END$$
DELIMITER ;

-- Bảng tiền của lớp theo kỳ học 
DELIMITER $$
CREATE PROCEDURE sp_fee_by_class_term_year(IN p_Term INT, IN p_Year INT)
BEGIN
    SELECT 
        c.ClassName,
        s.StudentID,
        s.StudentName,
        ap.Term,
        ap.Year,
        m.Value AS FeeValue,
        m.Paid AS FeePaid,
        m.Debt AS FeeDebt
    FROM Money m
    JOIN Students s ON m.StudentID = s.StudentID
    JOIN Academic_period ap ON m.PerID = ap.PerId
    JOIN Students_Classes sc ON s.StudentID = sc.StudentID
    JOIN Class_period cp ON sc.Class_perID = cp.id
    JOIN Classes c ON cp.ClassID = c.ClassID
    WHERE cp.PerID = m.PerID
      AND ap.Term = p_Term
      AND ap.Year = p_Year
    ORDER BY c.ClassName, s.StudentName;
END$$
DELIMITER ;

-- Tổng kết học phí theo lớp
DELIMITER $$
CREATE PROCEDURE sp_fee_total_by_class(IN p_Term INT, IN p_Year INT)
BEGIN
    SELECT 
        c.ClassName,
        SUM(m.Value) AS TotalValue,
        SUM(m.Paid) AS TotalPaid,
        SUM(m.Debt) AS TotalDebt
    FROM Money m
    JOIN Students s ON m.StudentID = s.StudentID
    JOIN Academic_period ap ON m.PerID = ap.PerId
    JOIN Students_Classes sc ON s.StudentID = sc.StudentID
    JOIN Class_period cp ON sc.Class_perID = cp.id
    JOIN Classes c ON cp.ClassID = c.ClassID
    WHERE cp.PerID = m.PerID
      AND ap.Term = p_Term
      AND ap.Year = p_Year
    GROUP BY c.ClassName
    ORDER BY c.ClassName;
END$$
DELIMITER ;





