USE [fld_rs]
GO
/****** Object:  Table [dbo].[dr-pepper-2023-vehicle-maintenance-cost]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dr-pepper-2023-vehicle-maintenance-cost](
	[Plant_Section_Region] [nvarchar](50) NOT NULL,
	[Branch] [nvarchar](50) NOT NULL,
	[Equipment] [nvarchar](50) NOT NULL,
	[VMRS_Component_Description] [nvarchar](100) NULL,
	[Total] [money] NOT NULL
) ON [PRIMARY]
GO
