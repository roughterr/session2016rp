--1.  Какова минимальная и максимальная зарплаты  (с учетом ставки и надбавки)
-- среди всех преподавателей-профессоров, принятых на работу в диапазоне дат
-- 01.01.2000-31.12.2002. Столбцы результирующей таблицы должны иметь имена:
-- «МИН зарплата» и «МАКС зарплата»
SELECT
  MIN("Salary" + "Commission") AS "МИН зарплата"
, MAX("Salary" + "Commission") AS "МАКС зарплата"
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
  'Инфо о фак-те компьютерных наук:' AS "Что выводится?"
, COUNT(DISTINCT TEACHER."TchNo")    AS "Кол-во преподавателей"
, COUNT(DISTINCT SUBJECT."SbjNo")    AS "Кол-во дисциплин"
, COUNT(DISTINCT LECTURE."GrpNo")    AS "Кол-во групп"
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
-- 3. Вывести перечень должностей, которые имеют преподаватели факультета,
-- деканом которого является Иванов
SELECT DISTINCT
  TEACHER."Post"
FROM
  TEACHER
JOIN DEPARTMENT
ON
  DEPARTMENT."DepNo" = TEACHER."DepNo"
JOIN FACULTY
ON
  FACULTY."FacNo"= DEPARTMENT."FacNo"
WHERE
  FACULTY."Dean" LIKE '%Ivanov%';
-- 4. Для каждой пары возможных значений преподаватель-группа вывести:
-- - имя преподавателя
-- - номер группы
-- - количество лекций, читаемых этим преподавателем в этой группе
-- - количество предметов, которые читает этот преподаватель этой группе
SELECT DISTINCT
  TEACHER."Name" AS "Имя преподавателя"
, SGROUP."Num"   AS "Номер группы"
, (
    SELECT
      COUNT(*)
    FROM
      LECTURE
    WHERE
      LECTURE."TchNo"   = TEACHER."TchNo"
    AND LECTURE."GrpNo" = L."GrpNo"
  ) AS "Number of lectures"
, (
    SELECT
      COUNT(DISTINCT "SbjNo")
    FROM
      LECTURE
    WHERE
      LECTURE."TchNo"   = TEACHER."TchNo"
    AND LECTURE."GrpNo" = L."GrpNo"
  ) AS "Number of subjects"
FROM
  TEACHER
JOIN LECTURE L
ON
  L."TchNo" = TEACHER."TchNo"
JOIN SGROUP
ON
  SGROUP."GrpNo" = L."GrpNo"
ORDER BY
  TEACHER."Name";
-- 5. По каждому корпусу  вывести следующую информацию в соответствующих
-- столбцах:
-- - номер корпуса. Если корпус NULL, то вывести константу “Нет корпуса” -
-- Корпус
-- - к-во кафедр в корпусе             - Кол-во кафедр
-- - к-во факультетов в корпусе        - Кол-во факультетов
-- - к-во преподавателей в корпусе     - Кол-во преподавателей
-- - к-во номеров телефонов в корпусе  - Кол-во телефонов
SELECT
  DEPARTMENT."Building"              AS "Корпус"
, COUNT(DISTINCT DEPARTMENT."DepNo") AS "Кол-во кафедр"
, COUNT(DISTINCT FACULTY."FacNo")    AS "Кол-во факультетов"
, COUNT(DISTINCT TEACHER."TchNo")    AS "Кол-во преподавателей"
, COUNT(DISTINCT TEACHER."Tel")      AS "Кол-во телефонов"
FROM
  DEPARTMENT
JOIN FACULTY
ON
  FACULTY."FacNo" = DEPARTMENT."FacNo"
LEFT JOIN TEACHER
ON
  TEACHER."DepNo" = DEPARTMENT."DepNo"
GROUP BY
  DEPARTMENT."Building"
ORDER BY
  1;
-- 6. Для каждой тройки значений преподаватель-группа-дисциплина таких, что
-- указанный преподаватель преподает указанной группе указанную дисциплину,
-- вывести
-- - имя преподавателя,
-- - номер группы,
-- - название дисциплины,
-- - количество занятий, которое имеет это этот преподаватель для этой группы
-- по этой дисциплине,
-- при условии, что:
-- - указанный преподаватель преподает указанной группе указанную дисциплину не
-- более, чем в 3-х аудиториях
SELECT
  TEACHER."Name"  AS "Имя преподавателя"
, LECTURE."GrpNo" AS "Номер группы"
, SUBJECT."Name"  AS "Название дисциплины"
, COUNT(*)        AS "Количество занятий"
FROM
  teacher
JOIN lecture
ON
  LECTURE."TchNo" = TEACHER."TchNo"
JOIN SUBJECT
ON
  SUBJECT."SbjNo" = LECTURE."SbjNo"
GROUP BY
  TEACHER."Name"
, LECTURE."GrpNo"
, SUBJECT."Name"
HAVING
  COUNT (DISTINCT LECTURE."RomNo") < 3
ORDER BY
  TEACHER."Name" ;
-- 7. По каждой дисциплине, которая читается преподавателем факультета,
-- расположенном в одном из корпусов 1, 3, 4, 5, 6, 7, 8  вывести
-- - название дисциплины
-- - количество аудиторий, в которых эта дисциплина читается,
-- - количество занятий, которые проводятся  по этой дисциплине
-- при условии, что количество преподавателей, читающих эту дисциплину,
-- находится в диапазоне 1-5. Результат упорядочить по третьему столбцу по
-- возрастанию, по второму столбцу по убыванию и первому столбцу по убыванию.
-- Использовать для этого порядковые номера столбцов результирующей таблицы
SELECT
  SUBJECT."Name"                   AS "Название дисциплины"
, COUNT (DISTINCT LECTURE."GrpNo") AS "Количество аудиторий"
, COUNT (LECTURE."GrpNo")          AS "количество занятий"
FROM
  SUBJECT
LEFT JOIN LECTURE
ON
  LECTURE."SbjNo" = SUBJECT."SbjNo"
LEFT JOIN TEACHER
ON
  TEACHER."TchNo" = LECTURE."TchNo"
LEFT JOIN DEPARTMENT
ON
  DEPARTMENT."DepNo" = TEACHER."DepNo"
WHERE
  DEPARTMENT."Building" IN (1, 3, 4, 5, 6, 7, 8)
GROUP BY
  SUBJECT."Name"
HAVING
  COUNT(DISTINCT TEACHER."TchNo") BETWEEN 1 AND 5
ORDER BY
  2 DESC, 1 DESC;