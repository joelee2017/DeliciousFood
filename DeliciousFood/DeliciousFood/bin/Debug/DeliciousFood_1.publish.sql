/*
DeliciousFood 的部署指令碼

這段程式碼由工具產生。
變更這個檔案可能導致不正確的行為，而且如果重新產生程式碼，
變更將會遺失。
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DeliciousFood"
:setvar DefaultFilePrefix "DeliciousFood"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
偵測 SQLCMD 模式，如果不支援 SQLCMD 模式，則停用指令碼執行。
若要在啟用 SQLCMD 模式後重新啟用指令碼，請執行以下:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'必須啟用 SQLCMD 模式才能成功執行此指令碼。';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'正在建立 $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'無法修改資料庫設定。您必須是 SysAdmin 才能套用這些設定。';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'無法修改資料庫設定。您必須是 SysAdmin 才能套用這些設定。';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'正在建立 [dbo].[IngredientList]...';


GO
CREATE TABLE [dbo].[IngredientList] (
    [IngredientId]          INT           IDENTITY (1, 1) NOT NULL,
    [IngredientName]        NVARCHAR (20) NOT NULL,
    [IngredientAnotherName] NVARCHAR (20) NULL,
    CONSTRAINT [PK_IngredientList] PRIMARY KEY CLUSTERED ([IngredientId] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[OrderDetails]...';


GO
CREATE TABLE [dbo].[OrderDetails] (
    [OrderId]      INT           NOT NULL,
    [IngredientId] NVARCHAR (50) NULL,
    [ShippingDate] DATETIME      NULL,
    [Quantity]     INT           NULL,
    [Discount]     FLOAT (53)    NULL,
    [UnitPrice]    INT           NULL,
    [ItemId]       INT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED ([ItemId] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[Orders]...';


GO
CREATE TABLE [dbo].[Orders] (
    [OrderID]        INT           IDENTITY (1, 1) NOT NULL,
    [UserID]         INT           NULL,
    [ReceiveName]    NVARCHAR (50) NULL,
    [ReceiveAddress] NVARCHAR (50) NULL,
    [ReceivePhone]   INT           NULL,
    [City]           NVARCHAR (50) NULL,
    [OrderDate]      DATETIME      NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[Orders].[IX_FK_食材訂單_user]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_食材訂單_user]
    ON [dbo].[Orders]([UserID] ASC)
    ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[Recipes]...';


GO
CREATE TABLE [dbo].[Recipes] (
    [RecipeId]     INT            IDENTITY (1, 1) NOT NULL,
    [UserID]       INT            NOT NULL,
    [RecipeName]   NVARCHAR (20)  NOT NULL,
    [Introduction] NVARCHAR (50)  NOT NULL,
    [RecipeImage]  NVARCHAR (MAX) NULL,
    [CookingTime]  INT            NULL,
    [Amount]       INT            NULL,
    CONSTRAINT [PK_Recipes] PRIMARY KEY CLUSTERED ([RecipeId] ASC) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[Recipes].[IX_FK_食譜_user]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_食譜_user]
    ON [dbo].[Recipes]([UserID] ASC)
    ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[RecipesIngredient]...';


GO
CREATE TABLE [dbo].[RecipesIngredient] (
    [IngredientId]    INT           NOT NULL,
    [RecipeId]        INT           NOT NULL,
    [IngredientsName] NVARCHAR (50) NOT NULL,
    [Quantity]        NCHAR (10)    NULL,
    CONSTRAINT [PK_RecipesIngredient] PRIMARY KEY CLUSTERED ([IngredientId] ASC, [RecipeId] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[RecipesIngredient].[IX_FK_食材_食譜]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_食材_食譜]
    ON [dbo].[RecipesIngredient]([RecipeId] ASC)
    ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[Storage]...';


GO
CREATE TABLE [dbo].[Storage] (
    [StorageId]    INT           IDENTITY (1, 1) NOT NULL,
    [IngredientId] INT           NOT NULL,
    [Quantity]     INT           NOT NULL,
    [Origin]       NVARCHAR (20) NOT NULL,
    [PurchaseDate] DATETIME      NOT NULL,
    [LastDate]     DATETIME      NOT NULL,
    CONSTRAINT [PK_Storage] PRIMARY KEY CLUSTERED ([StorageId] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[Storage].[IX_FK_Storage_IngredientList]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_Storage_IngredientList]
    ON [dbo].[Storage]([IngredientId] ASC)
    ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [UserID]       INT            IDENTITY (1, 1) NOT NULL,
    [UserName]     NVARCHAR (10)  NOT NULL,
    [UserPassword] NVARCHAR (100) NOT NULL,
    [UserEmail]    NVARCHAR (50)  NULL,
    [UserSex]      NCHAR (10)     NULL,
    [FirstName]    NCHAR (10)     NULL,
    [LastName]     NCHAR (10)     NULL,
    [UserImage]    NVARCHAR (MAX) NULL,
    [UserLineID]   NVARCHAR (50)  NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([UserID] ASC) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'正在建立 [dbo].[FK_OrderDetails_Orders]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders] ([OrderID]);


GO
PRINT N'正在建立 [dbo].[FK_食材訂單_user]...';


GO
ALTER TABLE [dbo].[Orders]
    ADD CONSTRAINT [FK_食材訂單_user] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID]);


GO
PRINT N'正在建立 [dbo].[FK_食譜_user]...';


GO
ALTER TABLE [dbo].[Recipes]
    ADD CONSTRAINT [FK_食譜_user] FOREIGN KEY ([UserID]) REFERENCES [dbo].[User] ([UserID]);


GO
PRINT N'正在建立 [dbo].[FK_RecipesIngredient_IngredientList]...';


GO
ALTER TABLE [dbo].[RecipesIngredient]
    ADD CONSTRAINT [FK_RecipesIngredient_IngredientList] FOREIGN KEY ([IngredientId]) REFERENCES [dbo].[IngredientList] ([IngredientId]);


GO
PRINT N'正在建立 [dbo].[FK_食材_食譜]...';


GO
ALTER TABLE [dbo].[RecipesIngredient]
    ADD CONSTRAINT [FK_食材_食譜] FOREIGN KEY ([RecipeId]) REFERENCES [dbo].[Recipes] ([RecipeId]);


GO
PRINT N'正在建立 [dbo].[FK_Storage_IngredientList]...';


GO
ALTER TABLE [dbo].[Storage]
    ADD CONSTRAINT [FK_Storage_IngredientList] FOREIGN KEY ([IngredientId]) REFERENCES [dbo].[IngredientList] ([IngredientId]);


GO
-- 用於更新含有部署交易記錄之目標伺服器的重構步驟

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e23a60d0-f2a8-42f9-a541-45d7d0903108')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e23a60d0-f2a8-42f9-a541-45d7d0903108')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6fc6f6d5-9c39-4cb3-ae12-1f2faa45a4d3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6fc6f6d5-9c39-4cb3-ae12-1f2faa45a4d3')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'更新完成。';


GO
