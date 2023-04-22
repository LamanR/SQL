
exec [dbo].[new_user] 'Ləman Rəhimli','laman',null,'laman.rahimli@gmail.com',
'analysts','123456789'
exec [dbo].[new_user] 'Kamran Allahverdiyev','kamran',null,'kamran.allahverdiyev@gmail.com',
'designers','kmnkmn9'
exec [dbo].[new_user] 'Mehdi Haqverdiyev','mehdi',null,'mehdi.haqverdi@gmail.com',
'engineers ','engmeh9'
exec [dbo].[new_user] 'Jalə Hacıyeva','zhala',null,'zhala.hajieva@gmail.com',
null,'jaji789'

---insert into [db_board].[statuses]
insert into [db_board].[statuses] (type) values('To do'),('Doing'),('Done')

---insert into [db_board].[importance]
insert into [db_board].[importance] (type) values ('High'),('Low'), ('Medium')
