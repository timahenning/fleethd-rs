USE [fld_rs]
GO
/****** Object:  Table [dbo].[AlertSeverity]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertSeverity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AlertSeverityDescription] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
