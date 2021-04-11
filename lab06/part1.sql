
create user lab6 @ 'localhost' identified by '123'; -- question 2

create role superuser; -- question 3

grant all on *.* to superuser; -- question 4

grant superuser to lab6 @ 'localhost'; -- question 5
 
create user lab6 @ '%' identified by '123'; -- question 6

grant select on *.* to lab6 @ '%'; -- question 7

drop user lab6 @ 'localhost'; -- question 8

drop user lab6 @ '%';

drop role superuser;