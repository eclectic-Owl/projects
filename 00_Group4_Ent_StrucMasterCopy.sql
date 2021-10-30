USE [master]
GO
CREATE DATABASE [Entertainment]

GO

USE Entertainment

GO


CREATE TABLE Agents(
	AgentID VARCHAR(8) NOT NULL PRIMARY KEY,
	AgentFirstName VARCHAR(50) NOT NULL,
	AgentLastName VARCHAR(50) NOT NULL,
	AgentStreetAddress VARCHAR(50) NOT NULL,
	AgentCity VARCHAR(50) NOT NULL,
	AgentState VARCHAR (2) NOT NULL,
	AgentZipCode VARCHAR(10) NOT NULL
	CHECK(LEN (AgentZipCode) = 5),
	AgentPhoneNumber VARCHAR (10) NOT NULL
	CHECK(LEN(AgentPhoneNumber) = 8 ),
	DateHired DATE  ,
	Salary MONEY NOT NULL
	CHECK (Salary !< 0),
	CommissionRate DECIMAL (5,2)
	CHECK (CommissionRate !> 100 OR CommissionRate !< 0)NOT NULL);
	

CREATE TABLE Performers(
	MemberID VARCHAR(8) NOT NULL PRIMARY KEY,
	MemberFirstName VARCHAR(50) NOT NULL, 
	MemberLastName VARCHAR(50) NOT NULL,
	MemberPhoneNumber VARCHAR(10) NOT NULL
	CHECK(LEN(MemberPhoneNumber) = 8 ),
	MemberGender VARCHAR(1)
	CHECK (MemberGender = 'M' OR MemberGender = 'F')NOT NULL );


CREATE TABLE Customers(
	CustomerID VARCHAR(8) NOT NULL PRIMARY KEY,
	CustomerFirstName VARCHAR(50) NOT NULL,
	CustomerLastName VARCHAR(50) NOT NULL,
	CustomerStreetAddress VARCHAR(50) NOT NULL,
	CustomerCity VARCHAR(50) NOT NULL,
	CustomerState VARCHAR(2) NOT NULL,
	CustomerZipCode VARCHAR(10) NOT NULL
	CHECK(LEN (CustomerZipCode) = 5),
	CustomerPhoneNumber VARCHAR(10) NOT NULL
	CHECK(LEN(CustomerPhoneNumber) = 8 ));


CREATE TABLE Groups(
	GroupID VARCHAR(8) NOT NULL PRIMARY KEY,
	StageName VARCHAR(50) NOT NULL,
	SSN VARCHAR(11) NOT NULL
	CHECK(LEN (SSN) = 11),
	GroupStreetAddress VARCHAR (50) NOT NULL,
	GroupCity VARCHAR(50) NOT NULL,
	GroupState VARCHAR(2) NOT NULL,
	GroupZipCode VARCHAR(10) NOT NULL
	CHECK(LEN (GroupZipCode) = 5),
	GroupPhoneNumber VARCHAR(10) NOT NULL
	CHECK(LEN(GroupPhoneNumber) = 8 ),
	GroupPage VARCHAR(50) NULL,
	GroupEmail VARCHAR(50) NULL,
	DateEntered DATE  NOT NULL );

CREATE TABLE Musical_Style(
	StyleNameID VARCHAR(8) NOT NULL PRIMARY KEY,
	StyleName VARCHAR(50) NOT NULL );
	
CREATE TABLE Group_Members(
	GroupID VARCHAR(8) NULL ,
	MemberID VARCHAR(8) NULL,
	Status DECIMAL(1) 
	CHECK (Status = 1 OR Status = 2 ) NOT NULL );

CREATE TABLE Group_By_Style(
	StyleNameID VARCHAR(8) NULL ,
	GroupID VARCHAR(8) NULL ,
	StyleStrength DECIMAL(1)
	CHECK (StyleStrength = 1 OR StyleStrength  <= 3 ) NOT NULL );

CREATE TABLE Musical_Preferences(
	StyleNameID VARCHAR(8) NULL ,
	CustomerID VARCHAR(8) NULL ,
	PreferenceRating DECIMAL(1)
	 CHECK (PreferenceRating = 1 OR PreferenceRating <= 3 ) NOT NULL );


CREATE TABLE Engagements(
	EngagementNumber VARCHAR(8) NOT NULL PRIMARY KEY,
	StartDate DATE  NOT NULL,
	EndDate DATE NOT NULL,
	StartTime TIME(0)  NOT NULL,
	StopTime TIME(0) NOT NULL,
	ContractPrice MONEY  NOT NULL
	CHECK (ContractPrice !< 0),
	CustomerID VARCHAR (8) NULL,
	AgentID VARCHAR (8) NULL,
	GroupID VARCHAR (8) NULL,
	);


ALTER TABLE [Engagements] ADD CONSTRAINT FK__Engagemen__Agent__37A5467C FOREIGN KEY(AgentID) REFERENCES Agents (AgentID) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [Engagements] ADD CONSTRAINT FK__Engagemen__Custo__36B12243 FOREIGN KEY(CustomerID) REFERENCES Customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [Engagements] ADD CONSTRAINT FK__Engagemen__Group__38996AB5 FOREIGN KEY(GroupID) REFERENCES Groups (GroupID) ON DELETE CASCADE ON UPDATE CASCADE
GO


ALTER TABLE [Group_By_Style] ADD CONSTRAINT FK__Group_By___Group__30F848ED FOREIGN KEY(GroupID) REFERENCES Groups (GroupID) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [Group_By_Style] ADD CONSTRAINT FK__Group_By___Style__300424B4 FOREIGN KEY(StyleNameID) REFERENCES Musical_Style (StyleNameID) ON DELETE CASCADE ON UPDATE CASCADE
GO


ALTER TABLE [Group_Members] ADD CONSTRAINT FK__Group_Mem__Group__2D27B809 FOREIGN KEY(GroupID) REFERENCES Groups (GroupID) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [Group_Members] ADD CONSTRAINT FK__Group_Mem__Membe__2E1BDC42 FOREIGN KEY(MemberID) REFERENCES Performers (MemberID) ON DELETE CASCADE ON UPDATE CASCADE
GO


ALTER TABLE [Musical_Preferences] ADD CONSTRAINT FK__Musical_P__Custo__33D4B598 FOREIGN KEY(CustomerID) REFERENCES Customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE [Musical_Preferences] ADD CONSTRAINT FK__Musical_P__Style__32E0915F FOREIGN KEY(StyleNameID) REFERENCES Musical_Style (StyleNameID) ON DELETE CASCADE ON UPDATE CASCADE
GO

