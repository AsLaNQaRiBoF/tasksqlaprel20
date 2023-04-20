CREATE DATABASE Instagram
CREATE TABLE Posts(
Id int primary key identity,
Content nvarchar (50),
Createtime DATE,
LikeCount int CHECK(LEN(LikeCount)>0),
IsDeleted bit DEFAULT 'false',
UserId int REFERENCES Users(Id))

CREATE TABLE Users(
Id INT PRIMARY KEY identity,
[Login] VARCHAR(50),
[Password] VARCHAR(50),
Mail VARCHAR(255))

CREATE TABLE Comments(
Id int primary key identity,
UserId int References Users(Id),
PostId int References Posts(Id),
LikeCount int CHECK(LEN(LikeCount)>0),
IsDeleted bit DEFAULT 'false')

CREATE TABLE People(
Id int primary key identity,
[Name] nvarchar (50),
[Surname] nvarchar (100),
Age int,
UserId int REFERENCES Users(Id))

INSERT INTO Users
VAlUES('Welcome','Leo','leo@gmail.com'),
('Salam','Aslan','aslan@gmail.com')

INSERT INTO Posts
VALUES('Sunny day','2023-04-20',200,'false',1),
('Foggy day','2020-11-11',150,'false',2)

INSERT INTO Comments
VALUES(1,1,250,'false'),
(2,2,150,'false')

INSERT INTO People
VALUES('Leo','Messi',36,1),
('Aslan','Qeribov',19,2)



CREATE VIEW CommentCount
AS
SELECT Posts.Content, Count(Comments.Id)AS 'COUNT' FROM Posts
JOIN 
Comments
ON
Posts.Id=Comments.PostId
WHERE Comments.IsDeleted='false'
GROUP BY Posts.Content

SELECT *FROM CommentCount

CREATE VIEW AllData AS 
SELECT Posts.Content, Posts.Createtime, Posts.UserId, Posts.LikeCount, Posts.IsDeleted, 
       Users.[Login], Users.[Password], Users.Mail,
       Comments.UserId AS CommentUserId, Comments.PostId AS CommentPostId, Comments.LikeCount AS CommentLikeCount, Comments.IsDeleted AS CommentIsDeleted,
       People.Name, People.Surname, People.Age
FROM Posts
JOIN Users ON Posts.UserId =Users.Id
JOIN Comments ON Posts.Id = Comments.PostId
JOIN People ON Users.Id = People.UserId

SELECT *FROM AllData

CREATE TRIGGER DELETED
ON
Posts
INSTEAD OF DELETE
AS
UPDATE Posts SET  IsDeleted='true' where Id=2
DElETE FROM Posts WHERE Id=1