-- DROP DATABASE IF EXISTS school_management1;
-- CREATE DATABASE school_management1;
USE school_management1;

CREATE TABLE `Academic_period`(
    `PerId` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Term` INT NOT NULL,
    `Year` INT NOT NULL
);

CREATE TABLE `Students`(
    `StudentID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `StudentName` VARCHAR(100) NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    `BirthDate` DATE NOT NULL,
    `Email` VARCHAR(255) NOT NULL
);

CREATE TABLE `Classes`(
    `ClassID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `ClassName` VARCHAR(255) NOT NULL
);

CREATE TABLE `Subjects`(
    `SubjectID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `SubjectName` VARCHAR(255) NOT NULL
);

CREATE TABLE `Teachers`(
    `TeacherID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `TeacherName` VARCHAR(255) NOT NULL,
    `SubjectID` INT NOT NULL,
    `Email` VARCHAR(255) NOT NULL,
    CONSTRAINT `teachers_subjectid_foreign` FOREIGN KEY(`SubjectID`) REFERENCES `Subjects`(`SubjectID`)
);

CREATE TABLE `Class_period`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `ClassID` INT NOT NULL,
    `PerId` INT NOT NULL,
    `Homeroom_TeacherID` INT NOT NULL,
    CONSTRAINT `class_period_classid_foreign` FOREIGN KEY(`ClassID`) REFERENCES `Classes`(`ClassID`),
    CONSTRAINT `class_period_perid_foreign` FOREIGN KEY(`PerId`) REFERENCES `Academic_period`(`PerId`),
    CONSTRAINT `class_period_homeroom_teacherid_foreign` FOREIGN KEY(`Homeroom_TeacherID`) REFERENCES `Teachers`(`TeacherID`)
);


CREATE TABLE `Grades`(
    `GradeID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `SubjectID` INT NOT NULL,
    `StudentID` INT NOT NULL,
    `Score` DECIMAL(3, 1) NOT NULL,
    `Weight` INT NOT NULL,
    `perId` INT NOT NULL,
    CONSTRAINT `grades_subjectid_foreign` FOREIGN KEY(`SubjectID`) REFERENCES `Subjects`(`SubjectID`),
    CONSTRAINT `grades_studentid_foreign` FOREIGN KEY(`StudentID`) REFERENCES `Students`(`StudentID`),
    CONSTRAINT `grades_perid_foreign` FOREIGN KEY(`perId`) REFERENCES `Academic_period`(`PerId`)
);

CREATE TABLE `Money`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `StudentID` INT NOT NULL,
    `PerID` INT NOT NULL,
    `Value` INT NOT NULL,
    `Paid` INT NOT NULL,
    `Debt` INT NOT NULL,
    CONSTRAINT `money_studentid_foreign` FOREIGN KEY(`StudentID`) REFERENCES `Students`(`StudentID`),
    CONSTRAINT `money_perid_foreign` FOREIGN KEY(`PerID`) REFERENCES `Academic_period`(`PerId`)
);

CREATE TABLE `Classes_Teacher`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Class_perID` INT UNSIGNED NOT NULL,
    `TeacherID` INT NOT NULL,
    CONSTRAINT `classes_teacher_class_perid_foreign` FOREIGN KEY(`Class_perID`) REFERENCES `Class_period`(`id`),
    CONSTRAINT `classes_teacher_teacherid_foreign` FOREIGN KEY(`TeacherID`) REFERENCES `Teachers`(`TeacherID`)
);

CREATE TABLE `TimeSlots`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `DayOfWeek` VARCHAR(255) NOT NULL,
    `StartTime` TIME NOT NULL,
    `EndTime` TIME NOT NULL
);

CREATE TABLE `Schedules`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Class_perID` INT UNSIGNED NOT NULL,
    `TeacherID` INT NOT NULL,
    `TimeSlotID` INT UNSIGNED NOT NULL,
    `WeekNumber` INT NULL,
    CONSTRAINT `schedules_class_perid_foreign` FOREIGN KEY(`Class_perID`) REFERENCES `Class_period`(`id`),
    CONSTRAINT `schedules_teacherid_foreign` FOREIGN KEY(`TeacherID`) REFERENCES `Teachers`(`TeacherID`),
    CONSTRAINT `schedules_timeslotid_foreign` FOREIGN KEY(`TimeSlotID`) REFERENCES `TimeSlots`(`id`)
);

CREATE TABLE `Students_Classes`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `StudentID` INT NOT NULL,
    `Class_perID` INT UNSIGNED NOT NULL,
    CONSTRAINT `students_classes_studentid_foreign` FOREIGN KEY(`StudentID`) REFERENCES `Students`(`StudentID`),
    CONSTRAINT `students_classes_class_perid_foreign` FOREIGN KEY(`Class_perID`) REFERENCES `Class_period`(`id`)
);

CREATE INDEX idx_st_name ON Students(StudentName);
CREATE INDEX idx_t_name ON Teachers(TeacherName);
CREATE INDEX idx_grad ON Grades(StudentID, SubjectID);

CREATE VIEW class_roster AS
SELECT c.ClassName, s.StudentID, s.StudentName, s.Address, s.BirthDate
FROM Students s
INNER JOIN Students_Classes sc ON s.StudentID = sc.StudentID
INNER JOIN Class_period cp ON cp.id = sc.Class_perID
INNER JOIN Classes c ON c.ClassID = cp.ClassID
ORDER BY c.ClassName;

CREATE VIEW top_10_student AS
SELECT s.StudentID, s.StudentName, g.SubjectID, g.Score, c.ClassID
FROM Students s
INNER JOIN Grades g ON g.StudentID = s.StudentID
INNER JOIN Students_Classes sc ON s.StudentID = sc.StudentID
INNER JOIN Class_period cp ON cp.id = sc.Class_perID
INNER JOIN Classes c ON c.ClassID = cp.ClassID
ORDER BY g.Score DESC
LIMIT 10;

CREATE VIEW subject_wise_perf AS
SELECT s.StudentName, s.StudentID, g.SubjectID, g.Score, sj.SubjectName, c.ClassName
FROM Grades g
INNER JOIN Students s ON g.StudentID = s.StudentID
INNER JOIN Subjects sj ON g.SubjectID = sj.SubjectID
INNER JOIN Students_Classes sc ON s.StudentID = sc.StudentID
INNER JOIN Class_period cp ON cp.id = sc.Class_perID
INNER JOIN Classes c ON c.ClassID = cp.ClassID
ORDER BY sj.SubjectName, s.StudentName;

SELECT * FROM class_roster;
SELECT * FROM top_10_student;
SELECT * FROM subject_wise_perf;
-- for tracking each subject, add where sj.SubjectID =, respect to class, c.ClassID =