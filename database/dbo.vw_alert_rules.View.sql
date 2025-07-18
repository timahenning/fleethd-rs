USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_alert_rules]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_alert_rules]
AS

SELECT  
        at.[Id]
      ,at.[AlertTypeDescription]
      ,ar.[hours] AS TriggerNewAlertHours
  FROM [fld_rs].[dbo].[AlertType] at
    LEFT JOIN dbo.AlertRules ar
        on at.AlertTypeDescription = ar.Subject
GO
