select name, grade, marks from students join grades on marks between min_mark and max_mark 
and grade >= 8 order by grade desc, name;
select NULL, grade, marks from students join grades on marks between min_mark and max_mark 
and grade < 8 order by grade desc, marks;
