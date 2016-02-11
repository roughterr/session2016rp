-- 1. Вывести имена подчиненных заведующего кафедрой ИПО, которые (подчиненные)
-- имеют ставку (salary), не совпадающую ни с одной из ставок преподавателей
-- кафедры КИТ, ИЛИ надбавку (commission), также не совпадающую ни с одной из
-- надбавок преподавателей кафедры КИТ
SELECT
  T1."Name"
FROM
  TEACHER T1
INNER JOIN DEPARTMENT
ON
  DEPARTMENT."DepNo" = T1."DepNo"
INNER JOIN FACULTY
ON
  FACULTY."FacNo" = DEPARTMENT."FacNo"
WHERE
  NOT T1."Post"    = 'counselor'
AND FACULTY."Name" = 'Chemistry'
AND
  (
    (
      SELECT
        COUNT(*)
      FROM
        TEACHER T2
      INNER JOIN DEPARTMENT
      ON
        DEPARTMENT."DepNo" = T2."DepNo"
      WHERE
        T2."Salary"         = T1."Salary"
      AND DEPARTMENT."Name" = 'Pathology'
    )
    = 0
  OR
    (
      SELECT
        COUNT(*)
      FROM
        TEACHER T2
      INNER JOIN DEPARTMENT
      ON
        DEPARTMENT."DepNo" = T2."DepNo"
      WHERE
        T2."Commission"         = T1."Commission"
      AND DEPARTMENT."Name" = 'Pathology'
    )
    = 0
  );
SELECT
  COUNT(*)
FROM
  TEACHER T2
WHERE
  T2."Salary" = 2500;
-- 2. Вывести кафедры и их корпуса факультета компьютерных наук, которые (
-- кафедры) располагаются в корпусе, отличающемся от корпуса факультета
-- компьютерных наук
SELECT
  DEPARTMENT."Name"
, DEPARTMENT."Building"
FROM
  DEPARTMENT
INNER JOIN FACULTY
ON
  FACULTY."FacNo" = DEPARTMENT."FacNo"
WHERE
  NOT FACULTY."Building" = DEPARTMENT."Building"
AND FACULTY."Name"       = 'SoftwareEn';
-- 3. Вывести названия кафедр факультета, деканом которого является Иванов, на
-- которых (кафедрах) нет ни одного преподавателя-профессора
SELECT DISTINCT
  D1."Name"
FROM
  DEPARTMENT D1
INNER JOIN FACULTY
ON
  FACULTY."FacNo" = D1."FacNo"
WHERE
  (
    SELECT
      COUNT(*)
    FROM
      TEACHER
    INNER JOIN DEPARTMENT D2
    ON
      D2."DepNo" = TEACHER."DepNo"
    WHERE
      TEACHER."Post" = 'professor'
    AND D1."DepNo"   = D2."DepNo"
  )
  = 0
AND FACULTY."Dean" LIKE '%Ivanov%';
-- 4. Вывести названия кафедр факультета компьютерных наук, которые расположены
-- в одном из корпусов, в которых проводят занятия преподаватели кафедры ИПО
SELECT DISTINCT
  D1."Name"
, D1."Building"
FROM
  DEPARTMENT D1
INNER JOIN FACULTY
ON
  FACULTY."FacNo" = D1."FacNo"
INNER JOIN ROOM
ON
  ROOM."Building" = D1."Building"
INNER JOIN LECTURE
ON
  LECTURE."RomNo" = ROOM."RomNo"
INNER JOIN TEACHER
ON
  TEACHER."TchNo" = LECTURE."TchNo"
INNER JOIN DEPARTMENT D2
ON
  D2."DepNo" = TEACHER."DepNo"
WHERE
  FACULTY."Name" = 'SoftwareEn'
AND D2."Name"    = 'Physics';
-- 5. Вывести названия факультетов, на которых  значение зарплаты (salary+
-- commission) всех преподавателей-профессоров превышает более, чем на 10000
-- суммарное значение зарплаты всех преподавателей-доцентов факультета
-- компьютерных наук.
SELECT DISTINCT
  F1."Name"
FROM
  FACULTY F1
WHERE
  (
    SELECT
      SUM (TEACHER."Salary" + TEACHER."Commission")
    FROM
      TEACHER
    INNER JOIN DEPARTMENT
    ON
      DEPARTMENT."DepNo" = TEACHER."DepNo"
    INNER JOIN FACULTY F2
    ON
      F2."FacNo" = DEPARTMENT."FacNo"
    WHERE
      TEACHER."Post" = 'professor'
    AND F2."FacNo"   = F1."FacNo"
  )
  + 10000 >
  (
    SELECT
      SUM (TEACHER."Salary" + TEACHER."Commission")
    FROM
      TEACHER
    INNER JOIN DEPARTMENT
    ON
      DEPARTMENT."DepNo" = TEACHER."DepNo"
    INNER JOIN FACULTY F2
    ON
      F2."FacNo" = DEPARTMENT."FacNo"
    WHERE
      F2."Name"        = 'Biology'
    AND TEACHER."Post" = 'assistant'
  );
-- 6. Вывести минимальную дату приема на работу, вместе с именем этого
-- преподавателя, и максимальную дату приема на работу, также вместе с именем
-- этого преподавателя.
SELECT DISTINCT
  'Минимальна дата приема' AS "#"
, T1."Hiredate" "Дата приема"
, T1."Name" AS "Имя преподавателя"
FROM
  TEACHER T1
WHERE
  T1."Hiredate" =
  (
    SELECT
      MIN (T2."Hiredate")
    FROM
      TEACHER T2
  )
UNION ALL
SELECT DISTINCT
  'Максимальная дата приема' AS "#"
, T1."Hiredate" "Дата приема"
, T1."Name" AS "Имя преподавателя"
FROM
  TEACHER T1
WHERE
  T1."Hiredate" =
  (
    SELECT
      MAX (T2."Hiredate")
    FROM
      TEACHER T2
  );
-- 7. По каждому факультету вывести
-- - название факультета
-- - количество дисциплин, изучаемых студентами факультета
-- - количество дисциплин, преподаваемых преподавателями факультета
SELECT
  "Name" AS "название факультета"
, (
    SELECT
      COUNT(DISTINCT SUBJECT."SbjNo")
    FROM
      SUBJECT
    INNER JOIN LECTURE
    ON
      LECTURE."SbjNo" = SUBJECT."SbjNo"
    INNER JOIN SGROUP
    ON
      SGROUP."GrpNo" = LECTURE."GrpNo"
    INNER JOIN DEPARTMENT
    ON
      DEPARTMENT."DepNo" = SGROUP."DepNo"
    INNER JOIN FACULTY F2
    ON
      F2."FacNo" = DEPARTMENT."FacNo"
    WHERE
      F2."FacNo" = F1."FacNo"
  ) AS "количество изучаемых дисциплин"
, (
    SELECT
      COUNT(DISTINCT SUBJECT."SbjNo")
    FROM
      SUBJECT
    INNER JOIN LECTURE
    ON
      LECTURE."SbjNo" = SUBJECT."SbjNo"
    INNER JOIN TEACHER
    ON
      TEACHER."TchNo" = LECTURE."TchNo"
    INNER JOIN DEPARTMENT
    ON
      DEPARTMENT."DepNo" = TEACHER."DepNo"
    INNER JOIN FACULTY F3
    ON
      F3."FacNo" = DEPARTMENT."FacNo"
    WHERE
      F3."FacNo" = F1."FacNo"
  ) AS "количество преподаваемых д"
FROM
  FACULTY F1;