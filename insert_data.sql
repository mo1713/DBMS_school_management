USE school_management1;
-- Insert sample data

INSERT INTO `Academic_period` (`PerId`, `Term`, `Year`) VALUES
(1, 1, 2024),
(2, 2, 2024),
(3, 1, 2025),
(4, 2, 2025),
(5, 1, 2026);

INSERT INTO `Students` (`StudentID`, `StudentName`, `Address`, `BirthDate`, `Email`) VALUES
(1, 'Nguyen Van A', '123 Hanoi St', '2008-05-10', 'nguyen.a@gmail.com'),
(2, 'Tran Thi B', '456 Saigon St', '2007-11-15', 'tran.b@gmail.com'),
(3, 'Le Van C', '789 Da Nang St', '2008-03-20', 'le.c@gmail.com'),
(4, 'Pham Thi D', '101 Hue St', '2007-07-25', 'pham.d@gmail.com'),
(5, 'Hoang Van E', '202 Can Tho St', '2008-09-30', 'hoang.e@gmail.com');

INSERT INTO `Classes` (`ClassID`, `ClassName`) VALUES
(1, '10A1'),
(2, '10A2'),
(3, '11B1'),
(4, '11B2'),
(5, '12C1');

INSERT INTO `Subjects` (`SubjectID`, `SubjectName`) VALUES
(1, 'Mathematics'),
(2, 'Physics'),
(3, 'Chemistry'),
(4, 'Literature'),
(5, 'English');

INSERT INTO `Teachers` (`TeacherID`, `TeacherName`, `SubjectID`, `Email`) VALUES
(1, 'Bui Van X', 1, 'bui.x@gmail.com'),
(2, 'Dang Thi Y', 2, 'dang.y@gmail.com'),
(3, 'Vu Van Z', 3, 'vu.z@gmail.com'),
(4, 'Nguyen Thi W', 4, 'nguyen.w@gmail.com'),
(5, 'Tran Van Q', 5, 'tran.q@gmail.com');

INSERT INTO `Class_period` (`id`, `ClassID`, `PerId`, `Homeroom_TeacherID`) VALUES
(1, 1, 1, 1),
(2, 2, 1, 2),
(3, 3, 3, 3),
(4, 4, 3, 4),
(5, 5, 4, 5);

INSERT INTO `Grades` (`GradeID`, `SubjectID`, `StudentID`, `Score`, `Weight`, `PerId`) VALUES
(1, 1, 1, 8.5, 30, 1),
(2, 2, 2, 7.0, 20, 1),
(3, 3, 3, 9.0, 40, 3),
(4, 4, 4, 6.5, 10, 3),
(5, 5, 5, 8.0, 30, 4);

INSERT INTO `Money` (`id`, `StudentID`, `PerId`, `Value`, `Paid`, `Debt`) VALUES
(1, 1, 1, 1000000, 800000, 200000),
(2, 2, 1, 1000000, 1000000, 0),
(3, 3, 3, 1200000, 600000, 600000),
(4, 4, 3, 1200000, 1200000, 0),
(5, 5, 4, 1500000, 1000000, 500000);

INSERT INTO `Classes_Teacher` (`id`, `Class_perID`, `TeacherID`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO `TimeSlots` (`id`, `DayOfWeek`, `StartTime`, `EndTime`) VALUES
(1, 'Monday', '08:00:00', '09:00:00'),
(2, 'Tuesday', '09:00:00', '10:00:00'),
(3, 'Wednesday', '10:00:00', '11:00:00'),
(4, 'Thursday', '13:00:00', '14:00:00'),
(5, 'Friday', '14:00:00', '15:00:00');

INSERT INTO `Schedules` (`id`, `Class_perID`, `TeacherID`, `TimeSlotID`, `WeekNumber`) VALUES
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 3),
(4, 4, 4, 4, 4),
(5, 5, 5, 5, 5);

INSERT INTO `Students_Classes` (`id`, `StudentID`, `Class_perID`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);
