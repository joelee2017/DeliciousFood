CREATE TABLE [dbo].[User]
(
	[UserId] INT NOT NULL PRIMARY KEY, 
    [Email] NVARCHAR(50) NOT NULL, 
    [PassWord] NVARCHAR(100) NOT NULL, 
    [Gender] NCHAR(10) NULL, 
    [FirstName] NVARCHAR(50) NULL, 
    [LastName] NVARCHAR(50) NULL, 
    [Photo] VARBINARY(MAX) NULL, 
    [LineID] NVARCHAR(50) NULL
)
