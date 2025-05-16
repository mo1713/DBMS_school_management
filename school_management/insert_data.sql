USE school_management1;
-- Insert sample data

-- Insert Academic Periods (Term 1 and Term 2, Year 2025)
INSERT INTO Academic_period (PerId, Term, Year) VALUES
(1, 1, 2025),
(2, 2, 2025);

-- Insert Subjects (12 subjects in English)
INSERT INTO Subjects (SubjectName) VALUES
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('Literature'),
('History'),
('Geography'),
('English'),
('Civic Education'),
('Informatics'),
('Technology'),
('Physical Education');

-- Insert Teachers (12 teachers, each teaching one subject)
INSERT INTO Teachers (TeacherName, SubjectID, Email) VALUES
('John Nguyen', 1, 'john.nguyen@school.edu'),
('Mary Tran', 2, 'mary.tran@school.edu'),
('Peter Le', 3, 'peter.le@school.edu'),
('Anna Pham', 4, 'anna.pham@school.edu'),
('Michael Hoang', 5, 'michael.hoang@school.edu'),
('Lisa Do', 6, 'lisa.do@school.edu'),
('David Vu', 7, 'david.vu@school.edu'),
('Emily Ngo', 8, 'emily.ngo@school.edu'),
('James Bui', 9, 'james.bui@school.edu'),
('Sophie Truong', 10, 'sophie.truong@school.edu'),
('Thomas Ly', 11, 'thomas.ly@school.edu'),
('Laura Mai', 12, 'laura.mai@school.edu');

-- Insert Classes (12 classes: 10A–10D, 11A–11D, 12A–12D)
INSERT INTO Classes (ClassName) VALUES
('10A'), ('10B'), ('10C'), ('10D'),
('11A'), ('11B'), ('11C'), ('11D'),
('12A'), ('12B'), ('12C'), ('12D');

-- Insert Class_period (Assign homeroom teachers for both terms)
INSERT INTO Class_period (id, ClassID, PerId, Homeroom_TeacherID) VALUES
-- Term 1
(1, 1, 1, 1),   -- 10A, John Nguyen
(2, 2, 1, 2),   -- 10B, Mary Tran
(3, 3, 1, 3),   -- 10C, Peter Le
(4, 4, 1, 4),   -- 10D, Anna Pham
(5, 5, 1, 5),   -- 11A, Michael Hoang
(6, 6, 1, 6),   -- 11B, Lisa Do
(7, 7, 1, 7),   -- 11C, David Vu
(8, 8, 1, 8),   -- 11D, Emily Ngo
(9, 9, 1, 9),   -- 12A, James Bui
(10, 10, 1, 10), -- 12B, Sophie Truong
(11, 11, 1, 11), -- 12C, Thomas Ly
(12, 12, 1, 12), -- 12D, Laura Mai
-- Term 2
(13, 1, 2, 1),   -- 10A
(14, 2, 2, 2),   -- 10B
(15, 3, 2, 3),   -- 10C
(16, 4, 2, 4),   -- 10D
(17, 5, 2, 5),   -- 11A
(18, 6, 2, 6),   -- 11B
(19, 7, 2, 7),   -- 11C
(20, 8, 2, 9),   -- 11D
(21, 9, 2, 9),   -- 12A
(22, 10, 2, 10), -- 12B
(23, 11, 2, 11), -- 12C
(24, 12, 2, 12); -- 12D

