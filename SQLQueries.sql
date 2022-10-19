CREATE DATABASE [CustomerRegistration]

USE [CustomerRegistration]
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCustomer]    Script Date: 10/19/2022 10:16:19 ******/
DROP PROCEDURE [dbo].[SP_UpdateCustomer]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCustomer]    Script Date: 10/19/2022 10:16:19 ******/
DROP PROCEDURE [dbo].[SP_InsertCustomer]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllCustomers]    Script Date: 10/19/2022 10:16:19 ******/
DROP PROCEDURE [dbo].[SP_GetAllCustomers]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/19/2022 10:16:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
DROP TABLE [dbo].[Customer]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/19/2022 10:16:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[CusName] [varchar](100) NOT NULL,
	[ContactNo] [varchar](10) NOT NULL,
	[Address] [nvarchar](250) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (1, N'Test1', N'0702348753', N'Gampaha', N'test1@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (3, N'TestNew', N'0705348753', N'Fort', N'testnew@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (4, N'Test4', N'0768980987', N'Fort', N'test4@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (14, N'Test5', N'0768980987', N'Fort', N'test5@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (15, N'Test3', N'0789059043', N'Kandy', N'test3@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (16, N'Test6', N'0705348753', N'Gampaha', N'test6@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (18, N'Test7', N'0759863258', N'Rajagiriya', N'test7@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (19, N'Test8', N'0769865348', N'Colombo', N'test8@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (20, N'Test9', N'0112365984', N'Fort', N'test9@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (21, N'Test10', N'0332256984', N'Gampaha', N'test10@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (22, N'Test11', N'0359863254', N'Kandy', N'test11@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (23, N'Test12', N'0745621254', N'Gampaha', N'test12@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (24, N'Test13', N'0745623125', N'Gampaha', N'test13@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (25, N'Test14', N'0715689234', N'Kandy', N'test14@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (26, N'Test15', N'0714895624', N'Negombo', N'test15@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (27, N'Tets16', N'0715698621', N'Colombo', N'test16@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (28, N'Test17', N'0712569862', N'Gampaha', N'test17@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (30, N'Test18', N'0715698452', N'Colombo', N'test18@gmail.com')
GO
INSERT [dbo].[Customer] ([RID], [CusName], [ContactNo], [Address], [Email]) VALUES (31, N'Test19', N'0712345675', N'Kandy', N'test19@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllCustomers]    Script Date: 10/19/2022 10:16:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetAllCustomers]
AS
BEGIN
	SELECT 
	   [RID]
      ,[CusName] [CustomerName]
      ,[ContactNo]
      ,[Address]
      ,[Email]
	FROM Customer
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCustomer]    Script Date: 10/19/2022 10:16:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertCustomer]
@CusName varchar(100),
@ContactNo varchar(10),
@Address nvarchar(250),
@Email nvarchar(100)
AS
Declare @Result as int=0;
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN
			INSERT INTO [dbo].[Customer] 
			([CusName],[ContactNo],[Address],[Email])
			VALUES
			(@CusName,@ContactNo,@Address,@Email)
			SET @Result=1;
		END
	END TRY
	BEGIN CATCH
		SET @Result=2;
	END CATCH

	SELECT @Result as Result
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCustomer]    Script Date: 10/19/2022 10:16:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateCustomer]
@RID int,
@CusName varchar(100),
@ContactNo varchar(10),
@Address nvarchar(250),
@Email nvarchar(100)
AS
Declare @Result as int=0;
BEGIN
	BEGIN TRY
		BEGIN
			UPDATE [dbo].[Customer] 
			SET [CusName]=@CusName,[ContactNo]=@ContactNo,[Address]=@Address,[Email]=@Email
			WHERE [RID]=@RID
			SET @Result=1;
		END
	END TRY
	BEGIN CATCH
		SET @Result=2;
	END CATCH

	SELECT @Result as Result
END
GO
