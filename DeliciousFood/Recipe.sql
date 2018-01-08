CREATE TABLE [dbo].[Recipe]
(
	[RecipeID] INT NOT NULL PRIMARY KEY, 
    [UserID] INT NOT NULL, 
    [FoodName] NVARCHAR(20) NOT NULL, 
    [Description] NVARCHAR(200) NOT NULL, 
    [CookingTime] INT NULL, 
    [Amount] INT NULL, 
    [Photo] VARBINARY(MAX) NULL, 
    [Tips] NVARCHAR(200) NULL
)
