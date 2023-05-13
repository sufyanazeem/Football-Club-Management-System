use FOOTBALL


--******************************************************************
/*PROCEDURES*  IHSAN*/
--****************************************************************--
--1
CREATE PROCEDURE Team_Played_Macth_City
@from date,
@to date,
@teamName varchar(255)
AS 
BEGIN
SELECT dbo.Team.Team_Name AS[TEAM NAME],dbo.StadiumRecord.stadium_Name [STADIUM NAME],
SUM(dbo.StadiumRecord.Num_of_Matches)AS [TOTAL MATCHES PLAYED],
dbo.Team.Date AS[DATE]

FROM dbo.Team INNER JOIN dbo.StadiumRecord ON 
dbo.Team.Team_Id=dbo.StadiumRecord.Team_Id
GROUP BY Team.Team_Name,dbo.StadiumRecord.stadium_Name,dbo.StadiumRecord.Num_of_Matches,dbo.Team.Date
HAVING dbo.Team.Date BETWEEN @from AND @to AND dbo.Team.Team_Name=@teamName
END

DROP PROCEDURE Team_Played_Macth_City

EXEC Team_Played_Macth_City '2017-01-02' ,'2017-12-20','Washington Football Team'


--******************************************************************
/*PROCEDURES*   SUFYAN*/		
--****************************************************************--
--2

CREATE PROCEDURE Referee_Record
@fromDate date,
@toDate  date,
@stdName varchar(255)
AS
BEGIN

SELECT  
dbo.Referee.Referee_Id AS[REFEREE ID],dbo.Referee.Referee_Name AS[REFEREE NAME],
dbo.Stadium.Stadium_Name AS[STADIUM NAME],dbo.MatchGoals.Num_Goals AS [NUMBER OF GOALS],
dbo.Match.Date AS[DATE]

FROM dbo.Match 
INNER JOIN dbo.Referee ON Referee.Referee_Id = Match.Referee_Id
INNER JOIN dbo.Stadium ON dbo.Referee.Referee_Id=dbo.Stadium.Referee_Id 
INNER JOIN  dbo.MatchGoals ON dbo.MatchGoals.Referee_Id=dbo.Referee.Referee_Id

WHERE 
dbo.Match.Date 
BETWEEN @fromDate AND @toDate
AND dbo.Stadium.Stadium_Name=@stdName

END

DROP PROCEDURE Referee_Record

EXEC Referee_Record '2007-02-25 ','2012-07-06' ,'Joe Robbie Stadium'

--*******************************************************************
/*PROCEDURES	Sufyan*/
--****************************************************************--
--3

CREATE PROCEDURE stadiumRecordProcedure
@stdId varchar(255)
AS
BEGIN
select Stadium.stadium_id AS[STADIUM ID],Stadium.stadium_name AS[STADIUM NAME],
Stadium.city AS[STADIUM CITY],Stadium.capacity AS[STADIUM CAPACITY],
Stadium.pitch_type AS[PITCH TYPE],StadiumRecord.num_of_goals AS[NUMBER OF GOALS],
StadiumRecord.num_of_matches AS[NUMBER OF MATCHES]
FROM Stadium 
INNER JOIN  StadiumRecord  
ON Stadium.stadium_id=StadiumRecord.stadium_id

WHERE Stadium.stadium_id=@stdId
END

DROP PROCEDURE stadiumRecordProcedure

EXEC stadiumRecordProcedure 'S0421'


--******************************************************************
/*PROCEDURES			IHSAN	*/
--****************************************************************--
--4
CREATE PROCEDURE teamPlayerRecord
@teamId varchar(255)
AS
BEGIN
select Team.team_id AS[TEAM ID],Team.team_name AS [TEAM NAME],Players.player_name AS [PLAYER NAME],
Players.player_position AS [PLAYER POSITION],Players.player_speed AS [PLAYER SPEED],
Coach.coach_Name AS [COACH NAME],Coach.license_num AS [COACH LICENSE],Coach.coach_nationality AS [COACH NATIONALITY],
Coach.coach_salary AS [COACH SALARY]
FROM Team INNER JOIN Players
ON Team.team_id=Players.team_id
INNER JOIN Coach 
ON Coach.team_id=Team.team_id

