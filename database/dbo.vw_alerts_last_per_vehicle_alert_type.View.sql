USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_alerts_last_per_vehicle_alert_type]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_alerts_last_per_vehicle_alert_type]
AS
WITH RankedAlerts AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY VehicleId, AlertTypeId 
               ORDER BY CreatedDateTimeUtc DESC
           ) AS rn
    FROM [dbo].[Alert]
)
SELECT *
FROM RankedAlerts
WHERE rn = 1;
GO
