-- 1. По каждому преподавателю выведите его имя и разность между датой приема
-- на
-- работу и деления ставки на надбавку (столбец с именем «Выражение»). Что
-- получается в результате вычисления hiredate - (Salary/Commission)?
SELECT
  "Name",
  CASE
    WHEN "Commission" = 0
    THEN NULL
    ELSE "Hiredate" - ("Salary"/"Commission")
  END AS "Выражение"
FROM
  TEACHER;
DESC TEACHER;
-- 2. По каждой аудитории корпуса 6 вывести ее номер и названия кафедр, на
-- которых проволятся занятия в этой аудитории студентам 1 курса.
SELECT
  ROOM."Num",
  DEPARTMENT."Name"
FROM
  ROOM
JOIN LECTURE
ON
  LECTURE."RomNo" = ROOM."RomNo"
JOIN SGROUP
ON
  SGROUP."GrpNo" = LECTURE."GrpNo"
LEFT JOIN DEPARTMENT
ON
  DEPARTMENT."DepNo" = SGROUP."DepNo"
WHERE
  ROOM."Building"   = 6
AND SGROUP."Course" = 1;
-- 3. Вывести названия факультетов, студентам которых преподают преподаватели
-- кафедры ИПО.
SELECT
  FACULTY."Name"
FROM
  FACULTY
JOIN DEPARTMENT DF
ON
  DF."FacNo" = FACULTY."FacNo"
JOIN SGROUP
ON
  SGROUP."DepNo" = DF."DepNo"
JOIN LECTURE
ON
  LECTURE."GrpNo" = SGROUP."GrpNo"
JOIN TEACHER
ON
  TEACHER."TchNo" = LECTURE."TchNo"
JOIN DEPARTMENT DT
ON
  DT."DepNo" = TEACHER."DepNo"
WHERE
  DT."Name" = 'Software of Systems';
-- 4. Вывести названия факультетов, преподаваетели-профессора которых имеют
-- занятия  на парах в диапазоне 2-6.
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
JOIN LECTURE
ON
  LECTURE."TchNo" = TEACHER."TchNo"
WHERE
  TEACHER."Post" = 'professor'
AND LECTURE."Lesson" BETWEEN 2 AND 6
GROUP BY
  FACULTY."Name";
-- 5. Вывести номера аудиторий и их корпуса, в которых преподаватели-ассистенты
-- проводят занятия типа 'лабораторная' в один из следующих дней: понедельник,
-- середа, четверг, суббота.
SELECT
  ROOM."Num",
  ROOM."Building",
  LECTURE."Day"
FROM
  ROOM
JOIN LECTURE
ON
  LECTURE."RomNo" = ROOM."RomNo"
JOIN TEACHER
ON
  TEACHER."TchNo" = LECTURE."TchNo"
WHERE
  TEACHER."Post"   = 'assistant'
AND LECTURE."Type" = 'lab'
AND LECTURE."Day" IN ('Mon', 'Wed', 'Thu', 'Sat');
-- 6. Вывести пары имен преподавателей,  удовлетворяющих следующему условию:
-- первый преподаватель является куратором группы, имеющей рейтинг больше, чем
-- в два раза, рейтинга группы, куратором которой является второй преподаватель
SELECT
  TEACHERA."Name",
  TEACHERB."Name"
FROM
  SGROUP SGROUPA
FULL JOIN SGROUP SGROUPB
ON
  NOT SGROUPB."GrpNo" = SGROUPA."GrpNo"
LEFT JOIN teacher TEACHERA
ON
  TEACHERA."TchNo" = SGROUPA."Curator"
LEFT JOIN teacher TEACHERB
ON
  TEACHERB."TchNo" = SGROUPB."Curator"
WHERE
  (
    SGROUPB."Rating" * 2
  )
  < SGROUPA."Rating"
ORDER BY
  1;