SELECT s.Name
FROM Students s,
Packages p,
(SELECT Students.ID AS ID, Salary AS Friend_Salary
FROM Students, Friends, Packages
WHERE Students.ID = Friends.ID AND
Friends.Friend_ID = Packages.ID) tmp
WHERE s.ID = tmp.ID AND s.ID = p.ID and tmp.Friend_Salary > p.Salary
ORDER BY tmp.Friend_Salary
