USE [fld_rs]
GO
/****** Object:  Table [dbo].[dr-pepper-2023-work-orders]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dr-pepper-2023-work-orders](
	[Equipment] [nvarchar](50) NULL,
	[Work_Order] [nvarchar](50) NULL,
	[Fucntional_Loc] [nvarchar](50) NULL,
	[WO_Date] [date] NULL,
	[Cost_Center] [nvarchar](50) NULL,
	[Order_Type] [nvarchar](50) NULL,
	[User_Status] [nvarchar](50) NULL,
	[Op_Short_Text] [nvarchar](50) NULL,
	[Reason_for_Repair_Description] [nvarchar](50) NULL,
	[Work_Accomplished_Description] [nvarchar](50) NULL,
	[Failure_Description] [nvarchar](50) NULL,
	[Component] [nvarchar](50) NULL,
	[Component_Description] [nvarchar](100) NULL,
	[Start_Date] [date] NULL,
	[Finish_Date] [date] NULL,
	[Labor_Cost_USD] [float] NULL,
	[Material] [int] NULL,
	[Material_Desp] [nvarchar](50) NULL,
	[Quantity] [float] NULL,
	[Plant_Section_Region] [nvarchar](50) NULL,
	[Part_Cost_USD] [float] NULL,
	[Ext_Service_Cost_USD] [decimal](18, 10) NULL,
	[Vendor] [nvarchar](50) NULL,
	[Total_Work_Order_USD] [float] NULL,
	[Tech_Name] [nvarchar](50) NULL,
	[Sensor_Tracked] [bit] NULL
) ON [PRIMARY]
GO
