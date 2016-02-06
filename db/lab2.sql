--INSERT queries
--FACULTY TABLE
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (1, 'Aircraft',   '3', 100);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (2, 'History',    '4', 500);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (3, 'Law',        '5', 400);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (4, 'economy',  '6', 500);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (5, 'Math',       '7', 300);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (6, 'Management', '8', 300);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (7, 'SoftwareEn', '17', 700);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (8, 'Biology',    '1', 100);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (9, 'Chemistry',  '2', 200);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (10, 'Geography', '9', 400);
--Cathedra
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (1, 7, 'Department of Computer Science', 'Ivo Bobul', 17, 50);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (2, 7, 'Software of Systems', 'Derechina Olga', 17, 20);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (3, 9, 'Astronomy', 'Eugene Tooz', 2, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (4, 9, 'Chemistry', 'Yana Nyzhegorodova', 2, 30);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (5, 9, 'Materials Science and Metallurgy', 'Ksyusha Perevertun', 2, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (6, 9, 'Physics', 'Daniel Molina', 2, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (7, 9, 'Physics', 'Dmitriy Kostash', 2, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (8, 8, 'Biochemistry', 'Asya Subbotina', 1, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (9, 8, 'Pathology', 'Maria Kutsman', 1, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (10, 5, 'Applied Mathematics and Theoretical Physics', 'Evgen Kashyn', 7, 30);
--TEACHER table
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (1,  3, 'Andrey Radionov', 'counselor', 1234567, '02-01-1993', 9000);
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (2,  3, 'Bogdan Deykalo', 'professor', 1234568, '02-01-1993', 3000);
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (3,  6, 'Lida Mozgovaya', 'assistant professor', 1234569, '02-01-1991', 2000);
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (4,  9, 'Ira Navrotskaya', 'assistant', 1234570, '02-01-1991', 2000);
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (5,  3, 'Ekaterina Shalamay', 'assistant professor', 1234571, '02-01-1991', 2000);
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (6,  3, 'Natalia Kriminskaya', 'assistant', 1234572, '02-01-1991', 2000);
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (7,  3, 'Nataliya Gayduk', 'assistant', 1234573, '02-01-1991', 2000);
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (8,  3, 'Katya Yudenko', 'professor', 1234574, '02-01-1991', 3000);
INSERT INTO TEACHER
  ( "TchNo",
    "DepNo",
    "Name",
    "Post",
    "Tel",
    "Hiredate",
    "Salary",
    "Commission")
  VALUES
  ( 9,
    3,
    'Yulia Ryabokon',
    'assistant',
    1234575,
    '02-01-1991',
    900,
    400);
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate", "Salary") VALUES (10, 3, 'Sergiy Ivanov', 'assistant', 1234576, '02-01-1991', 2000);
--SGROUP table
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (1,  3, 2, 123, 30, 1,  8);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (2,  3, 2, 123, 49, 2,  7);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (3,  6, 2, 123, 49, 3,  12);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (4,  9, 1, 123, 49, NULL,  12);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (5,  3, 2, 123, 49, 5,  10);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (6,  3, 1, 123, 49, 6,  12);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (7,  3, 1, 123, 49, 7,  12);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (8,  3, 2, 123, 49, 8,  9);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (9,  3, 2, 123, 49, 9,  5);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (10, 3, 2, 123, 49, 10, 11);
--SUBJECT table
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (1, 'Operating Systems');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (2, 'Databases');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (3, 'Modern programming languages');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (4, 'Networks');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (5, 'Mathematics');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (6, 'internet');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (7, 'TEC');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (8, 'High Mathematics 3');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (9, 'Psychology');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (10, 'English');
--ROOM table
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (1, 313, 30, 3, 6);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (2, 313, 80, 3, 7);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (3, 423, 100, 4, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (4, 123, 100, 1, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (5, 540, 100, 5, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (6, 123, 150, 1, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (7, 123, 100, 1, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (8, 123, 25, 1, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (9, 123, 100, 1, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (10, 123, 15, 1, 17);
--LECTURE table
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (2, 1,    1, 1, 'lection', 'Mon', 1, 1);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (2, 1,    1, 1, 'lection', 'Mon', 1, 2);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (NULL, 1,    1, 1, 'lection', 'Wed', 1, 3);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (2, NULL, 1, 1, 'lection', 'Mon', 1, 4);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (8, 1,    1, 2, 'practice','Mon', 1, 5);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (2, 1,    1, 4, 'lection', 'Tue', 1, 1);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (2, 1,    1, 4, 'lab',     'Tue', 1, 2);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (2, 1,    1, 4, 'lab',     'Tue', 1, 3);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (2, 1,    1, 4, 'lab',     'Tue', 1, 4);
INSERT INTO LECTURE ("TchNo", "GrpNo", "SbjNo", "RomNo", "Type", "Day", "Week", "Lesson") VALUES (2, 1,    1, 4, 'lab',     'Tue', 1, 5);
--Updating rows in tables
UPDATE FACULTY SET "Dean"='Bob', "Fund"=3467.00 WHERE "Name"='economy';
UPDATE DEPARTMENT SET "Head"='Frank', "Building"=3 WHERE "DepNo" = 3;
UPDATE TEACHER A
SET "Commission" =
  (
    SELECT "Commission" * 0.25
    FROM TEACHER B
    WHERE B."TchNo" = A."TchNo"
  )
WHERE "Post" = 'assistant';
UPDATE SGROUP SET "Rating"=0 WHERE "Course" = 1;
UPDATE SUBJECT SET "Name"='html' WHERE "Name"='internet';