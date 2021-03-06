--1.
SELECT
  'Аудитория '
  || "RomNo"
  || ' находится на '
  || "Floor"
  || ' этаже корпуса '
  || RTRIM("Building")
  || ' и имеет '
  || "Seats"
  || ' мест' AS "Информация об аудиториях"
FROM
  ROOM;
SELECT
  'Аудитория'     AS "Литерал1",
  "RomNo"         AS "Аудитория",
  'находится на'  AS "Литерал2",
  "Floor"         AS "Этаж",
  'этаже корпуса' AS "Литерал3",
  "Building"      AS "Корпус" ,
  'и имеет'       AS "Литерал4",
  "Seats"         AS "К-во мест",
  'мест'          AS "Литерал5"
FROM
  ROOM;
--2.
SELECT
  LECTURE."Week"   AS "Неделя",
  LECTURE."Day"    AS "ДН",
  LECTURE."Lesson" AS "Пара",
  LECTURE."Type"   AS "Тип",
  LECTURE."GrpNo"
  || ' '
  || SGROUP."Course" AS "ГРП и КРС",
  TEACHER."Name"     AS "Преподаватель"
FROM
  LECTURE
JOIN ROOM
ON
  ROOM."RomNo" = LECTURE."RomNo"
LEFT JOIN SGROUP
ON
  SGROUP."GrpNo" = LECTURE."GrpNo"
LEFT JOIN TEACHER
ON
  TEACHER."TchNo" = LECTURE."TchNo"
WHERE
  ROOM."Num"        = 313
AND ROOM."Building" = 6;
--3.
SELECT
  DEPARTMENT."Head"
FROM
  DEPARTMENT
JOIN TEACHER
ON
  TEACHER."DepNo" = DEPARTMENT."DepNo"
WHERE
  TEACHER."Name" LIKE '%Ivanov';
--4.
SELECT
  FACULTY."Name"
FROM
  FACULTY
JOIN DEPARTMENT
ON
  DEPARTMENT."FacNo" = FACULTY."FacNo"
JOIN TEACHER
ON
  TEACHER."DepNo" = DEPARTMENT."DepNo"
WHERE
  TEACHER."Salary" + TEACHER."Commission" BETWEEN 1000 AND 1500;
--5.
SELECT
  DEPARTMENT."Name"
FROM
  DEPARTMENT
JOIN TEACHER
ON
  TEACHER."DepNo" = DEPARTMENT."DepNo"
JOIN SGROUP
ON
  SGROUP."Curator" = TEACHER."TchNo"
WHERE
  LOWER(DEPARTMENT."Name") LIKE '%p%';
--6.
--TODO
--7.
SELECT
  R."Num"      AS "Название аудитории",
  R."Building" AS "Корпус",
  DS."Name"
FROM
  ROOM R
JOIN LECTURE L
ON
  L."RomNo" = R."RomNo"
JOIN TEACHER T
ON
  T."TchNo" = L."TchNo"
JOIN SGROUP S
ON
  S."GrpNo" = L."GrpNo"
JOIN DEPARTMENT DS
ON
  DS."DepNo" = S."DepNo"
JOIN DEPARTMENT DT
ON
  DT."DepNo" = T."DepNo"
WHERE
  R."Floor"   IN (1, 3, 4, 5, 7, 9, 10)
AND DS."Name" IN ('Pathology', 'Software of Systems')
AND DT."Name" IN ('Pathology', 'Software of Systems');