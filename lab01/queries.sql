use `csd220_lab1_jordanpoulin`;

select distinct room_type from room;					-- question 1

select `name` from `building` where ((`opentime` <= '23:59') and (`locktime` > '2:00') and (`locktime` < `opentime`)); -- question 2

select * from room where (haswindows > 0);											-- question 3

select count(*) as numrooms from room where (sqfootage > 500);