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
  BUILDING AS "Корпус"
, (
    SELECT
      COUNT(*)
    FROM
      DEPARTMENT
    WHERE
      DEPARTMENT."Building" = BUILDING
    OR
      (
        BUILDING                IS NULL
      AND DEPARTMENT."Building" IS NULL
      )
  ) AS "Кол-во кафедр"
,(
    SELECT
      COUNT(DISTINCT FACULTY."FacNo")
    FROM
      FACULTY
    JOIN DEPARTMENT
    ON
      DEPARTMENT."FacNo" = FACULTY."FacNo"
    WHERE
      DEPARTMENT."Building" = BUILDING
    OR
      (
        BUILDING                IS NULL
      AND DEPARTMENT."Building" IS NULL
      )
  ) AS "Кол-во факультетов"
, (
    SELECT
      COUNT(DISTINCT TEACHER."TchNo")
    FROM
      TEACHER
    JOIN DEPARTMENT
    ON
      DEPARTMENT."DepNo" = TEACHER."DepNo"
    WHERE
      DEPARTMENT."Building" = BUILDING
    OR
      (
        BUILDING                IS NULL
      AND DEPARTMENT."Building" IS NULL
      )
  ) AS "Кол-во преподавателей"
, (
    SELECT
      COUNT(DISTINCT TEACHER."Tel")
    FROM
      TEACHER
    JOIN DEPARTMENT
    ON
      DEPARTMENT."DepNo" = TEACHER."DepNo"
    WHERE
      DEPARTMENT."Building" = BUILDING
    OR
      (
        BUILDING                IS NULL
      AND DEPARTMENT."Building" IS NULL
      )
  ) AS "Кол-во телефонов"
FROM
  (
    SELECT DISTINCT
      DEPARTMENT."Building" AS BUILDING
    FROM
      DEPARTMENT
  );