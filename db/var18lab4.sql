--1.  Какова минимальная и максимальная зарплаты  (с учетом ставки и надбавки)
-- среди всех преподавателей-профессоров, принятых на работу в диапазоне дат
-- 01.01.2000-31.12.2002. Столбцы результирующей таблицы должны иметь имена:
-- «МИН зарплата» и «МАКС зарплата»
SELECT
  MIN("Salary" + "Commission") AS "МИН зарплата",
  MAX("Salary" + "Commission") AS "МАКС зарплата"
FROM
  TEACHER
WHERE
  "Post" = 'professor'
AND "Hiredate" BETWEEN '01-01-2000' AND '31-12-2002';
-- 2.  По всем преподавателям, занимающим должности профессоров или доцентов
-- или ассистентов, факультета 'компьютерные науки' вывести следующую
-- информацию под соответствующими именами столбцов:
-- - строковая константа 'Инфо о фак-те компьютерных наук:' - Что выводится?
-- - количество таких преподавателей    - Кол-во преподавателей
-- - Количество читаемых ими дисциплин   -  Кол-во дисциплин
-- - Количество групп, в которых они проводят занятия - Кол-во групп
SELECT
  'Инфо о фак-те компьютерных наук:' AS "Что выводится?",
  COUNT(DISTINCT TEACHER."TchNo")    AS "Кол-во преподавателей",
  COUNT(DISTINCT SUBJECT."SbjNo")    AS "Кол-во дисциплин",
  COUNT(DISTINCT LECTURE."GrpNo")    AS "Кол-во групп"
FROM
  TEACHER
JOIN DEPARTMENT
ON
  DEPARTMENT."DepNo" = TEACHER."DepNo"
JOIN FACULTY
ON
  FACULTY."FacNo" = DEPARTMENT."FacNo"
JOIN LECTURE
ON
  LECTURE."TchNo" = TEACHER."TchNo"
JOIN SUBJECT
ON
  SUBJECT."SbjNo" = LECTURE."SbjNo"
WHERE
  FACULTY."Name"    = 'Chemistry'
AND TEACHER."Post" IN ('counselor', 'professor', 'assistant professor');