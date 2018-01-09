CREATE TABLE [dbo].[Storage](
	[StorageId] [int] IDENTITY(1,1) NOT NULL,
	[IngredientId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Origin] [nvarchar](20) NOT NULL,
	[PurchaseDate] [datetime] NOT NULL,
	[LastDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Storage] PRIMARY KEY CLUSTERED 
(
	[StorageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Storage]  WITH CHECK ADD  CONSTRAINT [FK_Storage_IngredientList] FOREIGN KEY([IngredientId])
REFERENCES [dbo].[IngredientList] ([IngredientId])
GO

ALTER TABLE [dbo].[Storage] CHECK CONSTRAINT [FK_Storage_IngredientList]
GO
/****** Object:  Index [IX_FK_Storage_IngredientList]    Script Date: 2018/1/9 下午 02:53:36 ******/
CREATE NONCLUSTERED INDEX [IX_FK_Storage_IngredientList] ON [dbo].[Storage]
(
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]