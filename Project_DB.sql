CREATE DATABASE FOOTBALL

USE FOOTBALL


DROP DATABASE football


create table Registeration(
	Reg_Id VARCHAR(255) PRIMARY KEY,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FatherName VARCHAR(255) NOT NULL,
	Gender VARCHAR(255) NOT NULL,
	CNIC VARCHAR(255) NOT NULL UNIQUE,
	DOB DATE NOT NULL,
	Date date NOT NULL
);

CREATE TABLE playerCategory(
categoryID INT PRIMARY KEY,
categoryName VARCHAR(200),
previousPrice INT,
currentPrice INT,
updatedDate DATE
);

alter table Registeration  add categoryID INT FOREIGN KEY REFERENCES playerCategory(categoryID)

create table Team(
	Team_Id VARCHAR(255) PRIMARY KEY,
	Team_Name VARCHAR(255) NOT NULL,
	City VARCHAR(255) NOT NULL,
	Phone_Number VARCHAR(255) NOT NULL UNIQUE,
	Team_Coach VARCHAR(255) NOT NULL,
	No_Matches INT NOT NULL,
Date date NOT NULL

);

create table Players(
	Player_Id VARCHAR(255) PRIMARY KEY,
	Reg_Id VARCHAR(255) FOREIGN KEY REFERENCES Registeration(reg_id),
	Team_Id VARCHAR(255) FOREIGN KEY REFERENCES Team(team_id),
	Player_Position VARCHAR(255) DEFAULT 'TO BE DECIDED',
	Player_Name VARCHAR(255) NOT NULL,
	Player_Speed VARCHAR(255) NOT NULL,
	CNIC VARCHAR(255) NOT NULL UNIQUE,
	DOB DATE NOT NULL,
	Date date NOT NULL
);

create table reserved_player(

Res_Player_Id VARCHAR(255) PRIMARY KEY,
Res_Player_Name varchar(255),
Player_Id VARCHAR(255) FOREIGN KEY REFERENCES Players(player_id),
Date date NOT NULL

);

create table Coach(
  
	Coach_Id VARCHAR(255) PRIMARY KEY,
	Coach_Name VARCHAR(255) NOT NULL,
	License_Num VARCHAR(255) NOT NULL UNIQUE,
	coach_salary INT NOT NULL CHECK(coach_salary<100000),
	Coach_Nationality VARCHAR(255) NOT NULL,
	Team_Id VARCHAR(255) FOREIGN KEY REFERENCES Team(team_id),
	Date date NOT NULL

);
alter table Coach add UPDATED_SALARY_DATE DATE ;


create table Referee(
	Referee_Id VARCHAR(255) PRIMARY KEY,
	Referee_Name VARCHAR(255) NOT NULL,
	License_Num VARCHAR(255) NOT NULL UNIQUE,
	City VARCHAR(255) NOT NULL,
	Date date NOT NULL
);

create table refree_record(
	
	Record_Id VARCHAR(255) PRIMARY KEY,
	Referee_Id VARCHAR(255) FOREIGN KEY REFERENCES Referee(referee_id),
	Referee_Age INT NOT NULL CHECK(Referee_Age<=60),
	Service_Years INT NOT NULL,
	No_of_Matches INT NOT NULL ,
	Joining_Date date,
	Date date NOT NULL

);

create table Stadium(
	Stadium_Id VARCHAR(255)  PRIMARY KEY,
	Stadium_Name VARCHAR(255) NOT NULL,
	City VARCHAR(255) NOT NULL UNIQUE,
	Pitch_Type VARCHAR(255) NOT NULL,
	Capacity BIGINT NOT NULL CHECK(capacity<10000),
	Team_Id VARCHAR(255) FOREIGN KEY REFERENCES Team(team_id),
	Referee_Id VARCHAR(255) FOREIGN KEY REFERENCES Referee(referee_id),
	Date date NOT NULL
	
);

create table StadiumRecord(
    Record_Id VARCHAR(255) Unique Not Null,
	stadium_Name VARCHAR(255) NOT NULL,
	Num_of_Goals INT NOT NULL,
	Num_of_Matches INT NOT NULL,
	Stadium_Id VARCHAR(255) FOREIGN KEY REFERENCES Stadium(stadium_id),
	Team_Id VARCHAR(255) FOREIGN KEY REFERENCES Team(team_id),
	Date date NOT NULL
);

Drop Table StadiumRecord

Select * From StadiumRecord

create table Match(
	Match_Id VARCHAR(255) PRIMARY KEY,
	Team_Id VARCHAR(255) FOREIGN KEY REFERENCES Team(team_id),
	Referee_Id VARCHAR(255) FOREIGN KEY REFERENCES Referee(referee_id),
	Match_Stadium VARCHAR(255) NOT NULL,
	Match_Results VARCHAR(255) NOT NULL,
	No_Goals INT NOT NULL,
	Team1_Name VARCHAR(255) NOT NULL,
	Team2_Name VARCHAR(255) NOT NULL,
	Date date NOT NULL
);

create table MatchGoals(

    Record_id INT PRIMARY KEY,
	Num_Goals INT NOT NULL CHECK(num_goals<=20),
	Max_Goal_Player VARCHAR(255) FOREIGN KEY REFERENCES Players(player_id),
	Match_Id VARCHAR(255)  FOREIGN KEY REFERENCES Match(match_id),
	Team_Id VARCHAR(255) FOREIGN KEY REFERENCES Team(Team_Id),
	Referee_Id VARCHAR(255) FOREIGN KEY REFERENCES Referee(referee_id),
	Date date NOT NULL
);




select *from Registeration
select *from Team   
select *from Players
select *from reserved_player
select *from  Coach
select *from  Stadium 
select *from  StadiumRecord
select *from  Referee
select *from  Match
select *from refree_record
select *from  MatchGoals