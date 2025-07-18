USE [fld_rs]
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 7/9/2025 6:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenantId] [int] NOT NULL,
	[Vin] [nvarchar](max) NOT NULL,
	[VehicleName] [nvarchar](max) NOT NULL,
	[VehicleMakeId] [int] NOT NULL,
	[VehicleModelId] [int] NOT NULL,
	[ModelYear] [nvarchar](max) NOT NULL,
	[EngineModel] [nvarchar](max) NOT NULL,
	[EngineManufacturer] [nvarchar](max) NOT NULL,
	[CurrentOdometer] [float] NOT NULL,
	[CurrentLatitude] [float] NOT NULL,
	[CurrentLongitude] [float] NOT NULL,
	[VehicleLocationId] [int] NOT NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
