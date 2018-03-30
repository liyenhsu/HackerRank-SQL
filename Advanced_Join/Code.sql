-- Projects

SELECT Start_Date, MIN(End_Date)
FROM
(SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
(SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b
WHERE Start_Date < End_Date
GROUP BY Start_Date
ORDER BY DATEDIFF(MIN(End_Date), Start_Date), Start_Date;

-- Placements

SELECT s.Name
FROM Students s,
Packages p,
(SELECT Students.ID AS ID, Salary AS Friend_Salary
FROM Students, Friends, Packages
WHERE Students.ID = Friends.ID AND
Friends.Friend_ID = Packages.ID) tmp
WHERE s.ID = tmp.ID AND s.ID = p.ID and tmp.Friend_Salary > p.Salary
ORDER BY tmp.Friend_Salary;

-- Symmetric Pairs

set @a = 0;
set @b = 0;

SELECT DISTINCT a.X, a.Y 
FROM (SELECT @a := @a + 1 AS row, X, Y FROM Functions) a,
(SELECT @b := @b + 1 AS row, X, Y FROM Functions) b
WHERE a.X = b.Y AND a.Y = b.X AND a.X <= a.Y AND a.row <> b.row
ORDER BY a.X;


-- Interviews

SELECT Contests.*,
tmp1.S,
tmp1.A,
tmp2.V,
tmp2.U
FROM Contests,
(SELECT Contests.contest_id as id,
SUM(total_submissions) as S,
SUM(total_accepted_submissions) as A
FROM Contests, Colleges, Challenges, Submission_Stats
WHERE Contests.contest_id = Colleges.contest_id AND Colleges.college_id = Challenges.college_id AND
Challenges.challenge_id = Submission_Stats.challenge_id
GROUP BY 1) tmp1,
(SELECT Contests.contest_id as id,
SUM(total_views) as V,
SUM(total_unique_views) as U
FROM Contests, Colleges, Challenges, View_Stats
WHERE Contests.contest_id = Colleges.contest_id AND Colleges.college_id = Challenges.college_id AND
Challenges.challenge_id = View_Stats.challenge_id
GROUP BY 1) tmp2
WHERE Contests.contest_id = tmp1.id AND Contests.contest_id = tmp2.id AND 
tmp1.S + tmp1.A + tmp2.V + tmp2.U > 0


-- 15 Days of Learning SQL

-- This is too hard




-- Mock Interview with Huang

/*

table 1: UserID, Country 
table 2: Time, UserID, Impression, Click, Device

*/


SELECT Device,
       Country,
       ROW_NUMBER() OVER (PARTITION BY Device ORDER BY CTR DESC) AS CTR_RANK ,
       CTR
FROM (SELECT Device, Country, SUM(Click)/SUM(Impression) AS CTR
      FROM table1, table2
      WHERE table1.UserID = table2.UserID
      GROUP BY Device, Country) tmp
WHERE CTR_RANK <= 3
ORDER BY Device, CTR_RANK