WHERE Team.team_id=@teamId
END
DROP PROCEDURE teamPlayerRecord

EXEC teamPlayerRecord 'T0617'


--******************************************************************
/*PROCEDURES		IHSAN*/
--****************************************************************--
--5

CREATE PROCEDURE RegisteredPlayers
@from date,
@to date
AS
BEGIN
select Players.player_id AS[PLAYER ID],Players.player_name AS [PLAYER NAME],
Registeration.fatherName AS[FATHER NAME],
Players.CNIC,Players.dob AS DOB,Players.Date AS [DATE]
FROM Registeration
INNER JOIN Players 
On Registeration.reg_id=Players.reg_id

WHERE Players.Date BETWEEN @from AND  @to

END 

drop procedure RegisteredPlayers
EXEC RegisteredPlayers '2003-04-04','2003-12-04'

--******************************************************************
/*PROCEDURES		Sufyan*/
--****************************************************************--
--6
CREATE PROCEDURE teamPlayer
@teamId varchar(255)
AS
BEGIN
select t.Team_Id AS[TEAM ID],t.Team_Name AS[TEAM NAME],t.City AS[TEAM CITY],
t.Team_Coach AS[TEAM COACH],t.No_Matches AS[NUMBER OF MATCHES],
p.Player_Id AS[PLAYER ID],p.Player_Name AS[PLAYER NAME],p.Player_Position AS[PLAYER POSITION],
p.CNIC AS[CNIC],p.Date AS[DATE]
FROM Team t
INNER JOIN Players p ON t.Team_Id=p.Team_Id
where t.Team_Id=@teamId
END

DROP PROCEDURE teamPlayer
EXEC teamPlayer 'T0075'

--******************************************************************
/*PROCEDURES	Sufyan*/
--****************************************************************--
--7
CREATE PROCEDURE matchDetails
@matchId varchar(255)
AS
BEGIN
select  m.Match_Id AS[MATCH ID],m.Team1_Name AS[WIN TEAM],m.Team2_Name AS[LOSE TEAM],
m.Match_Stadium[STADIUM NAME],m.No_Goals AS[NUMBER OF GOALS],r.Referee_Name AS[MATCH REFREE],
m.Date AS[DATE]

from Referee r
INNER JOIN Match m ON r.Referee_Id=m.Referee_Id

WHERE m.Match_Id=@matchId 
END

DROP PROCEDURE matchDetails
EXEC matchDetails 'M0157'
--******************************************************************
/*PROCEDURES		Sufyan*/
--****************************************************************--
--8
Create procedure insertTeam
@Team_Id VARCHAR(200) ,
@Team_Name VARCHAR(200),
@City varchar(200),
@Phone_Number varchar(200),
@Team_Coach varchar(200),
@No_Matches int,
@Date date
AS 
 Begin
    insert into Team(Team_Id,Team_Name,City,Phone_Number,Team_Coach,No_Matches,Date)
	values
	(@Team_Id,@Team_Name,@City,@Phone_Number,@Team_Coach,@No_Matches,@Date )
 end
  insertTeam 'T1649','ARSENAL','LIVERPOOL','0300123456','ISHAAQ',32,'2000-04-25'

--******************************************************************
/*PROCEDURES		IHSAN*/
--****************************************************************--
--9

Create Procedure [Goals By One Player In City]
AS 
BEGIN
SELECT  dbo.Players.Player_Id,dbo.Players.Player_Name,SUM(dbo.MatchGoals.Num_Goals) AS Total_Goals,
 dbo.Team.City
FROM dbo.Team 
INNER JOIN dbo.Players
ON Players.Team_Id = Team.Team_Id
INNER JOIN
dbo.MatchGoals
ON MatchGoals.Team_Id = Players.Team_Id

GROUP BY dbo.Players.Player_Id,players.Player_Name, Team.city
 
 End

 EXEC [Goals By One Player In City]
--******************************************************************
/*PROCEDURES		Sufyan*/
--****************************************************************--
--10
 CREATE PROCEDURE Team_Played_Match_City
