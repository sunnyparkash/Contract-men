USE [master]
GO
/****** Object:  Database [ContractManager_Qa]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE DATABASE [ContractManager_Qa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ContractManager_Qa', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ContractManager_Qa.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ContractManager_Qa_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ContractManager_Qa_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ContractManager_Qa] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ContractManager_Qa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ContractManager_Qa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET ARITHABORT OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ContractManager_Qa] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ContractManager_Qa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ContractManager_Qa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ContractManager_Qa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ContractManager_Qa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ContractManager_Qa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ContractManager_Qa] SET  MULTI_USER 
GO
ALTER DATABASE [ContractManager_Qa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ContractManager_Qa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ContractManager_Qa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ContractManager_Qa] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ContractManager_Qa]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateCostComulative]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateCostComulative](
@orderId int
)
RETURNS numeric(28,12)
AS 
begin
declare @result as numeric(28,12)
   select @result=SUM(CalculatedCostAmount) from OrderModifications where Order_Id=@orderId
   return @result
   end


GO
/****** Object:  UserDefinedFunction [dbo].[CalculateCurrentEstimatedLifeCycleContractValue]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateCurrentEstimatedLifeCycleContractValue](
@programId int
)
RETURNS numeric(28,12)
AS 
begin
declare @result as numeric(28,12)
   select @result=SUM(TotalComulative) from Orders where Program_Id=@programId
   return @result
   end


GO
/****** Object:  UserDefinedFunction [dbo].[CalculateCurrentObligatedFunds]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateCurrentObligatedFunds](
@programId int
)
RETURNS numeric(28,12)
AS 
begin
declare @result as numeric(28,12)
   select @result=SUM(ObligatedAmount) from Orders where Program_Id=@programId
   return @result
   end
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateFeeComulative]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateFeeComulative](
@orderId int
)
RETURNS numeric(28,12)
AS 
begin
declare @result as numeric(28,12)
   select @result=SUM(CalculatedFeeAmount) from OrderModifications where Order_Id=@orderId
   return @result
   end
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateFixedPriceComulative]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateFixedPriceComulative](
@orderId int
)
RETURNS numeric(28,12)
AS 
begin
declare @result as numeric(28,12)
   select @result=SUM(CalculatedFixedPriceAmount) from OrderModifications where Order_Id=@orderId
   return @result
   end
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateObligatedAmount]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateObligatedAmount](
@orderId int
)
RETURNS numeric(28,12)
AS 
begin
declare @result as numeric(28,12)
   select @result=SUM(CalculatedObligatedAmount) from OrderModifications where Order_Id=@orderId
   return @result
   end


GO
/****** Object:  Table [dbo].[AffiliatedPrograms]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AffiliatedPrograms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Program_Id] [int] NOT NULL,
	[AffilatedProgram_Id] [int] NOT NULL,
	[AffiliationType_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AffiliationTypes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AffiliationTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AwardBasis]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AwardBasis](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CageCodes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CageCodes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChangeMades]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChangeMades](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChangeTypes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChangeTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Competitions]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Competitions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contacts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](200) NOT NULL,
	[LastName] [varchar](200) NULL,
	[Phone] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Address] [varchar](1000) NULL,
	[DateModified] [datetime] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy_Id] [int] NULL,
	[ModifiedBy_Id] [int] NULL,
	[IsEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactTypes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ContactTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContractModChangeMades]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContractModChangeMades](
	[ContractMods_Id] [int] NOT NULL,
	[ChangeMades_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ContractMods_Id] ASC,
	[ChangeMades_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContractMods]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContractMods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContractModNumber] [nvarchar](2000) NULL,
	[Comments] [nvarchar](max) NULL,
	[EffectiveDate] [date] NULL,
	[ChangeType_Id] [int] NULL,
	[Program_Id] [int] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContractOrderings]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ContractOrderings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[ContractOrderings] ADD [TreePosition] [varchar](100) NULL
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContractTypes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContractTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
 CONSTRAINT [PK_ContractTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CorporateDunses]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CorporateDunses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CorporateLocations]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CorporateLocations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Documents]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Documents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](2000) NOT NULL,
	[Url] [varchar](200) NOT NULL,
	[DocType] [varchar](200) NOT NULL,
	[SizeInKb] [numeric](28, 12) NOT NULL,
	[Folder_Id] [int] NOT NULL,
	[Program_Id] [int] NOT NULL,
	[CreatedById] [int] NULL,
	[DateCreated] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntityType] [varchar](200) NOT NULL,
	[NewValues] [nvarchar](max) NOT NULL,
	[OldValues] [nvarchar](max) NULL,
	[Message] [nvarchar](1000) NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy_Id] [int] NOT NULL,
	[EntityId] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OptionPeriods]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OptionPeriods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [nvarchar](2000) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Program_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderModificationChangeMades]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderModificationChangeMades](
	[OrderModifications_Id] [int] NOT NULL,
	[ChangeMades_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderModifications_Id] ASC,
	[ChangeMades_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderModifications]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderModifications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModificationNo] [nvarchar](2000) NOT NULL,
	[EffactiveDate] [date] NULL,
	[PopFrom] [date] NULL,
	[PopTo] [date] NULL,
	[ObligatedAmount] [numeric](28, 12) NULL,
	[ObligatedAmountAdjustmentType] [varchar](20) NULL,
	[FixedPriceAmount] [numeric](28, 12) NULL,
	[FixedPriceAmountAdjustmentType] [varchar](20) NULL,
	[CostAmount] [numeric](28, 12) NULL,
	[CostAmountAdjustmentType] [varchar](20) NULL,
	[FeeAmount] [numeric](28, 12) NULL,
	[FeeAmountAdjustmentType] [varchar](20) NULL,
	[Description] [varchar](1000) NULL,
	[DateCreated] [datetime] NULL,
	[CreatedById] [int] NULL,
	[OrderType_Id] [int] NULL,
	[Scope_Id] [int] NULL,
	[Order_Id] [int] NOT NULL,
	[DateModified] [datetime] NULL,
	[ModifiedById] [int] NULL,
	[PerposalDate] [date] NULL,
	[IsActive] [bit] NOT NULL,
	[ChangeType_Id] [int] NULL,
	[CalculatedFeeAmount]  AS (case when [FeeAmountAdjustmentType]='plus' then [FeeAmount] when [FeeAmountAdjustmentType]='minus' then  -[feeamount]  end),
	[CalculatedCostAmount]  AS (case when [CostAmountAdjustmentType]='plus' then [CostAmount] when [CostAmountAdjustmentType]='minus' then  -[Costamount]  end),
	[CalculatedFixedPriceAmount]  AS (case when [FixedPriceAmountAdjustmentType]='plus' then [FixedPriceAmount] when [FixedPriceAmountAdjustmentType]='minus' then  -[FixedPriceamount]  end),
	[CalculatedObligatedAmount]  AS (case when [ObligatedAmountAdjustmentType]='plus' then [ObligatedAmount] when [ObligatedAmountAdjustmentType]='minus' then  -[Obligatedamount]  end),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [varchar](2000) NOT NULL,
	[RespCenter] [varchar](2000) NULL,
	[EffactiveDate] [datetime] NULL,
	[PopFrom] [datetime] NULL,
	[PopTo] [datetime] NULL,
	[Description] [nvarchar](max) NULL,
	[OrderType_Id] [int] NULL,
	[Scope_Id] [int] NULL,
	[Program_Id] [int] NOT NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[CreatedBy_Id] [int] NULL,
	[ModifiedBy_Id] [int] NULL,
	[PerposalDate] [datetime] NULL,
	[Customer_Id] [int] NULL,
	[PaymentOffice_Id] [int] NULL,
	[LimitofFundsPercent] [numeric](28, 12) NULL,
	[LimitofFundsAmount] [numeric](28, 12) NULL,
	[LimitofFundsNotification] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[FeeComulative]  AS ([dbo].[CalculateFeeComulative]([id])),
	[FixedPriceComulative]  AS ([dbo].[CalculateFixedPriceComulative]([id])),
	[CostComulative]  AS ([dbo].[CalculateCostComulative]([id])),
	[ObligatedAmount]  AS ([dbo].[CalculateObligatedAmount]([id])),
	[TotalComulative]  AS (([dbo].[CalculateFixedPriceComulative]([id])+[dbo].[CalculateCostComulative]([id]))+[dbo].[CalculateFeeComulative]([id])),
	[ContractAdminBackup_Id] [int] NULL,
	[ContractAdmin_Id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderScopes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderScopes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderTypes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PerformancePlaces]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PerformancePlaces](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProgramContacts]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramContacts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Program_Id] [int] NOT NULL,
	[Contact_Id] [int] NOT NULL,
	[ContactType_Id] [int] NOT NULL,
 CONSTRAINT [PK_ProgramContacts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProgramContractTypes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramContractTypes](
	[Programs_Id] [int] NOT NULL,
	[ContractTypes_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Programs_Id] ASC,
	[ContractTypes_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProgramFolders]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProgramFolders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Program_Id] [int] NOT NULL,
	[CreatedById] [int] NULL,
	[DateCreated] [datetime] NULL,
	[ModifiedById] [int] NULL,
	[DateModified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProgramHistories]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramHistories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Discription] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NOT NULL,
	[CreatedBy_Id] [int] NOT NULL,
	[ModifiedBy_Id] [int] NOT NULL,
	[Program_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProgramOwners]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramOwners](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Id] [int] NOT NULL,
	[Program_Id] [int] NOT NULL,
	[ProgramRole_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProgramPhaseTypes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProgramPhaseTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
 CONSTRAINT [PK_ProgramPhaseTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProgramPlaceOfPerformances]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramPlaceOfPerformances](
	[Programs_Id] [int] NOT NULL,
	[PerformancePlaces_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Programs_Id] ASC,
	[PerformancePlaces_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProgramProcurementRegulations]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProgramProcurementRegulations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Program_Id] [int] NOT NULL,
	[Regulation_Id] [int] NOT NULL,
	[Notes] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProgramRoles]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProgramRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Programs]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Programs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](2000) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[AwardDate] [datetime] NULL,
	[DateModified] [datetime] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy_Id] [int] NULL,
	[ModifiedBy_Id] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[DisabledOn] [datetime] NULL,
	[ProgramPhaseType_Id] [int] NULL,
	[LetterContractNumber] [varchar](2000) NULL,
	[RfpNumber] [varchar](2000) NULL,
	[ContractIdNumber] [varchar](2000) NULL,
	[CurrentTermExpiryDate] [datetime] NULL,
	[NextNoticeDueBy] [datetime] NULL,
	[ExerciseRequired] [varchar](100) NULL,
	[MaxTermStartDate] [datetime] NULL,
	[MaxTermEndDate] [datetime] NULL,
	[BasePeriodStartDate] [datetime] NULL,
	[BasePeriodEndDate] [datetime] NULL,
	[AwardBasis_Id] [int] NULL,
	[ProgramNumber] [varchar](200) NULL,
	[SubContractNumber] [varchar](2000) NULL,
	[PrimeContractNumber] [varchar](2000) NULL,
	[CorporateLocation_Id] [int] NULL,
	[CorporateDuns_Id] [int] NULL,
	[Competition_Id] [int] NULL,
	[CageCode_Id] [int] NULL,
	[Role_id] [int] NULL,
	[ShowCauseCureNoticeDate] [date] NULL,
	[ShowCauseCureNotice] [bit] NULL,
	[Actions] [nvarchar](max) NULL,
	[ContractOrdering_Id] [int] NULL,
	[ResponsibilityCenter] [nvarchar](2000) NULL,
	[SpecialBillingProvisions] [nvarchar](max) NULL,
	[AuthorizedUsers] [nvarchar](2000) NULL,
	[OriginalEstimatedLifeCycleContractValue] [numeric](28, 12) NULL,
	[CurrentObligatedFunds]  AS ([dbo].[CalculateCurrentObligatedFunds]([id])),
	[CurrentEstimatedLifeCycleContractValue]  AS ([dbo].[CalculateCurrentEstimatedLifeCycleContractValue]([id])),
 CONSTRAINT [PK_Programs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProgramServiceOfferings]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProgramServiceOfferings](
	[Programs_Id] [int] NOT NULL,
	[ServiceOfferings_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Programs_Id] ASC,
	[ServiceOfferings_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Regulations]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Regulations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServiceOfferings]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServiceOfferings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](2000) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[TreePosition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TermAndConditions]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TermAndConditions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Term_Id] [int] NULL,
	[Date] [date] NULL,
	[Description] [nvarchar](max) NULL,
	[Program_Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Terms]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Terms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Terms] ADD [TreePosition] [varchar](100) NULL
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](200) NOT NULL,
	[LastName] [varchar](200) NULL,
	[UserName] [varchar](200) NULL,
	[Password] [varchar](500) NULL,
	[Phone] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[TimeZoneId] [varchar](50) NULL,
	[DateModified] [datetime] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy_Id] [int] NULL,
	[ModifiedBy_Id] [int] NULL,
	[Token] [uniqueidentifier] NULL,
	[UserType_Id] [int] NOT NULL,
	[IsEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 5/6/2017 8:39:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[HasWritePermission] [bit] NOT NULL,
 CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_FK_Contacts_CreatedBy]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Contacts_CreatedBy] ON [dbo].[Contacts]
(
	[CreatedBy_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Contacts_ModifiedBy]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Contacts_ModifiedBy] ON [dbo].[Contacts]
(
	[ModifiedBy_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK__ProgramCo__Conta__2F10007B]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK__ProgramCo__Conta__2F10007B] ON [dbo].[ProgramContacts]
(
	[Contact_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK__ProgramCo__Conta__300424B4]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK__ProgramCo__Conta__300424B4] ON [dbo].[ProgramContacts]
(
	[ContactType_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK__ProgramCo__Progr__2E1BDC42]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK__ProgramCo__Progr__2E1BDC42] ON [dbo].[ProgramContacts]
(
	[Program_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Program_CreatedBy]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Program_CreatedBy] ON [dbo].[Programs]
(
	[CreatedBy_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_Program_ModifiedBy]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_Program_ModifiedBy] ON [dbo].[Programs]
(
	[ModifiedBy_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Fk_Program_ProgramPhaseType]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_Fk_Program_ProgramPhaseType] ON [dbo].[Programs]
(
	[ProgramPhaseType_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK__Users__UserType___1920BF5C]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK__Users__UserType___1920BF5C] ON [dbo].[Users]
(
	[UserType_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_CreatedBy]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_CreatedBy] ON [dbo].[Users]
(
	[CreatedBy_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_FK_ModifiedBy]    Script Date: 5/6/2017 8:39:43 PM ******/
