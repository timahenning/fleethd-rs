USE [fld_rs]
GO
/****** Object:  Table [dbo].[RepairCostEstimate]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepairCostEstimate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RepairCostEstimateValue] [decimal](18, 2) NOT NULL
) ON [PRIMARY]
GO
