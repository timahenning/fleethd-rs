USE [fld_rs]
GO
/****** Object:  Table [dbo].[AlertRules]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertRules](
	[id] [nvarchar](50) NOT NULL,
	[subject] [nvarchar](100) NOT NULL,
	[frequency] [nvarchar](50) NOT NULL,
	[hours] [tinyint] NOT NULL,
 CONSTRAINT [PK_republic-alert-rules] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
