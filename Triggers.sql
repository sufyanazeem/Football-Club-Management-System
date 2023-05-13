use FOOTBALL


--******************************************************************
/*TRIGGERS*/
--****************************************************************--
--1 Update After on Referee


create table Referee_Audit(
	Referee_Id VARCHAR(255),
	Referee_Name VARCHAR(255) ,
	License_Num VARCHAR(255) ,
	City VARCHAR(255),
	Date date,
	Change_DATE Date
);

alter Trigger Referee_Audit_History
On Referee
After Update
As
Begin 

insert into Referee_Audit(
	Referee_Id ,
	Referee_Name,
	License_Num ,
	City ,
	Date,
	Change_DATE
)
select 
	Referee_Id ,
	Referee_Name,
	License_Num ,
	City ,Date,GETDATE() from inserted i
	end;

select *from Referee_Audit
update Referee set License_Num ='RL998090' where Referee_Id = 'R0024'

--******************************************************************
/*TRIGGERS*/
--****************************************************************--

--2
create table StadiumRecord_Audit(
    Record_Id VARCHAR(255),
	stadium_Name VARCHAR(255),
	Num_of_Goals INT,
	Num_of_Matches INT,
	Stadium_Id VARCHAR(255),
	Team_Id VARCHAR(255),
	Date date,
	Change_Date Date
);

Create Trigger StadiumRecord_Audit_History
On StadiumRecord
After Update
As
Begin
Set Nocount on;
insert into StadiumRecord_Audit(
    Record_Id,
	stadium_Name,
	Num_of_Goals,
	Num_of_Matches,
	Stadium_Id,
	Team_Id,
	Date,
	Change_Date
)

Select 
    Record_Id,
	stadium_Name,
	Num_of_Goals,
	Num_of_Matches,
	Stadium_Id,
	Team_Id,
	Date,
	GETDATE()
from inserted i
end;
Update StadiumRecord Set Num_of_Goals =190 where Record_Id='S0017' 
select *from StadiumRecord_Audit

CREATE TABLE RefereeHistory(
id INT IDENTITY(1,1),
History VARCHAR(200)
)

--******************************************************************
/*TRIGGERS*/
--****************************************************************--
--3
--After Insert Trigger For Referee Table


Alter TRIGGER RefereeAfterInsert
ON Referee
FOR INSERT
AS
	BEGIN
		Declare @id varchar(50)
		Select @id = Referee_Id from inserted

		insert into RefereeHistory
 values('New employee with Id  = ' + @id  + ' is added at ' + cast(Getdate() as nvarchar(200)))

 end
 insert into Referee Values('R9998','Sufyan','RL945917','Hindustan','2020-01-01')
 Select *from RefereeHistory

 CREATE TABLE StadiumRecordHistory(
id INT IDENTITY(1,1),
History VARCHAR(200)
)
--******************************************************************
/*TRIGGERS*/
--****************************************************************--
--4
--After Insert Trigger For Stadium Table


Create TRIGGER StadiumRecordAfterInsert
ON StadiumRecord
FOR INSERT
AS
	BEGIN
		Declare @id varchar(50)
		Select @id = Record_Id from inserted

		insert into StadiumRecordHistory
 values('New employee with Id  = ' + @id  + ' is added at ' + cast(Getdate() as nvarchar(200)))

 end
 select *from StadiumRecordHistory

 insert into StadiumRecord values('S9999','National Stadium',76,67,'S9390','T1198','2011-01-01') 



 --******************************************************************
/*TRIGGERS*/
--****************************************************************--
--5

create table StadiumRecord_Audit_Delete(
    Record_Id VARCHAR(255),
	stadium_Name VARCHAR(255),
	Num_of_Goals INT,
	Num_of_Matches INT,
	Stadium_Id VARCHAR(255),
	Team_Id VARCHAR(255),
	Date date NOT NULL,
	Change_Date DateTime
);

Alter Trigger StadiumRecord_History_Delete On StadiumRecord
After Delete
As
Begin
Set NoCount On;
Insert Into StadiumRecord_Audit_Delete(
	Record_Id,
	stadium_Name,
	Num_of_Goals,
	Num_of_Matches,
	Stadium_Id,
	Team_Id,
	Date,
	Change_Date
)
Select
	Record_Id,
	stadium_Name,
	Num_of_Goals,
	Num_of_Matches,
	Stadium_Id,
	Team_Id,
	Date,
	GetDate()

	From deleted

	End;

	Select * From StadiumRecord

	Select * From StadiumRecord_Audit_Delete

	Drop Procedure StadiumRecord_History

	Delete From StadiumRecord
	Where Record_Id = 'S6164'