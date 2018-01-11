﻿CREATE TABLE [dbo].[IngredientList](
	[IngredientId] [int] IDENTITY(1,1) NOT NULL,
	[IngredientName] [nvarchar](20) NOT NULL,
	[IngredientAnotherName] [nvarchar](20) NULL,
 CONSTRAINT [PK_IngredientList] PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]