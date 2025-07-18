USE [fld_rs]
GO
/****** Object:  Table [dbo].[AlertFault]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertFault](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AlertId] [int] NOT NULL,
	[Spn] [int] NOT NULL,
	[Fmi] [int] NOT NULL,
	[FaultDateUtc] [datetime2](7) NOT NULL,
	[Protocol] [nvarchar](max) NOT NULL,
	[FaultCount] [int] NOT NULL,
	[SourceAddress] [int] NOT NULL,
	[TriggeredAlert] [bit] NOT NULL,
 CONSTRAINT [PK_AlertFault] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