-- Insert Students (60 students, 5 per class)
INSERT INTO Students (StudentName, Address, BirthDate, Email) VALUES
-- Class 10A
('Alice Nguyen', '123 Main St, Hanoi', '2009-01-15', 'alice.nguyen@school.edu'),
('Bob Tran', '45 Oak Ave, Hanoi', '2009-02-20', 'bob.tran@school.edu'),
('Charlie Le', '78 Pine Rd, Hanoi', '2009-03-10', 'charlie.le@school.edu'),
('Diana Pham', '12 Elm St, Hanoi', '2009-04-05', 'diana.pham@school.edu'),
('Ethan Hoang', '56 Maple Dr, Hanoi', '2009-05-12', 'ethan.hoang@school.edu'),
-- Class 10B
('Fiona Do', '89 Cedar Ln, Hanoi', '2009-01-16', 'fiona.do@school.edu'),
('George Vu', '34 Birch Ave, Hanoi', '2009-02-21', 'george.vu@school.edu'),
('Hannah Ngo', '67 Willow St, Hanoi', '2009-03-11', 'hannah.ngo@school.edu'),
('Ian Bui', '90 Spruce Rd, Hanoi', '2009-04-06', 'ian.bui@school.edu'),
('Julia Truong', '23 Ash St, Hanoi', '2009-05-13', 'julia.truong@school.edu'),
-- Class 10C
('Kevin Ly', '45 Laurel Dr, Hanoi', '2009-01-17', 'kevin.ly@school.edu'),
('Lily Mai', '78 Sycamore Ave, Hanoi', '2009-02-22', 'lily.mai@school.edu'),
('Mason Nguyen', '12 Chestnut St, Hanoi', '2009-03-12', 'mason.nguyen@school.edu'),
('Natalie Tran', '56 Magnolia Ln, Hanoi', '2009-04-07', 'natalie.tran@school.edu'),
('Oliver Le', '89 Poplar Rd, Hanoi', '2009-05-14', 'oliver.le@school.edu'),
-- Class 10D
('Penny Pham', '34 Hazel Ave, Hanoi', '2009-01-18', 'penny.pham@school.edu'),
('Quentin Hoang', '67 Linden St, Hanoi', '2009-02-23', 'quentin.hoang@school.edu'),
('Rachel Do', '90 Acacia Dr, Hanoi', '2009-03-13', 'rachel.do@school.edu'),
('Sam Vu', '23 Olive St, Hanoi', '2009-04-08', 'sam.vu@school.edu'),
('Tina Ngo', '45 Palm Rd, Hanoi', '2009-05-15', 'tina.ngo@school.edu'),
-- Class 11A
('Ulysses Bui', '78 Cypress Ln, Hanoi', '2008-01-19', 'ulysses.bui@school.edu'),
('Victoria Truong', '12 Redwood Ave, Hanoi', '2008-02-24', 'victoria.truong@school.edu'),
('William Ly', '56 Sequoia Dr, Hanoi', '2008-03-14', 'william.ly@school.edu'),
('Xena Mai', '89 Fir St, Hanoi', '2008-04-09', 'xena.mai@school.edu'),
('Yuri Nguyen', '34 Hemlock Rd, Hanoi', '2008-05-16', 'yuri.nguyen@school.edu'),
-- Class 11B
('Zoe Tran', '67 Aspen Ave, Hanoi', '2008-01-20', 'zoe.tran@school.edu'),
('Aaron Le', '90 Dogwood St, Hanoi', '2008-02-25', 'aaron.le@school.edu'),
('Bella Pham', '23 Magnolia Dr, Hanoi', '2008-03-15', 'bella.pham@school.edu'),
('Caleb Hoang', '45 Sycamore Rd, Hanoi', '2008-04-10', 'caleb.hoang@school.edu'),
('Daisy Do', '78 Laurel St, Hanoi', '2008-05-17', 'daisy.do@school.edu'),
-- Class 11C
('Eli Vu', '12 Cedar Ave, Hanoi', '2008-01-21', 'eli.vu@school.edu'),
('Faith Ngo', '56 Pine Ln, Hanoi', '2008-02-26', 'faith.ngo@school.edu'),
('Gideon Bui', '89 Oak Dr, Hanoi', '2008-03-16', 'gideon.bui@school.edu'),
('Hazel Truong', '34 Maple St, Hanoi', '2008-04-11', 'hazel.truong@school.edu'),
('Isaac Ly', '67 Elm Rd, Hanoi', '2008-05-18', 'isaac.ly@school.edu'),
-- Class 11D
('Jade Mai', '90 Birch Ave, Hanoi', '2008-01-22', 'jade.mai@school.edu'),
('Kieran Nguyen', '23 Willow Dr, Hanoi', '2008-02-27', 'kieran.nguyen@school.edu'),
('Lila Tran', '45 Spruce St, Hanoi', '2008-03-17', 'lila.tran@school.edu'),
('Milo Le', '78 Ash Ln, Hanoi', '2008-04-12', 'milo.le@school.edu'),
('Nora Pham', '12 Main Rd, Hanoi', '2008-05-19', 'nora.pham@school.edu'),
-- Class 12A
('Oscar Hoang', '56 Oak Ave, Hanoi', '2007-01-23', 'oscar.hoang@school.edu'),
('Piper Do', '89 Pine St, Hanoi', '2007-02-28', 'piper.do@school.edu'),
('Quinn Vu', '34 Elm Dr, Hanoi', '2007-03-18', 'quinn.vu@school.edu'),
('Rose Ngo', '67 Maple Ln, Hanoi', '2007-04-13', 'rose.ngo@school.edu'),
('Seth Bui', '90 Cedar Rd, Hanoi', '2007-05-20', 'seth.bui@school.edu'),
-- Class 12B
('Tara Truong', '23 Birch Ave, Hanoi', '2007-01-24', 'tara.truong@school.edu'),
('Uriel Ly', '45 Willow St, Hanoi', '2007-02-01', 'uriel.ly@school.edu'),
('Vera Mai', '78 Spruce Dr, Hanoi', '2007-03-19', 'vera.mai@school.edu'),
('Wesley Nguyen', '12 Ash Rd, Hanoi', '2007-04-14', 'wesley.nguyen@school.edu'),
('Xena Tran', '56 Laurel Ln, Hanoi', '2007-05-21', 'xena.tran@school.edu'),
-- Class 12C
('Yara Le', '89 Sycamore Ave, Hanoi', '2007-01-25', 'yara.le@school.edu'),
('Zane Pham', '34 Magnolia St, Hanoi', '2007-02-02', 'zane.pham@school.edu'),
('Amelia Hoang', '67 Poplar Rd, Hanoi', '2007-03-20', 'amelia.hoang@school.edu'),
('Ben Do', '90 Hazel Dr, Hanoi', '2007-04-15', 'ben.do@school.edu'),
('Clara Vu', '23 Linden Ave, Hanoi', '2007-05-22', 'clara.vu@school.edu'),
-- Class 12D
('Dylan Ngo', '45 Acacia St, Hanoi', '2007-01-26', 'dylan.ngo@school.edu'),
('Elise Bui', '78 Olive Dr, Hanoi', '2007-02-03', 'elise.bui@school.edu'),
('Finn Truong', '12 Palm Rd, Hanoi', '2007-03-21', 'finn.truong@school.edu'),
('Gina Ly', '56 Cypress Ln, Hanoi', '2007-04-16', 'gina.ly@school.edu'),
('Hugo Mai', '89 Redwood Ave, Hanoi', '2007-05-23', 'hugo.mai@school.edu');

