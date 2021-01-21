drop database if exists `csd220_lab1_jordanpoulin` ; 															/* question 1 */
create database if not exists `csd220_lab1_jordanpoulin` character set utf8mb4 collate utf8mb4_unicode_ci ;		/* question 1, 2 */
use `csd220_lab1_jordanpoulin`;																					/* question 3 */

drop table if exists `csd220_lab1_jordanpoulin`.`building`;										

create table if not exists `csd220_lab1_jordanpoulin`.`building` (												/* question 4 */
	`name` varchar(50) not null,
    `code` char(3) character set 'ascii' collate 'ascii_general_ci' not null,
    `sqfootage` int unsigned not null,
    `floors` int unsigned not null,
    `opentime` time default '06:00:00' not null,
    `locktime` time default '22:00:00' not null,
    primary key (`code`),																						/* 4b.i */
    unique index `name_unique` (`name` asc));
    

drop table if exists `csd220_lab1_jordanpoulin`.`room`;
create table if not exists `csd220_lab1_jordanpoulin`.`room` (
	`build_code` char(3) character set 'ascii' collate 'ascii_general_ci' not null,
	`room_number` int unsigned not null,
    `floor` int unsigned not null,
    `room_type` varchar(20) not null,
    constraint check_room check(room_type = 'classroom' or room_type ='lecture hall' or
    room_type ='lab' or room_type= 'office' or room_type= 'bathroom' or room_type= 'utility'),
    `sqfootage` int unsigned not null,
    `haswindows` bool not null,
    primary key(`build_code`, `room_number`),
    foreign key (`build_code`) references `csd220_lab1_jordanpoulin`.`building`(`code`)
    on delete cascade
    on update cascade);

insert into `building` (`name`, `code`, `sqfootage`, `floors`, `opentime`, `locktime`) values
	('Big Building', 'BB1', 2000, 4, '01:00:00', '12:00:00'),
    ('Bigger Building', 'BB2', 4000, 6, '10:00:00', '21:00:00'),
    ('Biggest Building', 'BB3', 8000, 10, '11:00:00', '23:00:00');
		
insert into `room` (`build_code`, `room_number`, `floor`, `room_type`, `sqfootage`, `haswindows`) values
	('BB1', 3, 2, 'lab', 300, 0),
    ('BB2', 5, 5, 'office', 900, 1),
    ('BB3', 10, 9, 'lecture hall', 2000, 0);
    
    select * from `room`;