USE [fld_rs]
GO
/****** Object:  Table [dbo].[dr-pepper-2023-vmrs-codes-fleethd]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dr-pepper-2023-vmrs-codes-fleethd](
	[FleetHD_Alerts] [nvarchar](50) NOT NULL,
	[VMRS_Code] [nvarchar](50) NOT NULL,
	[VMRS_Component_Description] [nvarchar](100) NOT NULL,
	[Alternate_VMRS_Code] [nvarchar](50) NOT NULL,
	[VMRS_Component_Description2] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