-- Insert Students_Classes (Assign students to classes for both terms)
INSERT INTO Students_Classes (StudentID, Class_perID) VALUES
-- Class 10A, Term 1 (Class_perID = 1), Term 2 (Class_perID = 13)
(1, 1), (1, 13), (2, 1), (2, 13), (3, 1), (3, 13), (4, 1), (4, 13), (5, 1), (5, 13),
-- Class 10B, Term 1 (2), Term 2 (14)
(6, 2), (6, 14), (7, 2), (7, 14), (8, 2), (8, 14), (9, 2), (9, 14), (10, 2), (10, 14),
-- Class 10C, Term 1 (3), Term 2 (15)
(11, 3), (11, 15), (12, 3), (12, 15), (13, 3), (13, 15), (14, 3), (14, 15), (15, 3), (15, 15),
-- Class 10D, Term 1 (4), Term 2 (16)
(16, 4), (16, 16), (17, 4), (17, 16), (18, 4), (18, 16), (19, 4), (19, 16), (20, 4), (20, 16),
-- Class 11A, Term 1 (5), Term 2 (17)
(21, 5), (21, 17), (22, 5), (22, 17), (23, 5), (23, 17), (24, 5), (24, 17), (25, 5), (25, 17),
-- Class 11B, Term 1 (6), Term 2 (18)
(26, 6), (26, 18), (27, 6), (27, 18), (28, 6), (28, 18), (29, 6), (29, 18), (30, 6), (30, 18),
-- Class 11C, Term 1 (7), Term 2 (19)
(31, 7), (31, 19), (32, 7), (32, 19), (33, 7), (33, 19), (34, 7), (34, 19), (35, 7), (35, 19),
-- Class 11D, Term 1 (8), Term 2 (20)
(36, 8), (36, 20), (37, 8), (37, 20), (38, 8), (38, 20), (39, 8), (39, 20), (40, 8), (40, 20),
-- Class 12A, Term 1 (9), Term 2 (21)
(41, 9), (41, 21), (42, 9), (42, 21), (43, 9), (43, 21), (44, 9), (44, 21), (45, 9), (45, 21),
-- Class 12B, Term 1 (10), Term 2 (22)
(46, 10), (46, 22), (47, 10), (47, 22), (48, 10), (48, 22), (49, 10), (49, 22), (50, 10), (50, 22),
-- Class 12C, Term 1 (11), Term 2 (23)
(51, 11), (51, 23), (52, 11), (52, 23), (53, 11), (53, 23), (54, 11), (54, 23), (55, 11), (55, 23),
-- Class 12D, Term 1 (12), Term 2 (24)
(56, 12), (56, 24), (57, 12), (57, 24), (58, 12), (58, 24), (59, 12), (59, 24), (60, 12), (60, 24);

-- Insert TimeSlots (5 periods/day, Monday to Friday)
INSERT INTO TimeSlots (DayOfWeek, StartTime, EndTime) VALUES
('Monday', '08:00:00', '09:00:00'),    -- Period 1
('Monday', '09:15:00', '10:15:00'),    -- Period 2
('Monday', '10:30:00', '11:30:00'),    -- Period 3
('Monday', '13:30:00', '14:30:00'),    -- Period 4 (after 1.5h lunch)
('Monday', '14:45:00', '15:45:00'),    -- Period 5
('Tuesday', '08:00:00', '09:00:00'),
('Tuesday', '09:15:00', '10:15:00'),
('Tuesday', '10:30:00', '11:30:00'),
('Tuesday', '13:30:00', '14:30:00'),
('Tuesday', '14:45:00', '15:45:00'),
('Wednesday', '08:00:00', '09:00:00'),
('Wednesday', '09:15:00', '10:15:00'),
('Wednesday', '10:30:00', '11:30:00'),
('Wednesday', '13:30:00', '14:30:00'),
('Wednesday', '14:45:00', '15:45:00'),
('Thursday', '08:00:00', '09:00:00'),
('Thursday', '09:15:00', '10:15:00'),
('Thursday', '10:30:00', '11:30:00'),
('Thursday', '13:30:00', '14:30:00'),
('Thursday', '14:45:00', '15:45:00'),
('Friday', '08:00:00', '09:00:00'),
('Friday', '09:15:00', '10:15:00'),
('Friday', '10:30:00', '11:30:00'),
('Friday', '13:30:00', '14:30:00'),
('Friday', '14:45:00', '15:45:00');

-- Insert Schedules (Sample for Class 10A and 10B, Term 1)
INSERT INTO Schedules (Class_perID, TeacherID, TimeSlotID, WeekNumber) VALUES
-- Class 10A, Term 1 (Class_perID = 1), Monday
(1, 1, 1, 1),  -- Mathematics
(1, 5, 2, 1),  -- Literature
(1, 8, 3, 1),  -- English
(1, 2, 4, 1),  -- Physics
(1, 12, 5, 1), -- Physical Education
-- Tuesday
(1, 3, 6, 1),  -- Chemistry
(1, 6, 7, 1),  -- History
(1, 7, 8, 1),  -- Geography
(1, 9, 9, 1),  -- Civic Education
(1, 10, 10, 1), -- Informatics
-- Wednesday
(1, 1, 11, 1), -- Mathematics
(1, 4, 12, 1), -- Biology
(1, 5, 13, 1), -- Literature
(1, 11, 14, 1), -- Technology
(1, 8, 15, 1), -- English
-- Thursday
(1, 2, 16, 1), -- Physics
(1, 3, 17, 1), -- Chemistry
(1, 6, 18, 1), -- History
(1, 7, 19, 1), -- Geography
(1, 12, 20, 1), -- Physical Education
-- Friday
(1, 4, 21, 1), -- Biology
(1, 9, 22, 1), -- Civic Education
(1, 10, 23, 1), -- Informatics
(1, 11, 24, 1), -- Technology
(1, 8, 25, 1), -- English
-- Class 10B, Term 1 (Class_perID = 2)
(2, 5, 1, 1), (2, 1, 2, 1), (2, 2, 3, 1), (2, 8, 4, 1), (2, 12, 5, 1),
(2, 6, 6, 1), (2, 3, 7, 1), (2, 7, 8, 1), (2, 10, 9, 1), (2, 9, 10, 1),
(2, 4, 11, 1), (2, 1, 12, 1), (2, 8, 13, 1), (2, 11, 14, 1), (2, 5, 15, 1),
(2, 3, 16, 1), (2, 2, 17, 1), (2, 6, 18, 1), (2, 7, 19, 1), (2, 12, 20, 1),
(2, 9, 21, 1), (2, 4, 22, 1), (2, 10, 23, 1), (2, 11, 24, 1), (2, 8, 25, 1);

