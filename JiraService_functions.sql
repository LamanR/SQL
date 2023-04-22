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

