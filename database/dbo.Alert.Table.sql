USE [fld_rs]
GO
/****** Object:  Table [dbo].[Alert]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alert](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VehicleId] [int] NOT NULL,
	[CreatedDateTimeUtc] [datetime2](7) NOT NULL,
	[AlertTypeId] [int] NOT NULL,
	[AlertSeverityId] [int] NOT NULL,
	[AlertOdomotor] [float] NOT NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[RepairCostEstimateId] [int] NOT NULL,
	[TriggeredFaultFmi] [int] NOT NULL,
	[TriggeredFaultSpn] [int] NOT NULL,
	[TriggeredFaultSource] [int] NOT NULL,
	[TriggeredFaultCount] [int] NOT NULL,
 CONSTRAINT [PK_Alert] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
