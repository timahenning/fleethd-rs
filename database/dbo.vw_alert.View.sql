USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_alert]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--USE [fld_rs]
--GO

--/****** Object:  View [dbo].[vw_alert]    Script Date: 6/16/2025 6:25:54 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO




CREATE VIEW [dbo].[vw_alert]
AS

WITH AlertWithPrev AS (
    SELECT
        a.*,
        at.AlertTypeDescription AS AlertType,
        asvr.AlertSeverityDescription AS AlertSeverity,
        LEAD(CreatedDateTimeUtc) OVER (PARTITION BY a.VehicleId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertCreatedDateTimeUtc,
        LEAD(CreatedDateTimeUtc) OVER (PARTITION BY a.VehicleId, a.AlertTypeId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertTypeCreatedDateTimeUtc,
        LEAD(AlertOdomotor) OVER (PARTITION BY a.VehicleId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertOdometer,
        LEAD(AlertOdomotor) OVER (PARTITION BY a.VehicleId, a.AlertTypeId  ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertTypeOdometer,
        -- Triggered Fault Count is tied down to the AlertSevertiy
        LEAD(TriggeredFaultCount) OVER (PARTITION BY a.VehicleId, a.AlertTypeId, a.AlertSeverityId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevTriggeredFaultCount
    FROM dbo.Alert a
            INNER JOIN dbo.AlertType at
                ON at.Id = a.AlertTypeId
            INNER JOIN dbo.AlertSeverity asvr
                ON asvr.Id = a.AlertSeverityId
)
SELECT TOP 9999999999
    DATEPART(weekday, AlertWithPrev.CreatedDateTimeUtc) AS WEEKDAY,
    DATENAME(weekday, AlertWithPrev.CreatedDateTimeUtc) AS DAY,
    AlertWithPrev.*,
    COALESCE((AlertWithPrev.[AlertOdomotor] - AlertWithPrev.[PrevAlertOdometer])/1609.344, 0) AS MilesBetweenAlerts,
    COALESCE((AlertWithPrev.[AlertOdomotor] - AlertWithPrev.[PrevAlertTypeOdometer])/1609.344,0) AS MilesBetweenAlertType,
    DATEDIFF(DAY, AlertWithPrev.PrevAlertTypeCreatedDateTimeUtc, AlertWithPrev.CreatedDateTimeUtc) AS DaysDifference,
    DATEDIFF(HOUR, AlertWithPrev.PrevAlertTypeCreatedDateTimeUtc, AlertWithPrev.CreatedDateTimeUtc) AS HourDifference,
    ar.TriggerNewAlertHours,
    (CASE WHEN TriggeredFaultCount < PrevTriggeredFaultCount THEN 1 ELSE 0 END) AS AlertReset
FROM AlertWithPrev
    INNER JOIN [dbo].[vw_alert_rules] ar
        ON AlertWithPrev.AlertTypeId = ar.[Id]
ORDER BY 
    AlertWithPrev.VehicleId, AlertWithPrev.AlertTypeId, AlertWithPrev.CreatedDateTimeUtc;
GO