AS 
BEGIN
SELECT dbo.Team.Team_Name,dbo.StadiumRecord.stadium_Name,
SUM(dbo.StadiumRecord.Num_of_Matches)AS [Total Matches Played],
dbo.Team.Date
FROM dbo.Team INNER JOIN dbo.StadiumRecord ON 
dbo.Team.Team_Id=dbo.StadiumRecord.Team_Id
GROUP BY Team.Team_Name,dbo.StadiumRecord.stadium_Name,dbo.StadiumRecord.Num_of_Matches,dbo.Team.Date
HAVING dbo.Team.Date BETWEEN '2002-02-05' AND '2009-08-30'
END

EXEC Team_Played_Match_City

--******************************************************************
/*PROCEDURES		IHSAN*/
--****************************************************************--
--11
CREATE PROCEDURE Referee_Record
@fromDate date,
@toDate  date
AS
BEGIN

SELECT  dbo.Referee.Referee_Id,
dbo.Referee.Referee_Name,dbo.Stadium.Stadium_Name,dbo.MatchGoals.Num_Goals,dbo.Match.Date FROM dbo.Match INNER JOIN dbo.Referee 
ON Referee.Referee_Id = Match.Referee_Id
INNER JOIN dbo.Stadium ON dbo.Referee.Referee_Id=dbo.Stadium.Referee_Id 
INNER JOIN  dbo.MatchGoals ON dbo.MatchGoals.Referee_Id=dbo.Referee.Referee_Id
WHERE dbo.Match.Date BETWEEN @fromDate AND @toDate
END
drop procedure Referee_Record
EXEC Referee_Record '2002-08-06 ' ,'2003-08-21 '

--******************************************************************
/*PROCEDURES		Sufyan*/
--****************************************************************--
--12

CREATE PROCEDURE salaryUpdate
@newsalary int ,
@coach_id varchar(255),
@updated_salary int out,
@previous_salary int out
as 
begin 

select  @previous_salary = 
coach_salary from Coach where Coach_Id=@coach_id
update Coach

set previous_salary=@previous_salary where Coach_Id=@coach_id
update Coach

set coach_salary=@newsalary where Coach_Id=@coach_id
update Coach 
set UPDATED_SALARY_DATE= GETDATE() where Coach_Id=@coach_id
select @updated_salary = 
coach_salary from Coach where Coach_Id=@coach_id

end

declare @updated_salary int,@previous_salary int

exec salaryUpdate 20000,'C0069',@updated_salary out,@previous_salary out

print CONCAT('UPDATED PRICE :',@updated_salary)
print CONCAT('PREVIOUS PRICE :',@previous_salary)

select *from Coach where Coach_Id='C0069';

--******************************************************************
/*PROCEDURES		Sufyan*/
--****************************************************************--
--13

CREATE PROCEDURE revenueofTeam(
    @team varchar(100)
) 
AS 
	BEGIN
			DECLARE @playerSum INT,
			@salary inT;


			SET @playerSum = '0';
			 SET @salary = '0';

  SELECT
		@playerSum =
					(SELECT SUM(p.categoryID) FROM Registeration r
					INNER JOIN Playercategory p ON r.categoryID=p.categoryID),

		@salary=
					
				(SELECT SUM(coach_salary) FROM Coach c
				INNER JOIN Team t ON t.Team_Id=c.Team_Id
				GROUP BY t.Team_Id
				HAVING @team= t.Team_Id
				)

				                    
  FROM 
			Team
    WHERE
			 @team=Team.Team_Id
     
	PRINT CONCAT('Ticket Revenue:: ', @playerSum);
	PRINT CONCAT('Expenses:: ',@salary);
	Print CONCAT('Profit:: ', @playerSum-@salary);


END;
 
 select * from team


exec revenueofTeam	'T0068'




/*=============================REVENUE OF TEAM========================================*/

 CREATE PROCEDURE teamRevenue
@teamID varchar(100)
AS
   BEGIN
		 

				SELECT t.Team_Id,SUM(coach_salary) AS Salary FROM Coach c
				INNER JOIN Team t ON t.Team_Id=c.Team_Id
				GROUP BY t.Team_Id
				HAVING @teamID=t.Team_Id

 END 

 select * from Team
 EXEC teamRevenue 'T0068'
 EXEC teamRevenue '00419'  
