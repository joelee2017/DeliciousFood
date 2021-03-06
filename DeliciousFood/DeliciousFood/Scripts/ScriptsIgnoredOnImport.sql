﻿
USE [master]
GO

/****** Object:  Database [DeliciousFood]    Script Date: 2018/1/9 下午 02:53:36 ******/
CREATE DATABASE [DeliciousFood]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DeliciousFood', FILENAME = N'J:\SQL_Data\Data\DeliciousFood.mdf' , SIZE = 15360KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DeliciousFood_log', FILENAME = N'J:\SQL_Data\Data\DeliciousFood_log.ldf' , SIZE = 5120KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [DeliciousFood] SET COMPATIBILITY_LEVEL = 120
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DeliciousFood].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [DeliciousFood] SET ANSI_NULL_DEFAULT OFF
GO

ALTER DATABASE [DeliciousFood] SET ANSI_NULLS OFF
GO

ALTER DATABASE [DeliciousFood] SET ANSI_PADDING OFF
GO

ALTER DATABASE [DeliciousFood] SET ANSI_WARNINGS OFF
GO

ALTER DATABASE [DeliciousFood] SET ARITHABORT OFF
GO

ALTER DATABASE [DeliciousFood] SET AUTO_CLOSE OFF
GO

ALTER DATABASE [DeliciousFood] SET AUTO_SHRINK OFF
GO

ALTER DATABASE [DeliciousFood] SET AUTO_UPDATE_STATISTICS ON
GO

ALTER DATABASE [DeliciousFood] SET CURSOR_CLOSE_ON_COMMIT OFF
GO

ALTER DATABASE [DeliciousFood] SET CURSOR_DEFAULT  GLOBAL
GO

ALTER DATABASE [DeliciousFood] SET CONCAT_NULL_YIELDS_NULL OFF
GO

ALTER DATABASE [DeliciousFood] SET NUMERIC_ROUNDABORT OFF
GO

ALTER DATABASE [DeliciousFood] SET QUOTED_IDENTIFIER OFF
GO

ALTER DATABASE [DeliciousFood] SET RECURSIVE_TRIGGERS OFF
GO

ALTER DATABASE [DeliciousFood] SET  DISABLE_BROKER
GO

ALTER DATABASE [DeliciousFood] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO

ALTER DATABASE [DeliciousFood] SET DATE_CORRELATION_OPTIMIZATION OFF
GO

ALTER DATABASE [DeliciousFood] SET TRUSTWORTHY OFF
GO

ALTER DATABASE [DeliciousFood] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO

ALTER DATABASE [DeliciousFood] SET PARAMETERIZATION SIMPLE
GO

ALTER DATABASE [DeliciousFood] SET READ_COMMITTED_SNAPSHOT OFF
GO

ALTER DATABASE [DeliciousFood] SET HONOR_BROKER_PRIORITY OFF
GO

ALTER DATABASE [DeliciousFood] SET RECOVERY FULL
GO

ALTER DATABASE [DeliciousFood] SET  MULTI_USER
GO

ALTER DATABASE [DeliciousFood] SET PAGE_VERIFY CHECKSUM
GO

ALTER DATABASE [DeliciousFood] SET DB_CHAINING OFF
GO

ALTER DATABASE [DeliciousFood] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
GO

ALTER DATABASE [DeliciousFood] SET TARGET_RECOVERY_TIME = 0 SECONDS
GO

ALTER DATABASE [DeliciousFood] SET DELAYED_DURABILITY = DISABLED
GO

EXEC sys.sp_db_vardecimal_storage_format N'DeliciousFood', N'ON'
GO

USE [DeliciousFood]
GO

/****** Object:  Table [dbo].[IngredientList]    Script Date: 2018/1/9 下午 02:53:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[OrderDetails]    Script Date: 2018/1/9 下午 02:53:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 2018/1/9 下午 02:53:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[Recipes]    Script Date: 2018/1/9 下午 02:53:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[RecipesIngredient]    Script Date: 2018/1/9 下午 02:53:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[Storage]    Script Date: 2018/1/9 下午 02:53:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[User]    Script Date: 2018/1/9 下午 02:53:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

USE [master]
GO

ALTER DATABASE [DeliciousFood] SET  READ_WRITE
GO