CREATE NONCLUSTERED INDEX [IX_FK_ModifiedBy] ON [dbo].[Users]
(
	[ModifiedBy_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Logs] ADD  DEFAULT (getutcdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[OrderModifications] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AffiliatedPrograms]  WITH CHECK ADD FOREIGN KEY([AffilatedProgram_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[AffiliatedPrograms]  WITH CHECK ADD FOREIGN KEY([AffiliationType_Id])
REFERENCES [dbo].[AffiliationTypes] ([Id])
GO
ALTER TABLE [dbo].[AffiliatedPrograms]  WITH CHECK ADD FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_CreatedBy] FOREIGN KEY([CreatedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_CreatedBy]
GO
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_ModifiedBy] FOREIGN KEY([ModifiedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_ModifiedBy]
GO
ALTER TABLE [dbo].[ContractModChangeMades]  WITH CHECK ADD FOREIGN KEY([ChangeMades_Id])
REFERENCES [dbo].[ChangeMades] ([Id])
GO
ALTER TABLE [dbo].[ContractModChangeMades]  WITH CHECK ADD FOREIGN KEY([ContractMods_Id])
REFERENCES [dbo].[ContractMods] ([Id])
GO
ALTER TABLE [dbo].[ContractMods]  WITH CHECK ADD FOREIGN KEY([ChangeType_Id])
REFERENCES [dbo].[ChangeTypes] ([Id])
GO
ALTER TABLE [dbo].[ContractMods]  WITH CHECK ADD FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[Documents]  WITH CHECK ADD FOREIGN KEY([CreatedById])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Documents]  WITH CHECK ADD  CONSTRAINT [Fk_Document_Folder] FOREIGN KEY([Folder_Id])
REFERENCES [dbo].[ProgramFolders] ([Id])
GO
ALTER TABLE [dbo].[Documents] CHECK CONSTRAINT [Fk_Document_Folder]
GO
ALTER TABLE [dbo].[Documents]  WITH CHECK ADD  CONSTRAINT [Fk_Document_Program] FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[Documents] CHECK CONSTRAINT [Fk_Document_Program]
GO
ALTER TABLE [dbo].[Logs]  WITH CHECK ADD FOREIGN KEY([CreatedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[OptionPeriods]  WITH CHECK ADD  CONSTRAINT [Fk_OptionPeriod_Program] FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[OptionPeriods] CHECK CONSTRAINT [Fk_OptionPeriod_Program]
GO
ALTER TABLE [dbo].[OrderModificationChangeMades]  WITH CHECK ADD FOREIGN KEY([ChangeMades_Id])
REFERENCES [dbo].[ChangeMades] ([Id])
GO
ALTER TABLE [dbo].[OrderModificationChangeMades]  WITH CHECK ADD FOREIGN KEY([OrderModifications_Id])
REFERENCES [dbo].[OrderModifications] ([Id])
GO
ALTER TABLE [dbo].[OrderModifications]  WITH CHECK ADD FOREIGN KEY([CreatedById])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[OrderModifications]  WITH CHECK ADD  CONSTRAINT [Fk_OrderMod_Order] FOREIGN KEY([Order_Id])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderModifications] CHECK CONSTRAINT [Fk_OrderMod_Order]
GO
ALTER TABLE [dbo].[OrderModifications]  WITH CHECK ADD  CONSTRAINT [Fk_OrderMod_OrderType] FOREIGN KEY([OrderType_Id])
REFERENCES [dbo].[OrderTypes] ([Id])
GO
ALTER TABLE [dbo].[OrderModifications] CHECK CONSTRAINT [Fk_OrderMod_OrderType]
GO
ALTER TABLE [dbo].[OrderModifications]  WITH CHECK ADD  CONSTRAINT [Fk_OrderMod_Scope] FOREIGN KEY([Scope_Id])
REFERENCES [dbo].[OrderScopes] ([Id])
GO
ALTER TABLE [dbo].[OrderModifications] CHECK CONSTRAINT [Fk_OrderMod_Scope]
GO
ALTER TABLE [dbo].[OrderModifications]  WITH CHECK ADD  CONSTRAINT [Fk_OrderModification_ModifiedBy] FOREIGN KEY([ModifiedById])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[OrderModifications] CHECK CONSTRAINT [Fk_OrderModification_ModifiedBy]
GO
ALTER TABLE [dbo].[OrderModifications]  WITH CHECK ADD  CONSTRAINT [OrderModification_ChangeType] FOREIGN KEY([ChangeType_Id])
REFERENCES [dbo].[ChangeTypes] ([Id])
GO
ALTER TABLE [dbo].[OrderModifications] CHECK CONSTRAINT [OrderModification_ChangeType]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CreatedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ModifiedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [Fk_Order_ContractAdmin] FOREIGN KEY([ContractAdminBackup_Id])
REFERENCES [dbo].[Contacts] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Fk_Order_ContractAdmin]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [Fk_Order_ContractAdminBackup] FOREIGN KEY([ContractAdmin_Id])
REFERENCES [dbo].[Contacts] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Fk_Order_ContractAdminBackup]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [Fk_Order_Customer] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Contacts] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Fk_Order_Customer]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [Fk_Order_OrderType] FOREIGN KEY([OrderType_Id])
REFERENCES [dbo].[OrderTypes] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Fk_Order_OrderType]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [Fk_Order_PaymentOffice] FOREIGN KEY([PaymentOffice_Id])
REFERENCES [dbo].[Contacts] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Fk_Order_PaymentOffice]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [Fk_Order_Program] FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Fk_Order_Program]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [Fk_Order_Scope] FOREIGN KEY([Scope_Id])
REFERENCES [dbo].[OrderScopes] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Fk_Order_Scope]
GO
ALTER TABLE [dbo].[ProgramContacts]  WITH CHECK ADD  CONSTRAINT [FK__ProgramCo__Conta__2F10007B] FOREIGN KEY([Contact_Id])
REFERENCES [dbo].[Contacts] ([Id])
GO
ALTER TABLE [dbo].[ProgramContacts] CHECK CONSTRAINT [FK__ProgramCo__Conta__2F10007B]
GO
ALTER TABLE [dbo].[ProgramContacts]  WITH CHECK ADD  CONSTRAINT [FK__ProgramCo__Conta__300424B4] FOREIGN KEY([ContactType_Id])
REFERENCES [dbo].[ContactTypes] ([Id])
GO
ALTER TABLE [dbo].[ProgramContacts] CHECK CONSTRAINT [FK__ProgramCo__Conta__300424B4]
GO
ALTER TABLE [dbo].[ProgramContacts]  WITH CHECK ADD  CONSTRAINT [FK__ProgramCo__Progr__2E1BDC42] FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[ProgramContacts] CHECK CONSTRAINT [FK__ProgramCo__Progr__2E1BDC42]
GO
ALTER TABLE [dbo].[ProgramContractTypes]  WITH CHECK ADD FOREIGN KEY([ContractTypes_Id])
REFERENCES [dbo].[ContractTypes] ([Id])
GO
ALTER TABLE [dbo].[ProgramContractTypes]  WITH CHECK ADD FOREIGN KEY([Programs_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[ProgramFolders]  WITH CHECK ADD FOREIGN KEY([CreatedById])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ProgramFolders]  WITH CHECK ADD FOREIGN KEY([ModifiedById])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ProgramFolders]  WITH CHECK ADD  CONSTRAINT [ProgramFolder_Program] FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[ProgramFolders] CHECK CONSTRAINT [ProgramFolder_Program]
GO
ALTER TABLE [dbo].[ProgramHistories]  WITH CHECK ADD FOREIGN KEY([CreatedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ProgramHistories]  WITH CHECK ADD FOREIGN KEY([ModifiedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ProgramHistories]  WITH CHECK ADD FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[ProgramOwners]  WITH CHECK ADD  CONSTRAINT [Fk_ProgramOwners_Program] FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[ProgramOwners] CHECK CONSTRAINT [Fk_ProgramOwners_Program]
GO
ALTER TABLE [dbo].[ProgramOwners]  WITH CHECK ADD  CONSTRAINT [Fk_ProgramOwners_ProgramRole] FOREIGN KEY([ProgramRole_Id])
REFERENCES [dbo].[ProgramRoles] ([Id])
GO
ALTER TABLE [dbo].[ProgramOwners] CHECK CONSTRAINT [Fk_ProgramOwners_ProgramRole]
GO
ALTER TABLE [dbo].[ProgramOwners]  WITH CHECK ADD  CONSTRAINT [Fk_ProgramOwners_User] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ProgramOwners] CHECK CONSTRAINT [Fk_ProgramOwners_User]
GO
ALTER TABLE [dbo].[ProgramPlaceOfPerformances]  WITH CHECK ADD FOREIGN KEY([PerformancePlaces_Id])
REFERENCES [dbo].[PerformancePlaces] ([Id])
GO
ALTER TABLE [dbo].[ProgramPlaceOfPerformances]  WITH CHECK ADD FOREIGN KEY([Programs_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[ProgramProcurementRegulations]  WITH CHECK ADD FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[ProgramProcurementRegulations]  WITH CHECK ADD FOREIGN KEY([Regulation_Id])
REFERENCES [dbo].[Regulations] ([Id])
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD FOREIGN KEY([ContractOrdering_Id])
REFERENCES [dbo].[ContractOrderings] ([Id])
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD FOREIGN KEY([Role_id])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [Fk_Program_AwardBasis] FOREIGN KEY([AwardBasis_Id])
REFERENCES [dbo].[AwardBasis] ([Id])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Fk_Program_AwardBasis]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [Fk_Program_CageCode] FOREIGN KEY([CageCode_Id])
REFERENCES [dbo].[CageCodes] ([Id])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Fk_Program_CageCode]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [Fk_Program_Competition] FOREIGN KEY([Competition_Id])
REFERENCES [dbo].[Competitions] ([Id])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Fk_Program_Competition]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [Fk_Program_CorporateDuns] FOREIGN KEY([CorporateDuns_Id])
REFERENCES [dbo].[CorporateDunses] ([Id])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Fk_Program_CorporateDuns]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [Fk_Program_CorporateLocation] FOREIGN KEY([CorporateLocation_Id])
REFERENCES [dbo].[CorporateLocations] ([Id])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Fk_Program_CorporateLocation]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [FK_Program_CreatedBy] FOREIGN KEY([CreatedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [FK_Program_CreatedBy]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [FK_Program_ModifiedBy] FOREIGN KEY([ModifiedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [FK_Program_ModifiedBy]
GO
ALTER TABLE [dbo].[Programs]  WITH CHECK ADD  CONSTRAINT [Fk_Program_ProgramPhaseType] FOREIGN KEY([ProgramPhaseType_Id])
REFERENCES [dbo].[ProgramPhaseTypes] ([Id])
GO
ALTER TABLE [dbo].[Programs] CHECK CONSTRAINT [Fk_Program_ProgramPhaseType]
GO
ALTER TABLE [dbo].[ProgramServiceOfferings]  WITH CHECK ADD FOREIGN KEY([Programs_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[ProgramServiceOfferings]  WITH CHECK ADD FOREIGN KEY([ServiceOfferings_Id])
REFERENCES [dbo].[ServiceOfferings] ([Id])
GO
ALTER TABLE [dbo].[TermAndConditions]  WITH CHECK ADD FOREIGN KEY([Term_Id])
REFERENCES [dbo].[Terms] ([Id])
GO
ALTER TABLE [dbo].[TermAndConditions]  WITH CHECK ADD  CONSTRAINT [Fk_TAC_Program] FOREIGN KEY([Program_Id])
REFERENCES [dbo].[Programs] ([Id])
GO
ALTER TABLE [dbo].[TermAndConditions] CHECK CONSTRAINT [Fk_TAC_Program]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK__Users__UserType___1920BF5C] FOREIGN KEY([UserType_Id])
REFERENCES [dbo].[UserTypes] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK__Users__UserType___1920BF5C]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_CreatedBy] FOREIGN KEY([CreatedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_CreatedBy]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_ModifiedBy] FOREIGN KEY([ModifiedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_ModifiedBy]
GO
USE [master]
GO
ALTER DATABASE [ContractManager_Qa] SET  READ_WRITE 
GO
