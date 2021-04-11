drop table "user";
create table "user" (
	id INTEGER PRIMARY KEY NOT NULL,
	username TEXT UNIQUE NOT NULL,
	password TEXT NOT NULL
);