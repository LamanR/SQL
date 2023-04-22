create proc [db_board].[add_comment] 
(@task int, @user int, @comment nvarchar(max))
as begin
insert into [db_board].[comments] values 
(@task, @user, getdate(), @comment)
end

create proc [db_board].[add_file]
(@task int , @user int, @file nvarchar(max))
as begin
insert into [db_board].[files] values (@task,@user, @file)
update [db_board].[tasks] set [lastupdate]=getdate() where task_id=@task
end

create proc [db_board].[assign_task]
(@task int ,@user int)
as begin
update [db_board].[tasks] set [assigned]=@user where task_id=@task
end

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

create proc [db_board].[close_task]
(@task int)
as begin
update [db_board].[tasks] 
set [status_id]=3,closed_date=getdate() where [task_id]=@task
end


create proc create_new_task
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


create proc new_user 
(@fullname nvarchar(100),@username nvarchar(50),@avatar image,
@email varchar(100),@groups varchar(100),@password_ varchar(50))
as begin
insert into [users].[users]
(fullname,username,avatar,email,groups,password_)
values(@fullname,@username ,iif(@avatar is null,null,@avatar),
@email,iif(@groups is null,null,@groups),@password_ )
end



CREATE proc [db_board].[share_task] (@task int, @shared int)
as begin 
insert into shared_task values 
(@task, @shared)
update [db_board].[tasks] set lastupdate=getdate() 
where task_id=@task
end


create proc [db_board].[task_comments] (@task int)
as begin
select  distinct t.task_id,u.fullname,t.title,isnull(c.comment,'empty') comment 
from [db_board].[tasks] t
join [users].[users] u on t.assigned=u.user_id_ or t.reporter=u.user_id_ or u.user_id_
in (select user_id_ from [db_board].[shared_task])
full join [db_board].[comments] c on c.task_id = t.task_id and c.user_id_=u.user_id_
where t.task_id=@task
end


create proc [db_board].[task_files] (@task int)
as begin
select  distinct t.task_id,u.fullname,t.title, 
isnull(f.file_path,'empty') [file]
from [db_board].[tasks] t
join [users].[users] u on t.assigned=u.user_id_ or t.reporter=u.user_id_ or u.user_id_
in (select user_id_ from [db_board].[shared_task] )
full join  [db_board].[files] f on f.task_id= t.task_id and f.user_id_=u.user_id_
where t.task_id=@task
end






