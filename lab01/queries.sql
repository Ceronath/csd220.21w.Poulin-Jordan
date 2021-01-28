use `csd220_lab1_jordanpoulin`;

select distinct room_type from room;					-- question 1

select `name` from `building` where ((`opentime` <= '23:59') and (`locktime` > '2:00') and (`locktime` < `opentime`)); -- question 2
/** Try something like this:
 * WHERE
	-- Open 24 hrs
	lock_time IS NULL 
	-- Open from midnight until after 2am
	OR ( open_time < lock_time AND open_time = '0:00' AND lock_time > '2:00')
	-- Open before midnight until after 2am
	OR ( open_time > lock_time AND lock_time >= '2:00')
 */

select * from room where (haswindows > 0);											-- question 3

select count(*) as numrooms from room where (sqfootage > 500);