-- Note: Schedules for Class_perID 3–12 (Term 1) and 13–24 (Term 2) follow similar patterns, shuffled to avoid teacher conflicts.

-- Insert Classes_Teacher (Assign teachers to classes for both terms)
INSERT INTO Classes_Teacher (Class_perID, TeacherID) VALUES
-- Term 1
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 12),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 8), (3, 9), (3, 10), (3, 11), (3, 12),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10), (4, 11), (4, 12),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10), (5, 11), (5, 12),
(6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (6, 8), (6, 9), (6, 10), (6, 11), (6, 12),
(7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7), (7, 8), (7, 9), (7, 10), (7, 11), (7, 12),
(8, 1), (8, 2), (8, 3), (8, 4), (8, 5), (8, 6), (8, 7), (8, 8), (8, 9), (8, 10), (8, 11), (8, 12),
(9, 1), (9, 2), (9, 3), (9, 4), (9, 5), (9, 6), (9, 7), (9, 8), (9, 9), (9, 10), (9, 11), (9, 12),
(10, 1), (10, 2), (10, 3), (10, 4), (10, 5), (10, 6), (10, 7), (10, 8), (10, 9), (10, 10), (10, 11), (10, 12),
(11, 1), (11, 2), (11, 3), (11, 4), (11, 5), (11, 6), (11, 7), (11, 8), (11, 9), (11, 10), (11, 11), (11, 12),
(12, 1), (12, 2), (12, 3), (12, 4), (12, 5), (12, 6), (12, 7), (12, 8), (12, 9), (12, 10), (12, 11), (12, 12),
-- Term 2
(13, 1), (13, 2), (13, 3), (13, 4), (13, 5), (13, 6), (13, 7), (13, 8), (13, 9), (13, 10), (13, 11), (13, 12),
(14, 1), (14, 2), (14, 3), (14, 4), (14, 5), (14, 6), (14, 7), (14, 8), (14, 9), (14, 10), (14, 11), (14, 12),
(15, 1), (15, 2), (15, 3), (15, 4), (15, 5), (15, 6), (15, 7), (15, 8), (15, 9), (15, 10), (15, 11), (15, 12),
(16, 1), (16, 2), (16, 3), (16, 4), (16, 5), (16, 6), (16, 7), (16, 8), (16, 9), (16, 10), (16, 11), (16, 12),
(17, 1), (17, 2), (17, 3), (17, 4), (17, 5), (17, 6), (17, 7), (17, 8), (17, 9), (17, 10), (17, 11), (17, 12),
(18, 1), (18, 2), (18, 3), (18, 4), (18, 5), (18, 6), (18, 7), (18, 8), (18, 9), (18, 10), (18, 11), (18, 12),
(19, 1), (19, 2), (19, 3), (19, 4), (19, 5), (19, 6), (19, 7), (19, 8), (19, 9), (19, 10), (19, 11), (19, 12),
(20, 1), (20, 2), (20, 3), (20, 4), (20, 5), (20, 6), (20, 7), (20, 8), (20, 9), (20, 10), (20, 11), (20, 12),
(21, 1), (21, 2), (21, 3), (21, 4), (21, 5), (21, 6), (21, 7), (21, 8), (21, 9), (21, 10), (21, 11), (21, 12),
(22, 1), (22, 2), (22, 3), (22, 4), (22, 5), (22, 6), (22, 7), (22, 8), (22, 9), (22, 10), (22, 11), (22, 12),
(23, 1), (23, 2), (23, 3), (23, 4), (23, 5), (23, 6), (23, 7), (23, 8), (23, 9), (23, 10), (23, 11), (23, 12),
(24, 1), (24, 2), (24, 3), (24, 4), (24, 5), (24, 6), (24, 7), (24, 8), (24, 9), (24, 10), (24, 11), (24, 12);

-- Insert Grades (Full data for 6 students, 12 subjects, 3 grades/subject, 2 terms)
INSERT INTO Grades (SubjectID, StudentID, Score, Weight, perId) VALUES
-- Student 1 (Alice Nguyen), Term 1 (perId = 1)
(1, 1, 8.5, 1, 1), (1, 1, 7.0, 2, 1), (1, 1, 9.0, 3, 1), -- Mathematics
(2, 1, 7.5, 1, 1), (2, 1, 8.0, 2, 1), (2, 1, 6.5, 3, 1), -- Physics
(3, 1, 9.0, 1, 1), (3, 1, 8.5, 2, 1), (3, 1, 7.5, 3, 1), -- Chemistry
(4, 1, 6.5, 1, 1), (4, 1, 7.0, 2, 1), (4, 1, 8.0, 3, 1), -- Biology
(5, 1, 8.0, 1, 1), (5, 1, 9.0, 2, 1), (5, 1, 8.5, 3, 1), -- Literature
(6, 1, 7.0, 1, 1), (6, 1, 6.5, 2, 1), (6, 1, 7.5, 3, 1), -- History
(7, 1, 8.5, 1, 1), (7, 1, 8.0, 2, 1), (7, 1, 9.0, 3, 1), -- Geography
(8, 1, 9.0, 1, 1), (8, 1, 8.5, 2, 1), (8, 1, 7.0, 3, 1), -- English
(9, 1, 7.5, 1, 1), (9, 1, 8.0, 2, 1), (9, 1, 6.5, 3, 1), -- Civic Education
(10, 1, 8.0, 1, 1), (10, 1, 7.5, 2, 1), (10, 1, 8.5, 3, 1), -- Informatics
(11, 1, 6.5, 1, 1), (11, 1, 7.0, 2, 1), (11, 1, 8.0, 3, 1), -- Technology
(12, 1, 9.0, 1, 1), (12, 1, 8.5, 2, 1), (12, 1, 9.5, 3, 1), -- Physical Education
-- Student 1, Term 2 (perId = 2)
(1, 1, 8.0, 1, 2), (1, 1, 7.5, 2, 2), (1, 1, 8.5, 3, 2), -- Mathematics
(2, 1, 7.0, 1, 2), (2, 1, 7.5, 2, 2), (2, 1, 6.0, 3, 2), -- Physics
(3, 1, 8.5, 1, 2), (3, 1, 8.0, 2, 2), (3, 1, 7.0, 3, 2), -- Chemistry
(4, 1, 6.0, 1, 2), (4, 1, 6.5, 2, 2), (4, 1, 7.5, 3, 2), -- Biology
(5, 1, 7.5, 1, 2), (5, 1, 8.5, 2, 2), (5, 1, 8.0, 3, 2), -- Literature
(6, 1, 6.5, 1, 2), (6, 1, 6.0, 2, 2), (6, 1, 7.0, 3, 2), -- History
(7, 1, 8.0, 1, 2), (7, 1, 7.5, 2, 2), (7, 1, 8.5, 3, 2), -- Geography
(8, 1, 8.5, 1, 2), (8, 1, 8.0, 2, 2), (8, 1, 6.5, 3, 2), -- English
(9, 1, 7.0, 1, 2), (9, 1, 7.5, 2, 2), (9, 1, 6.0, 3, 2), -- Civic Education
(10, 1, 7.5, 1, 2), (10, 1, 7.0, 2, 2), (10, 1, 8.0, 3, 2), -- Informatics
(11, 1, 6.0, 1, 2), (11, 1, 6.5, 2, 2), (11, 1, 7.5, 3, 2), -- Technology
(12, 1, 8.5, 1, 2), (12, 1, 8.0, 2, 2), (12, 1, 9.0, 3, 2), -- Physical Education
-- Student 2 (Bob Tran), Term 1
(1, 2, 7.5, 1, 1), (1, 2, 8.0, 2, 1), (1, 2, 8.5, 3, 1), -- Mathematics
(2, 2, 6.5, 1, 1), (2, 2, 7.0, 2, 1), (2, 2, 7.5, 3, 1), -- Physics
(3, 2, 8.0, 1, 1), (3, 2, 7.5, 2, 1), (3, 2, 8.0, 3, 1), -- Chemistry
(4, 2, 7.0, 1, 1), (4, 2, 6.5, 2, 1), (4, 2, 7.0, 3, 1), -- Biology
(5, 2, 8.5, 1, 1), (5, 2, 8.0, 2, 1), (5, 2, 7.5, 3, 1), -- Literature
(6, 2, 7.5, 1, 1), (6, 2, 7.0, 2, 1), (6, 2, 6.5, 3, 1), -- History
(7, 2, 6.5, 1, 1), (7, 2, 7.0, 2, 1), (7, 2, 7.5, 3, 1), -- Geography
(8, 2, 8.0, 1, 1), (8, 2, 7.5, 2, 1), (8, 2, 8.0, 3, 1), -- English
(9, 2, 7.0, 1, 1), (9, 2, 6.5, 2, 1), (9, 2, 7.0, 3, 1), -- Civic Education
(10, 2, 8.5, 1, 1), (10, 2, 8.0, 2, 1), (10, 2, 7.5, 3, 1), -- Informatics
(11, 2, 7.5, 1, 1), (11, 2, 7.0, 2, 1), (11, 2, 6.5, 3, 1), -- Technology
(12, 2, 8.0, 1, 1), (12, 2, 7.5, 2, 1), (12, 2, 8.0, 3, 1), -- Physical Education
-- Student 2, Term 2
(1, 2, 7.0, 1, 2), (1, 2, 7.5, 2, 2), (1, 2, 8.0, 3, 2), -- Mathematics
(2, 2, 6.0, 1, 2), (2, 2, 6.5, 2, 2), (2, 2, 7.0, 3, 2), -- Physics
(3, 2, 7.5, 1, 2), (3, 2, 7.0, 2, 2), (3, 2, 7.5, 3, 2), -- Chemistry
(4, 2, 6.5, 1, 2), (4, 2, 6.0, 2, 2), (4, 2, 6.5, 3, 2), -- Biology
(5, 2, 8.0, 1, 2), (5, 2, 7.5, 2, 2), (5, 2, 7.0, 3, 2), -- Literature
(6, 2, 7.0, 1, 2), (6, 2, 6.5, 2, 2), (6, 2, 6.0, 3, 2), -- History
(7, 2, 6.0, 1, 2), (7, 2, 6.5, 2, 2), (7, 2, 7.0, 3, 2), -- Geography
(8, 2, 7.5, 1, 2), (8, 2, 7.0, 2, 2), (8, 2, 7.5, 3, 2), -- English
(9, 2, 6.5, 1, 2), (9, 2, 6.0, 2, 2), (9, 2, 6.5, 3, 2), -- Civic Education
(10, 2, 8.0, 1, 2), (10, 2, 7.5, 2, 2), (10, 2, 7.0, 3, 2), -- Informatics
(11, 2, 7.0, 1, 2), (11, 2, 6.5, 2, 2), (11, 2, 6.0, 3, 2), -- Technology
(12, 2, 7.5, 1, 2), (12, 2, 7.0, 2, 2), (12, 2, 7.5, 3, 2), -- Physical Education
-- Student 3 (Charlie Le), Term 1
(1, 3, 8.0, 1, 1), (1, 3, 7.5, 2, 1), (1, 3, 8.0, 3, 1), -- Mathematics
(2, 3, 7.0, 1, 1), (2, 3, 6.5, 2, 1), (2, 3, 7.0, 3, 1), -- Physics
(3, 3, 7.5, 1, 1), (3, 3, 7.0, 2, 1), (3, 3, 7.5, 3, 1), -- Chemistry
(4, 3, 6.5, 1, 1), (4, 3, 6.0, 2, 1), (4, 3, 6.5, 3, 1), -- Biology
(5, 3, 8.0, 1, 1), (5, 3, 7.5, 2, 1), (5, 3, 7.0, 3, 1), -- Literature
(6, 3, 7.0, 1, 1), (6, 3, 6.5, 2, 1), (6, 3, 6.0, 3, 1), -- History
(7, 3, 6.5, 1, 1), (7, 3, 6.0, 2, 1), (7, 3, 6.5, 3, 1), -- Geography
(8, 3, 7.5, 1, 1), (8, 3, 7.0, 2, 1), (8, 3, 7.5, 3, 1), -- English
(9, 3, 6.5, 1, 1), (9, 3, 6.0, 2, 1), (9, 3, 6.5, 3, 1), -- Civic Education
(10, 3, 8.0, 1, 1), (10, 3, 7.5, 2, 1), (10, 3, 7.0, 3, 1), -- Informatics
(11, 3, 7.0, 1, 1), (11, 3, 6.5, 2, 1), (11, 3, 6.0, 3, 1), -- Technology
(12, 3, 7.5, 1, 1), (12, 3, 7.0, 2, 1), (12, 3, 7.5, 3, 1), -- Physical Education
-- Student 3, Term 2
(1, 3, 7.5, 1, 2), (1, 3, 7.0, 2, 2), (1, 3, 7.5, 3, 2), -- Mathematics
(2, 3, 6.5, 1, 2), (2, 3, 6.0, 2, 2), (2, 3, 6.5, 3, 2), -- Physics
(3, 3, 7.0, 1, 2), (3, 3, 6.5, 2, 2), (3, 3, 7.0, 3, 2), -- Chemistry
(4, 3, 6.0, 1, 2), (4, 3, 6.5, 2, 2), (4, 3, 6.0, 3, 2), -- Biology
(5, 3, 7.5, 1, 2), (5, 3, 7.0, 2, 2), (5, 3, 6.5, 3, 2), -- Literature
(6, 3, 6.5, 1, 2), (6, 3, 6.0, 2, 2), (6, 3, 6.5, 3, 2), -- History
(7, 3, 6.0, 1, 2), (7, 3, 6.5, 2, 2), (7, 3, 6.0, 3, 2), -- Geography
(8, 3, 7.0, 1, 2), (8, 3, 6.5, 2, 2), (8, 3, 7.0, 3, 2), -- English
(9, 3, 6.0, 1, 2), (9, 3, 6.5, 2, 2), (9, 3, 6.0, 3, 2), -- Civic Education
(10, 3, 7.5, 1, 2), (10, 3, 7.0, 2, 2), (10, 3, 6.5, 3, 2), -- Informatics
(11, 3, 6.5, 1, 2), (11, 3, 6.0, 2, 2), (11, 3, 6.5, 3, 2), -- Technology
(12, 3, 7.0, 1, 2), (12, 3, 6.5, 2, 2), (12, 3, 7.0, 3, 2), -- Physical Education
-- Student 4 (Diana Pham), Term 1
(1, 4, 7.5, 1, 1), (1, 4, 7.0, 2, 1), (1, 4, 7.5, 3, 1), -- Mathematics
(2, 4, 6.5, 1, 1), (2, 4, 6.0, 2, 1), (2, 4, 6.5, 3, 1), -- Physics
(3, 4, 7.0, 1, 1), (3, 4, 6.5, 2, 1), (3, 4, 7.0, 3, 1), -- Chemistry
(4, 4, 6.0, 1, 1), (4, 4, 6.5, 2, 1), (4, 4, 6.0, 3, 1), -- Biology
(5, 4, 7.5, 1, 1), (5, 4, 7.0, 2, 1), (5, 4, 6.5, 3, 1), -- Literature
(6, 4, 6.5, 1, 1), (6, 4, 6.0, 2, 1), (6, 4, 6.5, 3, 1), -- History
(7, 4, 6.0, 1, 1), (7, 4, 6.5, 2, 1), (7, 4, 6.0, 3, 1), -- Geography
(8, 4, 7.0, 1, 1), (8, 4, 6.5, 2, 1), (8, 4, 7.0, 3, 1), -- English
(9, 4, 6.0, 1, 1), (9, 4, 6.5, 2, 1), (9, 4, 6.0, 3, 1), -- Civic Education
(10, 4, 7.5, 1, 1), (10, 4, 7.0, 2, 1), (10, 4, 6.5, 3, 1), -- Informatics
(11, 4, 6.5, 1, 1), (11, 4, 6.0, 2, 1), (11, 4, 6.5, 3, 1), -- Technology
(12, 4, 7.0, 1, 1), (12, 4, 6.5, 2, 1), (12, 4, 7.0, 3, 1), -- Physical Education
-- Student 4, Term 2
(1, 4, 7.0, 1, 2), (1, 4, 6.5, 2, 2), (1, 4, 7.0, 3, 2), -- Mathematics
(2, 4, 6.0, 1, 2), (2, 4, 6.5, 2, 2), (2, 4, 6.0, 3, 2), -- Physics
(3, 4, 6.5, 1, 2), (3, 4, 6.0, 2, 2), (3, 4, 6.5, 3, 2), -- Chemistry
(4, 4, 6.5, 1, 2), (4, 4, 6.0, 2, 2), (4, 4, 6.5, 3, 2), -- Biology
(5, 4, 7.0, 1, 2), (5, 4, 6.5, 2, 2), (5, 4, 6.0, 3, 2), -- Literature
(6, 4, 6.0, 1, 2), (6, 4, 6.5, 2, 2), (6, 4, 6.0, 3, 2), -- History
(7, 4, 6.5, 1, 2), (7, 4, 6.0, 2, 2), (7, 4, 6.5, 3, 2), -- Geography
(8, 4, 6.5, 1, 2), (8, 4, 6.0, 2, 2), (8, 4, 6.5, 3, 2), -- English
(9, 4, 6.5, 1, 2), (9, 4, 6.0, 2, 2), (9, 4, 6.5, 3, 2), -- Civic Education
(10, 4, 7.0, 1, 2), (10, 4, 6.5, 2, 2), (10, 4, 6.0, 3, 2), -- Informatics
(11, 4, 6.0, 1, 2), (11, 4, 6.5, 2, 2), (11, 4, 6.0, 3, 2), -- Technology
(12, 4, 6.5, 1, 2), (12, 4, 6.0, 2, 2), (12, 4, 6.5, 3, 2), -- Physical Education
-- Student 5 (Ethan Hoang), Term 1
(1, 5, 7.0, 1, 1), (1, 5, 6.5, 2, 1), (1, 5, 7.0, 3, 1), -- Mathematics
(2, 5, 6.5, 1, 1), (2, 5, 6.0, 2, 1), (2, 5, 6.5, 3, 1), -- Physics
(3, 5, 6.0, 1, 1), (3, 5, 6.5, 2, 1), (3, 5, 6.0, 3, 1), -- Chemistry
(4, 5, 6.5, 1, 1), (4, 5, 6.0, 2, 1), (4, 5, 6.5, 3, 1), -- Biology
(5, 5, 7.0, 1, 1), (5, 5, 6.5, 2, 1), (5, 5, 6.0, 3, 1), -- Literature
(6, 5, 6.0, 1, 1), (6, 5, 6.5, 2, 1), (6, 5, 6.0, 3, 1), -- History
(7, 5, 6.5, 1, 1), (7, 5, 6.0, 2, 1), (7, 5, 6.5, 3, 1), -- Geography
(8, 5, 6.0, 1, 1), (8, 5, 6.5, 2, 1), (8, 5, 6.0, 3, 1), -- English
(9, 5, 6.5, 1, 1), (9, 5, 6.0, 2, 1), (9, 5, 6.5, 3, 1), -- Civic Education
(10, 5, 7.0, 1, 1), (10, 5, 6.5, 2, 1), (10, 5, 6.0, 3, 1), -- Informatics
(11, 5, 6.0, 1, 1), (11, 5, 6.5, 2, 1), (11, 5, 6.0, 3, 1), -- Technology
(12, 5, 6.5, 1, 1), (12, 5, 6.0, 2, 1), (12, 5, 6.5, 3, 1), -- Physical Education
-- Student 5, Term 2
(1, 5, 6.5, 1, 2), (1, 5, 6.0, 2, 2), (1, 5, 6.5, 3, 2), -- Mathematics
(2, 5, 6.0, 1, 2), (2, 5, 6.5, 2, 2), (2, 5, 6.0, 3, 2), -- Physics
(3, 5, 6.5, 1, 2), (3, 5, 6.0, 2, 2), (3, 5, 6.5, 3, 2), -- Chemistry
(4, 5, 6.0, 1, 2), (4, 5, 6.5, 2, 2), (4, 5, 6.0, 3, 2), -- Biology
(5, 5, 6.5, 1, 2), (5, 5, 6.0, 2, 2), (5, 5, 6.5, 3, 2), -- Literature
(6, 5, 6.0, 1, 2), (6, 5, 6.5, 2, 2), (6, 5, 6.0, 3, 2), -- History
(7, 5, 6.0, 1, 2), (7, 5, 6.5, 2, 2), (7, 5, 6.0, 3, 2), -- Geography
(8, 5, 6.5, 1, 2), (8, 5, 6.0, 2, 2), (8, 5, 6.5, 3, 2), -- English
(9, 5, 6.0, 1, 2), (9, 5, 6.5, 2, 2), (9, 5, 6.0, 3, 2), -- Civic Education
(10, 5, 6.5, 1, 2), (10, 5, 6.0, 2, 2), (10, 5, 6.5, 3, 2), -- Informatics
(11, 5, 6.0, 1, 2), (11, 5, 6.5, 2, 2), (11, 5, 6.0, 3, 2), -- Technology
(12, 5, 6.0, 1, 2), (12, 5, 6.5, 2, 2), (12, 5, 6.0, 3, 2), -- Physical Education
-- Student 6 (Fiona Do), Term 1
(1, 6, 6.5, 1, 1), (1, 6, 6.0, 2, 1), (1, 6, 6.5, 3, 1), -- Mathematics
(2, 6, 6.0, 1, 1), (2, 6, 6.5, 2, 1), (2, 6, 6.0, 3, 1), -- Physics
(3, 6, 6.5, 1, 1), (3, 6, 6.0, 2, 1), (3, 6, 6.5, 3, 1), -- Chemistry
(4, 6, 6.0, 1, 1), (4, 6, 6.5, 2, 1), (4, 6, 6.0, 3, 1), -- Biology
(5, 6, 6.5, 1, 1), (5, 6, 6.0, 2, 1), (5, 6, 6.5, 3, 1), -- Literature
(6, 6, 6.0, 1, 1), (6, 6, 6.5, 2, 1), (6, 6, 6.0, 3, 1), -- History
(7, 6, 6.0, 1, 1), (7, 6, 6.5, 2, 1), (7, 6, 6.0, 3, 1), -- Geography
(8, 6, 6.5, 1, 1), (8, 6, 6.0, 2, 1), (8, 6, 6.5, 3, 1), -- English
(9, 6, 6.0, 1, 1), (9, 6, 6.5, 2, 1), (9, 6, 6.0, 3, 1), -- Civic Education
(10, 6, 6.5, 1, 1), (10, 6, 6.0, 2, 1), (10, 6, 6.5, 3, 1), -- Informatics
(11, 6, 6.0, 1, 1), (11, 6, 6.5, 2, 1), (11, 6, 6.0, 3, 1), -- Technology
(12, 6, 6.0, 1, 1), (12, 6, 6.5, 2, 1), (12, 6, 6.0, 3, 1), -- Physical Education
-- Student 6, Term 2
(1, 6, 6.0, 1, 2), (1, 6, 6.5, 2, 2), (1, 6, 6.0, 3, 2), -- Mathematics
(2, 6, 6.5, 1, 2), (2, 6, 6.0, 2, 2), (2, 6, 6.5, 3, 2), -- Physics
(3, 6, 6.0, 1, 2), (3, 6, 6.5, 2, 2), (3, 6, 6.0, 3, 2), -- Chemistry
(4, 6, 6.0, 1, 2), (4, 6, 6.5, 2, 2), (4, 6, 6.0, 3, 2), -- Biology
(5, 6, 6.0, 1, 2), (5, 6, 6.5, 2, 2), (5, 6, 6.0, 3, 2), -- Literature
(6, 6, 6.5, 1, 2), (6, 6, 6.0, 2, 2), (6, 6, 6.5, 3, 2), -- History
(7, 6, 6.0, 1, 2), (7, 6, 6.5, 2, 2), (7, 6, 6.0, 3, 2), -- Geography
(8, 6, 6.0, 1, 2), (8, 6, 6.5, 2, 2), (8, 6, 6.0, 3, 2), -- English
(9, 6, 6.5, 1, 2), (9, 6, 6.0, 2, 2), (9, 6, 6.5, 3, 2), -- Civic Education
(10, 6, 6.0, 1, 2), (10, 6, 6.5, 2, 2), (10, 6, 6.0, 3, 2), -- Informatics
(11, 6, 6.5, 1, 2), (11, 6, 6.0, 2, 2), (11, 6, 6.5, 3, 2), -- Technology
(12, 6, 6.0, 1, 2), (12, 6, 6.5, 2, 2), (12, 6, 6.0, 3, 2); -- Physical Education

-- Insert Money (Full tuition data for 60 students, 2 terms)
INSERT INTO Money (StudentID, PerID, Value, Paid, Debt) VALUES
-- Term 1 (perId = 1)
(1, 1, 5000000, 5000000, 0),      -- Paid full
(2, 1, 5000000, 3000000, 2000000), -- Partial
(3, 1, 5000000, 0, 5000000),       -- Not paid
(4, 1, 5000000, 5000000, 0),
(5, 1, 5000000, 4000000, 1000000),
(6, 1, 5000000, 5000000, 0),
(7, 1, 5000000, 0, 5000000),
(8, 1, 5000000, 5000000, 0),
(9, 1, 5000000, 2000000, 3000000),
(10, 1, 5000000, 5000000, 0),
(11, 1, 5000000, 5000000, 0),
(12, 1, 5000000, 3000000, 2000000),
(13, 1, 5000000, 0, 5000000),
(14, 1, 5000000, 5000000, 0),
(15, 1, 5000000, 4000000, 1000000),
(16, 1, 5000000, 5000000, 0),
(17, 1, 5000000, 0, 5000000),
(18, 1, 5000000, 5000000, 0),
(19, 1, 5000000, 2000000, 3000000),
(20, 1, 5000000, 5000000, 0),
(21, 1, 5000000, 5000000, 0),
(22, 1, 5000000, 3000000, 2000000),
(23, 1, 5000000, 0, 5000000),
(24, 1, 5000000, 5000000, 0),
(25, 1, 5000000, 4000000, 1000000),
(26, 1, 5000000, 5000000, 0),
(27, 1, 5000000, 0, 5000000),
(28, 1, 5000000, 5000000, 0),
(29, 1, 5000000, 2000000, 3000000),
(30, 1, 5000000, 5000000, 0),
(31, 1, 5000000, 5000000, 0),
(32, 1, 5000000, 3000000, 2000000),
(33, 1, 5000000, 0, 5000000),
(34, 1, 5000000, 5000000, 0),
(35, 1, 5000000, 4000000, 1000000),
(36, 1, 5000000, 5000000, 0),
(37, 1, 5000000, 0, 5000000),
(38, 1, 5000000, 5000000, 0),
(39, 1, 5000000, 2000000, 3000000),
(40, 1, 5000000, 5000000, 0);
