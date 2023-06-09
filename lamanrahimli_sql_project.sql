USE [master]
GO
/****** Object:  Database [JiraService]    Script Date: 6/22/2021 9:09:08 PM ******/
CREATE DATABASE [JiraService]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'JiraService', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.TURINGSQLSERVER\MSSQL\DATA\JiraService.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'JiraService_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.TURINGSQLSERVER\MSSQL\DATA\JiraService_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [JiraService] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JiraService].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JiraService] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JiraService] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JiraService] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JiraService] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JiraService] SET ARITHABORT OFF 
GO
ALTER DATABASE [JiraService] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [JiraService] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JiraService] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JiraService] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JiraService] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JiraService] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JiraService] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JiraService] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JiraService] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JiraService] SET  DISABLE_BROKER 
GO
ALTER DATABASE [JiraService] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JiraService] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JiraService] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JiraService] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JiraService] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JiraService] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [JiraService] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JiraService] SET RECOVERY FULL 
GO
ALTER DATABASE [JiraService] SET  MULTI_USER 
GO
ALTER DATABASE [JiraService] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JiraService] SET DB_CHAINING OFF 
GO
ALTER DATABASE [JiraService] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [JiraService] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [JiraService] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [JiraService] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'JiraService', N'ON'
GO
ALTER DATABASE [JiraService] SET QUERY_STORE = OFF
GO
USE [JiraService]
GO
/****** Object:  Schema [db_board]    Script Date: 6/22/2021 9:09:08 PM ******/
CREATE SCHEMA [db_board]
GO
/****** Object:  Schema [users]    Script Date: 6/22/2021 9:09:08 PM ******/
CREATE SCHEMA [users]
GO
/****** Object:  UserDefinedFunction [db_board].[user_created_task_count]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [db_board].[user_created_task_count] (@user int)
returns int
begin
Declare @Count int
Select @Count = count(task_id) 
from [db_board].[tasks]
where reporter=@user
group by reporter
Return @count
end
GO
/****** Object:  Table [db_board].[comments]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [db_board].[comments](
	[task_id] [int] NULL,
	[user_id_] [int] NULL,
	[comment] [nvarchar](max) NULL,
	[created_date] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [db_board].[files]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [db_board].[files](
	[task_id] [int] NULL,
	[user_id_] [int] NULL,
	[file_path] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [db_board].[shared_with]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [db_board].[shared_with](
	[user_id_] [int] NULL,
	[task_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [db_board].[tasks]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [db_board].[tasks](
	[task_id] [int] IDENTITY(1,1) NOT NULL,
	[status_id] [int] NULL,
	[importance_id] [int] NULL,
	[created_date] [date] NULL,
	[closed_date] [date] NULL,
	[lastupdate] [date] NULL,
	[reporter] [int] NOT NULL,
	[description_] [nvarchar](max) NULL,
	[title] [varchar](50) NULL,
	[assigned] [int] NULL,
	[shw] [int] NULL,
	[comment_num] [int] NULL,
	[file_num] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[task_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [users].[users]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [users].[users](
	[user_id_] [int] IDENTITY(1,1) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[avatar] [image] NULL,
	[email] [varchar](100) NOT NULL,
	[groups] [varchar](100) NULL,
	[password_] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [db_board].[get_user_activity]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE function [db_board].[get_user_activity] (@name varchar(max))
returns table
as 
return 
(
select  distinct t.task_id,u.fullname,t.title,isnull(c.comment,'N\A') [COMMENT], Isnull(f.file_path,'N\A') [file_path]
from [users].[users] u
join [db_board].[tasks] t on t.assigned=u.user_id_ or t.reporter=u.user_id_ or u.user_id_
in (select user_id_ from [db_board].[shared_with])
full join [db_board].[files] f on f.[task_id] = t.task_id and f.user_id_=u.user_id_
full join [db_board].[comments] c on c.[task_id] = t.task_id and c.user_id_=u.user_id_
where u.fullname = @name
)
GO
/****** Object:  View [db_board].[user_info]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [db_board].[user_info]
as
select user_id_,fullname,username,avatar,email,groups,
reverse(stuff(password_,4,len(password_)-3,replicate('*',5))) as [password]
from [users].[users] 
GO
/****** Object:  View [db_board].[task_reporter]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [db_board].[task_reporter]
as
select task_id,u.user_id_,u.fullname from [db_board].[tasks] t
join [users].[users] u
on t.reporter=u.user_id_
GO
/****** Object:  View [db_board].[task_assigned]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [db_board].[task_assigned]
as
select t.task_id,u.user_id_,u.fullname from [db_board].[tasks] t
join [users].[users] u
on t.assigned=u.user_id_
GO
/****** Object:  View [db_board].[all_activities]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [db_board].[all_activities]
as 
select  distinct t.task_id,u.fullname,t.title,isnull(c.comment,'empty') comment, 
isnull(f.file_path,'empty') [file]
from [db_board].[tasks] t
join [users].[users] u on t.assigned=u.user_id_ or t.reporter=u.user_id_ or u.user_id_
in (select user_id_ from [db_board].[shared_with] )
full join [db_board].[comments] c on c.task_id = t.task_id and c.user_id_=u.user_id_
full join  [db_board].[files] f on f.task_id= t.task_id and f.user_id_=u.user_id_
GO
/****** Object:  View [db_board].[users_max_solved_task]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [db_board].[users_max_solved_task]
as
with cte(user_id_,num,count_)
as
(
select  top 3 u.user_id_,row_number() over (order by count(t.task_id) desc),
count(t.task_id)
from [users].[users] u inner join [db_board].[tasks] t
on u.user_id_=t.assigned where t.status_id=3
group by u.user_id_ 
)
select u.fullname,count_,
case  
when num=1 then replicate('*',3)
when num=2 then replicate('*',2)
when num=3 then replicate('*',1)
end as Liga
from cte c join [users].[users] u on u.user_id_=c.user_id_
GO
/****** Object:  View [db_board].[all_board]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [db_board].[all_board]
AS
select s.name
from sys.schemas s
inner join sys.sysusers u on u.uid = s.principal_id
where s.name not in (
'db_accessadmin'
,'db_backupoperator'
,'db_datareader'
,'db_datawriter'
,'db_ddladmin'
,'db_denydatareader'
,'db_denydatawriter'
,'db_owner'
,'db_securityadmin'
,'dbo'
,'guest'
,'INFORMATION_SCHEMA'
,'sys')
GO
/****** Object:  Table [db_board].[importance]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [db_board].[importance](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [db_board].[statuses]    Script Date: 6/22/2021 9:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [db_board].[statuses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [db_board].[comments] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [db_board].[tasks] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [db_board].[comments]  WITH CHECK ADD  CONSTRAINT [FK_comments_tasks] FOREIGN KEY([task_id])
REFERENCES [db_board].[tasks] ([task_id])
GO
ALTER TABLE [db_board].[comments] CHECK CONSTRAINT [FK_comments_tasks]
GO
ALTER TABLE [db_board].[files]  WITH CHECK ADD  CONSTRAINT [FK_files_tasks] FOREIGN KEY([task_id])
REFERENCES [db_board].[tasks] ([task_id])
GO
ALTER TABLE [db_board].[files] CHECK CONSTRAINT [FK_files_tasks]
GO
ALTER TABLE [db_board].[shared_with]  WITH CHECK ADD  CONSTRAINT [FK_shared_with_tasks] FOREIGN KEY([task_id])
REFERENCES [db_board].[tasks] ([task_id])
GO
ALTER TABLE [db_board].[shared_with] CHECK CONSTRAINT [FK_shared_with_tasks]
GO
ALTER TABLE [db_board].[shared_with]  WITH CHECK ADD  CONSTRAINT [FK_shared_with_users] FOREIGN KEY([task_id])
REFERENCES [users].[users] ([user_id_])
GO
ALTER TABLE [db_board].[shared_with] CHECK CONSTRAINT [FK_shared_with_users]
GO
ALTER TABLE [db_board].[tasks]  WITH CHECK ADD  CONSTRAINT [FK_tasks_importance] FOREIGN KEY([importance_id])
REFERENCES [db_board].[importance] ([id])
GO
ALTER TABLE [db_board].[tasks] CHECK CONSTRAINT [FK_tasks_importance]
GO
ALTER TABLE [db_board].[tasks]  WITH CHECK ADD  CONSTRAINT [FK_tasks_statuses] FOREIGN KEY([status_id])
REFERENCES [db_board].[statuses] ([id])
GO
ALTER TABLE [db_board].[tasks] CHECK CONSTRAINT [FK_tasks_statuses]
GO
ALTER TABLE [db_board].[tasks]  WITH CHECK ADD  CONSTRAINT [FK_tasks_users] FOREIGN KEY([status_id])
REFERENCES [users].[users] ([user_id_])
GO
ALTER TABLE [db_board].[tasks] CHECK CONSTRAINT [FK_tasks_users]
GO
/****** Object:  StoredProcedure [db_board].[add_comment]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [db_board].[add_comment] 
(@task int, @user int, @comment nvarchar(max))
as begin
insert into [db_board].[comments] values 
(@task, @user, getdate(), @comment)
end
GO
/****** Object:  StoredProcedure [db_board].[add_file]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [db_board].[add_file]
(@task int , @user int, @file nvarchar(max))
as begin
insert into [db_board].[files] values (@task,@user, @file)
update [db_board].[tasks] set [lastupdate]=getdate() where task_id=@task
end
GO
/****** Object:  StoredProcedure [db_board].[assign_task]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [db_board].[assign_task]
(@task int ,@user int)
as begin
update [db_board].[tasks] set [assigned]=@user where task_id=@task
end
GO
/****** Object:  StoredProcedure [db_board].[change_status]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [db_board].[change_status]
(@task int,@status int)
as begin
declare @closed_date date=null
if @status=3 set @closed_date=getdate()
if @status<=3
update [db_board].[tasks] set [status_id]=@status,closed_date=@closed_date,
lastupdate=getdate()
where task_id=@task
end
GO
/****** Object:  StoredProcedure [db_board].[close_task]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [db_board].[close_task]
(@task int)
as begin
update [db_board].[tasks] 
set [status_id]=3,closed_date=getdate() where [task_id]=@task
end
GO
/****** Object:  StoredProcedure [db_board].[share_task]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [db_board].[share_task] (@task int, @shared int)
as begin 
insert into shared_task values 
(@task, @shared)
update [db_board].[tasks] set lastupdate=getdate() 
where task_id=@task
end
GO
/****** Object:  StoredProcedure [db_board].[task_comments]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [db_board].[task_comments] (@task int)
as begin
select  distinct t.task_id,u.fullname,t.title,isnull(c.comment,'empty') comment 
from [db_board].[tasks] t
join [users].[users] u on t.assigned=u.user_id_ or t.reporter=u.user_id_ or u.user_id_
in (select user_id_ from [db_board].[shared_task])
full join [db_board].[comments] c on c.task_id = t.task_id and c.user_id_=u.user_id_
where t.task_id=@task
end
GO
/****** Object:  StoredProcedure [dbo].[create_new_task]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[create_new_task]
(@status int,@importance int ,@created_date date,@closed_date date,
@lastupdate date,@reporter int ,@description varchar(max),@title varchar(max),
@assigned varchar(max))
as begin
insert into [db_board].[tasks] (status_id,importance_id,created_date,closed_date,
lastupdate,reporter,description_,title,assigned )
values(@status,@importance,iif(@created_date is null,getdate(),
@created_date),@closed_date,
iif(@lastupdate is null,getdate(),@lastupdate),@reporter,@description,@title,@assigned)
end
GO
/****** Object:  StoredProcedure [dbo].[new_user]    Script Date: 6/22/2021 9:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[new_user] 
(@fullname nvarchar(100),@username nvarchar(50),@avatar image,
@email varchar(100),@groups varchar(100),@password_ varchar(50))
as begin
insert into [users].[users]
(fullname,username,avatar,email,groups,password_)
values(@fullname,@username ,iif(@avatar is null,null,@avatar),
@email,iif(@groups is null,null,@groups),@password_ )
end

GO
USE [master]
GO
ALTER DATABASE [JiraService] SET  READ_WRITE 
GO
