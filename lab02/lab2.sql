use `csd220_tennis_club`;

alter table recreational_member rename to `member`;

insert into `member`(player_number, first_name, last_name, sex, year_joined, phone, email)
select player_number, first_name, last_name, sex, year_joined, phone, email
from competitive_member;

alter table competitive_member
drop column first_name,
drop column last_name,
drop column sex,
drop column year_joined,
drop column phone, 
drop column email;

alter table competitive_member
add foreign key (player_number) references `member`(player_number);


alter table `member`
add `active` bool;

update `member`
set active = 0
where (year(current_timestamp()) - year_joined) > 5;

update `member`
set active = 1
where (year(current_timestamp()) - year_joined) <= 5;