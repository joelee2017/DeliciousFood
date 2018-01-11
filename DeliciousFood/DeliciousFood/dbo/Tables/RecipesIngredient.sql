CREATE TABLE [dbo].[RecipesIngredient](
	[IngredientId] [int] NOT NULL,
	[RecipeId] [int] NOT NULL,
	[IngredientsName] NVARCHAR(50) NOT NULL,
	[Quantity] [nchar](10) NULL,
 CONSTRAINT [PK_RecipesIngredient] PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC,
	[RecipeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RecipesIngredient]  WITH CHECK ADD  CONSTRAINT [FK_RecipesIngredient_IngredientList] FOREIGN KEY([IngredientId])
REFERENCES [dbo].[IngredientList] ([IngredientId])
GO

ALTER TABLE [dbo].[RecipesIngredient] CHECK CONSTRAINT [FK_RecipesIngredient_IngredientList]
GO
ALTER TABLE [dbo].[RecipesIngredient]  WITH CHECK ADD  CONSTRAINT [FK_食材_食譜] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipes] ([RecipeId])
GO

ALTER TABLE [dbo].[RecipesIngredient] CHECK CONSTRAINT [FK_食材_食譜]
GO
/****** Object:  Index [IX_FK_食材_食譜]    Script Date: 2018/1/9 下午 02:53:36 ******/
CREATE NONCLUSTERED INDEX [IX_FK_食材_食譜] ON [dbo].[RecipesIngredient]
(
	[RecipeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]