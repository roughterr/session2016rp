-- 1. По каждому преподавателю выведите его имя и разность между датой приема
-- на
-- работу и деления ставки на надбавку (столбец с именем «Выражение»). Что
-- получается в результате вычисления hiredate - (Salary/Commission)?
SELECT
  "Name"
, CASE
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
  ROOM."Num"
, DEPARTMENT."Name"
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
  ROOM."Num"
, ROOM."Building"
, LECTURE."Day"
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
  TEACHERA."Name"
, TEACHERB."Name"
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
-- 7. Вывести имена преподавателей и дату поступления их на работу, которые
-- удовлетворяют следующему условию:
-- их ставка (salary) больше 2000 или их надбавка (commission) больше одной
-- четвертой части ставки И
-- их непосредственный руководитель был принят на работу либо в диапазоне дат
-- 01.01.1995-31.12.1996 либо в диапазоне дат 01.01.1998-07.08.1999 И
-- их непосредственный подчиненный либо является ассистентом либо имеет
-- зарплату (salary+commission) в диапазоне 2000-3000
-- a counselor is a manager of a professor
-- a professor is a manager of an assistant professor
-- an assistant professor is a manager of an assistant
SELECT
  T1."Name"
, T1."Hiredate"
FROM
  TEACHER T1
INNER JOIN DEPARTMENT D1
ON
  D1."DepNo" = T1."DepNo"
WHERE
  --counselor has no manager
  NOT T1."Post"   = 'counselor'
AND NOT T1."Post" = 'assistant'
AND
  (
    T1."Salary"      > 2000
  OR T1."Commission" > (T1."Salary" / 4)
  )
AND
  (
    (
      SELECT
        COUNT(*)
      FROM
        TEACHER T2
      INNER JOIN DEPARTMENT D2
      ON
        D2."DepNo" = T2."DepNo"
      WHERE
        T2."Post" =
        CASE
          WHEN T2."Post" = 'assistant professor'
          THEN 'professor'
          ELSE 'counselor'
        END
      AND T2."Hiredate" BETWEEN '01-01-1998' AND '07-08-1999'
      AND D2."DepNo" = D1."DepNo"
    )
    > 0
  )
AND
  (
    SELECT
      COUNT(*)
    FROM
      TEACHER T3
    INNER JOIN DEPARTMENT D3
    ON
      D3."DepNo" = T3."DepNo"
    WHERE
      T3."Post" = 'assistant professor'
    OR
      (
        T3."Post" =
        CASE
          WHEN T3."Post" = 'counselor'
          THEN 'professor'
          ELSE 'assistant professor'
        END
      AND
        (
          T3."Salary" + T3."Commission" BETWEEN 2000 AND 3000
        )
      AND D3."DepNo" = D1."DepNo"
      )
  )
  > 0;