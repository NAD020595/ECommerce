IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ECommerce')
BEGIN
  CREATE DATABASE ECommerce
END
GO
--=====================================================================================================================================================
USE [ECommerce]
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[OrderDetail]
(
	[ID] int IDENTITY(1,1) NOT NULL,
	[OrderID] int NOT NULL,
	[ProductID] int NOT NULL,
	[UnitPrice] float NOT NULL,
	[Quantity] int NOT NULL,
	[Discount] float NOT NULL,

	CONSTRAINT [PK_OrderDetail] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Product](
	[ID] int IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	[AliasName] nvarchar(50) NULL,
	[CategoryID] int NOT NULL,
	[UnitDescription] nvarchar(50) NULL,
	[UnitPrice] float NULL,
	[Image] nvarchar(50) NULL,
	[ManufacturingDateTime] datetime NOT NULL,
	[Discount] float NOT NULL,
	[ViewCount] int NOT NULL,
	[Description] nvarchar(max) NULL,
	[SupplierID] nvarchar(50) NOT NULL,

	CONSTRAINT [PK_Product] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE VIEW [dbo].[vOrderDetail]
AS 
	SELECT 
		o.*, 
		p.[Name]
	FROM OrderDetail o JOIN Product p ON o.ProductID = p.ID
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Promotion](
	[ID] int IDENTITY(1,1) NOT NULL,
	[CustomerID] nvarchar(20) NULL,
	[ProductID] int NOT NULL,
	[FullName] nvarchar(50) NULL,
	[Email] nvarchar(50) NOT NULL,
	[SendDateTime] datetime NOT NULL,
	[Note] nvarchar(max) NULL,

	CONSTRAINT [PK_Promotion] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Topic](
	[ID] int IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(50) NULL,
	[EmployeeID] nvarchar(50) NULL,

	CONSTRAINT [PK_Topic] PRIMARY KEY ([ID])
) 
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Feedback](
	[ID] nvarchar(50) NOT NULL,
	[TopicID] int NOT NULL,
	[Content] nvarchar(max) NOT NULL,
	[CreatDateTime] datetime NOT NULL,
	[FullName] nvarchar(50) NULL,
	[Email] nvarchar(50) NULL,
	[PhoneNumber] nvarchar(50) NULL,
	[NeedToAnswer] [bit] NOT NULL,
	[Answer] nvarchar(50) NULL,
	[AnswerDateTime] datetime NULL,

	CONSTRAINT [PK_Feedback] PRIMARY KEY ([ID])
) 
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Order](
	[ID] int IDENTITY(1,1) NOT NULL,
	[CustomerID] nvarchar(20) NOT NULL,
	[OrderDateTime] datetime NOT NULL,
	[RequireDateTime] datetime NULL,
	[ShippingDateTime] datetime NULL,
	[FullName] nvarchar(50) NULL,
	[Address] nvarchar(60) NOT NULL,
	[PaymentMethod] nvarchar(50) NOT NULL,
	[ShippingMethod] nvarchar(50) NOT NULL,
	[ShippingFee] float NOT NULL,
	[StatusID] int NOT NULL,
	[EmployeeID] nvarchar(50) NULL,
	[Note] nvarchar(50) NULL,

	CONSTRAINT [PK_Order] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[QuestionAndAnswer](
	[ID] int IDENTITY(1,1) NOT NULL,
	[Question] nvarchar(50) NOT NULL,
	[Answer] nvarchar(50) NOT NULL,
	[CreateDateTime] datetime NOT NULL,
	[LastChangeDateTime] datetime NOT NULL,
	[EmployeeID] nvarchar(50) NOT NULL,

	CONSTRAINT [PK_QuestionAndAnswer] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Customer](
	[ID] nvarchar(20) NOT NULL,
	[Password] nvarchar(50) NULL,
	[FullName] nvarchar(50) NOT NULL,
	[Gender] bit NOT NULL,
	[Birthday] datetime NOT NULL,
	[Address] nvarchar(60) NULL,
	[PhoneNumber] nvarchar(24) NULL,
	[Email] nvarchar(50) NOT NULL,
	[Image] nvarchar(50) NULL,
	[Active] bit NOT NULL,
	[UserLevel] int NOT NULL,
	[RandomKey] varchar(50) NULL,

	CONSTRAINT [PK_Customer] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Category](
	[ID] int IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	[AliasName] nvarchar(50) NULL,
	[Description] nvarchar(max) NULL,
	[Image] nvarchar(50) NULL,
	CONSTRAINT [PK_Categorie] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Supplier](
	[ID] nvarchar(50) NOT NULL,
	[CompanyName] nvarchar(50) NOT NULL,
	[Logo] nvarchar(50) NOT NULL,
	[ContactName] nvarchar(50) NULL,
	[Email] nvarchar(50) NOT NULL,
	[PhoneNumber] nvarchar(50) NULL,
	[Address] nvarchar(50) NULL,
	[Description] nvarchar(max) NULL,
	CONSTRAINT [PK_Supplier] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Employee](
	[ID] nvarchar(50) NOT NULL,
	[FullName] nvarchar(50) NOT NULL,
	[Email] nvarchar(50) NOT NULL,
	[Password] nvarchar(50) NULL,
	CONSTRAINT [PK_Employee] PRIMARY KEY ([ID])
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Assignment](
	[ID] int IDENTITY(1,1) NOT NULL,
	[EmployeeID] nvarchar(50) NOT NULL,
	[DepartmentID] varchar(7) NOT NULL,
	[CreateDateTime] datetime NULL,
	[Effective] bit NULL,
	CONSTRAINT [PK_Assignment] PRIMARY KEY (ID)
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Decentralization](
	[ID] int IDENTITY(1,1) NOT NULL,
	[DepartmentID] varchar(7) NULL,
	[PageID] int NULL,
	[Add] [bit] NOT NULL,
	[Edit] [bit] NOT NULL,
	[Delete] [bit] NOT NULL,
	[View] [bit] NOT NULL,
	CONSTRAINT [PK_Decentralization] PRIMARY KEY (ID)
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Department](
	[ID] varchar(7) NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	[Information] nvarchar(max) NULL,
	CONSTRAINT [PK_Department] PRIMARY KEY (ID)
)	
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Status](
	[ID] int NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	[Description] nvarchar(500) NULL,
	CONSTRAINT [PK_Status] PRIMARY KEY (ID) 
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[WebPage](
	[ID] int IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	[URL] nvarchar(250) NOT NULL,
	CONSTRAINT [PK_WebPage] PRIMARY KEY (ID)
)
GO
--=====================================================================================================================================================
CREATE TABLE [dbo].[Favorite](
	[ID] int IDENTITY(1,1) NOT NULL,
	[ProductID] int NULL,
	[CustomerID] nvarchar(20) NULL,
	[CreateDateTime] datetime NULL,
	[Description] nvarchar(255) NULL,
	CONSTRAINT [PK_Favorite] PRIMARY KEY (ID)
)
GO
--=====================================================================================================================================================
ALTER TABLE [dbo].[Promotion] ADD CONSTRAINT [DF_Promotion_Sent]  DEFAULT (getdate()) FOR [SendDateTime]
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [DF_Order_Details_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [DF_Order_Details_Quantity]  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [DF_Order_Details_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Feedback] ADD CONSTRAINT [DF_Feedback_CreatDateTime]  DEFAULT (getdate()) FOR [CreatDateTime]
GO
ALTER TABLE [dbo].[Feedback] ADD CONSTRAINT [DF_Feedback_NeedToAnswer]  DEFAULT ((0)) FOR [NeedToAnswer]
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [DF_Product_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [DF_Product_ManufacturingDateTime]  DEFAULT (getdate()) FOR [ManufacturingDateTime]
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [DF_Product_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [DF_Product_ViewCount]  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [DF_Order_OrderDateTime]  DEFAULT (getdate()) FOR [OrderDateTime]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [DF_Order_RequireDateTime]  DEFAULT (getdate()) FOR [RequireDateTime]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [DF_Order_ShippingDateTime]  DEFAULT (((1)/(1))/(1900)) FOR [ShippingDateTime]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [DF_Order_PaymentMethod]  DEFAULT (N'Cash') FOR [PaymentMethod]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [DF_Order_ShippingMethod]  DEFAULT (N'Deliver') FOR [ShippingMethod]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [DF_Order_ShippingFee]  DEFAULT ((0)) FOR [ShippingFee]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [DF_Order_Status]  DEFAULT ((0)) FOR [StatusID]
GO
ALTER TABLE [dbo].[QuestionAndAnswer] ADD CONSTRAINT [DF_QuestionAndAnswer_CreateDateTime]  DEFAULT (getdate()) FOR [CreateDateTime]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [DF_Customer_Gender]  DEFAULT ((0)) FOR [Gender]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [DF_Customer_Birthday]  DEFAULT (getdate()) FOR [Birthday]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [DF_Customer_Image]  DEFAULT (N'Avatar.png') FOR [Image]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [DF_Customer_Active]  DEFAULT ((0)) FOR [Active]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [DF_Customer_UserLevel]  DEFAULT ((0)) FOR [UserLevel]
GO
ALTER TABLE [dbo].[Decentralization] ADD CONSTRAINT [DF_Decentralization_Add]  DEFAULT ((0)) FOR [Add]
GO
ALTER TABLE [dbo].[Decentralization] ADD CONSTRAINT [DF_Decentralization_Edit]  DEFAULT ((0)) FOR [Edit]
GO
ALTER TABLE [dbo].[Decentralization] ADD CONSTRAINT [DF_Decentralization_Delete]  DEFAULT ((0)) FOR [Delete]
GO
ALTER TABLE [dbo].[Decentralization] ADD CONSTRAINT [DF_Decentralization_View]  DEFAULT ((0)) FOR [View]
GO
--=====================================================================================================================================================
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD CONSTRAINT [FK_Promotion_Customer] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [FK_Promotion_Customer]
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD CONSTRAINT [FK_Promotion_Product] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Product] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [FK_Promotion_Product]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderID]) REFERENCES [dbo].[Order] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD CONSTRAINT [FK_OrderDetails_Product] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Product] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetails_Product]
GO
ALTER TABLE [dbo].[Topic]  WITH CHECK ADD CONSTRAINT [FK_Topic_Employee] FOREIGN KEY([EmployeeID]) REFERENCES [dbo].[Employee] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Topic] CHECK CONSTRAINT [FK_Topic_Employee]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD CONSTRAINT [FK_Feedback_Topic] FOREIGN KEY([TopicID]) REFERENCES [dbo].[Topic] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Topic]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID]) REFERENCES [dbo].[Category] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CONSTRAINT [FK_Product_Supplier] FOREIGN KEY([SupplierID]) REFERENCES [dbo].[Supplier] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Supplier]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD CONSTRAINT [FK_Order_Employee] FOREIGN KEY([EmployeeID]) REFERENCES [dbo].[Employee] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Employee]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD CONSTRAINT [FK_Order_Status] FOREIGN KEY([StatusID]) REFERENCES [dbo].[Status] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Status]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customer] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[QuestionAndAnswer]  WITH CHECK ADD CONSTRAINT [FK_QuestionAndAnswer_Employee] FOREIGN KEY([EmployeeID]) REFERENCES [dbo].[Employee] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuestionAndAnswer] CHECK CONSTRAINT [FK_QuestionAndAnswer_Employee]
GO
ALTER TABLE [dbo].[Assignment]  WITH CHECK ADD CONSTRAINT [FK_Assignment_Employee] FOREIGN KEY([EmployeeID]) REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Assignment] CHECK CONSTRAINT [FK_Assignment_Employee]
GO
ALTER TABLE [dbo].[Assignment]  WITH CHECK ADD CONSTRAINT [FK_Assignment_Department] FOREIGN KEY([DepartmentID]) REFERENCES [dbo].[Department] ([ID])
GO
ALTER TABLE [dbo].[Assignment] CHECK CONSTRAINT [FK_Assignment_Department]
GO
ALTER TABLE [dbo].[Decentralization]  WITH CHECK ADD CONSTRAINT [FK_Decentralization_Department] FOREIGN KEY([DepartmentID]) REFERENCES [dbo].[Department] ([ID])
GO
ALTER TABLE [dbo].[Decentralization] CHECK CONSTRAINT [FK_Decentralization_Department]
GO
ALTER TABLE [dbo].[Decentralization]  WITH CHECK ADD CONSTRAINT [FK_Decentralization_WebPage] FOREIGN KEY([PageID])REFERENCES [dbo].[WebPage] ([ID])
GO
ALTER TABLE [dbo].[Decentralization] CHECK CONSTRAINT [FK_Decentralization_WebPage]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD CONSTRAINT [FK_Favorite_Customer] FOREIGN KEY([CustomerID]) REFERENCES [dbo].[Customer] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK_Favorite_Customer]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD CONSTRAINT [FK_Favorite_Product] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Product] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK_Favorite_Product]
GO