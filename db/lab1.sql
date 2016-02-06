--DROP queries
DROP TABLE ROOM;
DROP TABLE SUBJECT;
DROP TABLE SGROUP;
DROP TABLE DEPARTMENT;
DROP TABLE TEACHER;
DROP TABLE FACULTY;
--Faculty
CREATE TABLE FACULTY
  (
    "FacNo"    NUMBER PRIMARY KEY,
    "Name"     VARCHAR2(10) UNIQUE NOT NULL,
    "Building" CHAR(5),
    "Fund"     NUMBER(7, 2) CONSTRAINT FACULTY_POSITIVE_FUND CHECK ("Fund" >= 0)
  );
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (1, 'Aircraft',   '3', 100);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (2, 'History',    '4', 500);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (3, 'Law',        '5', 400);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (4, 'Economics',  '6', 500);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (5, 'Math',       '7', 300);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (6, 'Management', '8', 300);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (7, 'SoftwareEn', '17', 700);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (8, 'Biology',    '1', 100);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (9, 'Chemistry',  '2', 200);
INSERT INTO FACULTY ("FacNo", "Name", "Building", "Fund") VALUES (10, 'Geography', '9', 400);
--Cathedra
CREATE TABLE DEPARTMENT (
    "DepNo" NUMBER PRIMARY KEY,
    "FacNo" NUMBER,
    CONSTRAINT FK_DEPARTMENT_FAC_NO FOREIGN KEY ("FacNo") REFERENCES FACULTY("FacNo") ON DELETE CASCADE,
    "Name"     VARCHAR2(50) NOT NULL,
    "Head"     VARCHAR2(50),
    "Building" NUMBER,
    "Fund"     NUMBER(7, 2) CONSTRAINT DEPARTMENT_POSITIVE_FUND CHECK ("Fund" > 0),
    CONSTRAINT DEPARTMENT_UNIQUE_NAME_HEAD UNIQUE ("Name", "Head")
  );
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (1, 7, 'Department of Computer Science', 'Ivo Bobul', 17, 50);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (2, 7, 'Software of Systems', 'Derechina Olga', 17, 20);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (3, 9, 'Astronomy', 'Eugene Tooz', 2, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (4, 9, 'Chemistry', 'Yana Nyzhegorodova', 2, 30);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (5, 9, 'Materials Science and Metallurgy', 
    'Ksyusha Perevertun', 2, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (6, 9, 'Physics', 'Daniel Molina', 2, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (7, 9, 'Physics', 'Dmitriy Kostash', 2, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (8, 8, 'Biochemistry', 'Asya Subbotina', 1, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (9, 8, 'Pathology', 'Maria Kutsman', 1, 10);
INSERT INTO DEPARTMENT ("DepNo", "FacNo", "Name", "Head", "Building", "Fund") VALUES (10, 5, 
    'Applied Mathematics and Theoretical Physics', 'Evgen Kashyn', 7, 30);
--Teacher
CREATE TABLE TEACHER
  (
    "TchNo" NUMBER PRIMARY KEY,
    "DepNo" NUMBER,
    CONSTRAINT FK_TEACHER_DEP_NO FOREIGN KEY ("DepNo") REFERENCES DEPARTMENT("DepNo") ON DELETE SET NULL,
    "Name" VARCHAR2(50) NOT NULL,
    "Post" VARCHAR2(20),
    CONSTRAINT TEACHER_POST_IN CHECK ("Post" IN ( 'assistant', 'counselor', 'assistant professor', 'professor')),
    "Tel"      CHAR(7),
    "Hiredate" DATE NOT NULL,
    CONSTRAINT TEACHER_HIREDATE_AFTER CHECK ("Hiredate" > DATE '1950-01-01')
  );
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (1,  3, 'Andrey Radionov', 'counselor', 1234567, '02-01-1993');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (2,  3, 'Bogdan Deykalo', 'professor', 1234568, '02-01-1993');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (3,  3, 'Lida Mozgovaya', 'assistant professor', 1234569, '02-01-1991');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (4,  3, 'Ira Navrotskaya', 'assistant', 1234570, '02-01-1991');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (5,  3, 'Ekaterina Shalamay', 'assistant professor', 1234571, '02-01-1991');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (6,  3, 'Natalia Kriminskaya', 'assistant', 1234572, '02-01-1991');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (7,  3, 'Nataliya Gayduk', 'assistant', 1234573, '02-01-1991');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (8,  3, 'Katya Yudenko', 'professor', 1234574, '02-01-1991');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (9,  3, 'Yulia Ryabokon', 'assistant', 1234575, '02-01-1991');
INSERT INTO TEACHER ("TchNo", "DepNo", "Name", "Post", "Tel", "Hiredate") VALUES (10, 3, 'Sergiy Goncharuk', 'assistant', 1234576, '02-01-1991');
--Student group
CREATE TABLE SGROUP
  (
    "GrpNo" NUMBER PRIMARY KEY,
    "DepNo" NUMBER,
    CONSTRAINT FK_SGROUP_DEP_NO FOREIGN KEY ("DepNo") REFERENCES DEPARTMENT("DepNo") ON DELETE SET NULL,
    "Course" NUMBER(1),
    CONSTRAINT SGROUP_COURSE_IN CHECK ("Course" IN (1, 2, 3, 4, 5)),
    "Num"      NUMBER(3),
    "Quantity" NUMBER(2),
    CONSTRAINT SGROUP_QUANTITY_TOFIFTY CHECK ("Quantity" >= 1 AND "Quantity" <= 50),
    "Curator" NUMBER,
    CONSTRAINT FK_SGROUP_CURATOR FOREIGN KEY ("Curator") REFERENCES TEACHER("TchNo") ON DELETE SET NULL,
    "Rating" NUMBER(3)
  );
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (1,  3, 2, 123, 30, 1,  8);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (2,  3, 2, 123, 49, 2,  7);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (3,  3, 2, 123, 49, 3,  12);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (4,  3, 2, 123, 49, 4,  12);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (5,  3, 2, 123, 49, 5,  10);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (6,  3, 2, 123, 49, 6,  12);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (7,  3, 2, 123, 49, 7,  12);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (8,  3, 2, 123, 49, 8,  9);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (9,  3, 2, 123, 49, 9,  5);
INSERT INTO SGROUP ("GrpNo", "DepNo", "Course", "Num", "Quantity", "Curator", "Rating") VALUES (10, 3, 2, 123, 49, 10, 11);
--Subject
CREATE TABLE SUBJECT
  (
    "SbjNo" NUMBER PRIMARY KEY,
    "Name"  VARCHAR2(50) NOT NULL
  );
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (1, 'Operating systems');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (2, 'Databases');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (3, 'Modern programming languages');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (4, 'Networks');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (5, 'Mathematics');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (6, 'Technologies of development');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (7, 'TEC');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (8, 'High Mathematics 3');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (9, 'Psychology');
INSERT INTO SUBJECT ("SbjNo", "Name") VALUES (10, 'English');
--Room
CREATE TABLE ROOM
  (
    "RomNo" NUMBER PRIMARY KEY,
    "Num"   NUMBER(4) NOT NULL,
    "Seats" NUMBER(3),
    CONSTRAINT ROOM_SEATS_LIMIST CHECK ("Seats" >= 1 AND "Seats" <= 300),
    "Floor" NUMBER(2),
    CONSTRAINT ROOM_FLOOR_LIMIT CHECK ("Floor" >= 1 AND "Floor" <= 16),
    "Building" CHAR(5) NOT NULL
  );
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (1, 123, 100, 5, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (2, 111, 80, 16, 8);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (3, 123, 100, 4, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (4, 123, 100, 3, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (5, 123, 25, 2, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (6, 123, 150, 1, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (7, 123, 100, 1, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (8, 123, 30, 1, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (9, 123, 100, 11, 17);
INSERT INTO ROOM ("RomNo", "Num", "Seats", "Floor", "Building") VALUES (10, 123, 15, 4, 17);