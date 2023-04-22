create view [db_board].[user_info]
as
select user_id_,fullname,username,avatar,email,groups,
reverse(stuff(password_,4,len(password_)-3,replicate('*',5))) as [password]
from [users].[users] 

create view [db_board].[task_reporter]
as
select task_id,u.user_id_,u.fullname from [db_board].[tasks] t
join [users].[users] u
on t.reporter=u.user_id_

create view [db_board].[task_assigned]
as
select t.task_id,u.user_id_,u.fullname from [db_board].[tasks] t
join [users].[users] u
on t.assigned=u.user_id_

create view [db_board].[all_activities]
as 
select  distinct t.task_id,u.fullname,t.title,isnull(c.comment,'empty') comment, 
isnull(f.file_path,'empty') [file]
from [db_board].[tasks] t
join [users].[users] u on t.assigned=u.user_id_ or t.reporter=u.user_id_ or u.user_id_
in (select user_id_ from [db_board].[shared_with] )
full join [db_board].[comments] c on c.task_id = t.task_id and c.user_id_=u.user_id_
full join  [db_board].[files] f on f.task_id= t.task_id and f.user_id_=u.user_id_

create view [db_board].[task_shared]
as
select t.task_id , u.fullname t.shw
from [db_board].[tasks] t
join [db_board].[shared_with] s on t.task_id=s.task_id 
join [users].[users] u on u.user_id_=s.user_id_


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







