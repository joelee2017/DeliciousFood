CREATE TABLE [dbo].[Recipes](
	[RecipeId] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RecipeName] [nvarchar](20) NOT NULL,
	[Introduction] [nvarchar](50) NOT NULL,
	[RecipeImage] [nvarchar](max) NULL,
 [CookingTime] INT NULL, 
    [Amount] INT NULL, 
    CONSTRAINT [PK_Recipes] PRIMARY KEY CLUSTERED 
(
	[RecipeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Recipes]  WITH CHECK ADD  CONSTRAINT [FK_食譜_user] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO

ALTER TABLE [dbo].[Recipes] CHECK CONSTRAINT [FK_食譜_user]
GO
/****** Object:  Index [IX_FK_食譜_user]    Script Date: 2018/1/9 下午 02:53:36 ******/
CREATE NONCLUSTERED INDEX [IX_FK_食譜_user] ON [dbo].[Recipes]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]