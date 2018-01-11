CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](10) NOT NULL,
	[UserPassword] [nvarchar](100) NOT NULL,
	[UserEmail] [nvarchar](50) NOT NULL,
	[UserSex] [nchar](10) NULL,
	[FirstName] [nchar](10) NULL,
	[LastName] [nchar](10) NULL,
	[UserImage] VARBINARY(MAX) NULL,
	[UserLineID] [nvarchar](50) NULL,
 [CreationDate] DATE NOT NULL, 
    [ChangePassWorddate] DATE NOT NULL, 
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]