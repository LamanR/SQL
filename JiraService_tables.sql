create table db_board.statuses
(
id int identity(1,1) primary key,
type varchar(50)
)

create table db_board.importance
(
id int identity(1,1) primary key,
type varchar(50)
)

create table db_board.comments
(
task_id int ,
user_id_ int,
comment_text nvarchar(max),
created_date date default(getdate())
)

create table db_board.files
(
task_id int,
user_id_ int,
file_path varchar(max),
)

create table db_board.shared_task
(
user_id_ int,
task_id int
)

create table db_board.tasks
(
task_id int identity(1,1) primary key,
status_id int,
importance_id int,
created_date date default(getdate()),
closed_date date,
lastupdate date,
reporter  int not null,
decription nvarchar(max),
title varchar(50),
assign int,
shw int,
comment_num int,
file_num int

)

create table [users].users
(
user_id_ int identity(1,1) primary key,
fullname nvarchar(100) not null ,
username varchar(50) not null ,
avatar image null,
email varchar(100) not null,
groups varchar(100),
password_ varchar(50)
)





