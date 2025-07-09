--USE [fld_rs]
--GO

--/****** Object:  View [dbo].[vw_alert]    Script Date: 6/16/2025 6:25:54 AM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO




ALTER VIEW [dbo].[vw_alert]
AS

WITH AlertWithPrev AS (
    SELECT
        a.*,
        at.AlertTypeDescription AS AlertType,
        asvr.AlertSeverityDescription AS AlertSeverity,
        LEAD(CreatedDateTimeUtc) OVER (PARTITION BY a.VehicleId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertCreatedDateTimeUtc,
        LEAD(CreatedDateTimeUtc) OVER (PARTITION BY a.VehicleId, a.AlertTypeId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertTypeCreatedDateTimeUtc,
        LEAD(AlertOdomotor) OVER (PARTITION BY a.VehicleId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertOdometer,
        LEAD(AlertOdomotor) OVER (PARTITION BY a.VehicleId, a.AlertTypeId  ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertTypeOdometer
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
    (AlertWithPrev.[AlertOdomotor] - AlertWithPrev.[PrevAlertOdometer])/1609.344 AS MilesBetweenAlerts,
    (AlertWithPrev.[AlertOdomotor] - AlertWithPrev.[PrevAlertTypeOdometer])/1609.344 AS MilesBetweenAlertType,
    DATEDIFF(DAY, AlertWithPrev.PrevAlertTypeCreatedDateTimeUtc, AlertWithPrev.CreatedDateTimeUtc) AS DaysDifference,
    DATEDIFF(HOUR, AlertWithPrev.PrevAlertTypeCreatedDateTimeUtc, AlertWithPrev.CreatedDateTimeUtc) AS HourDifference,
    ar.TriggerNewAlertHours
FROM AlertWithPrev
    INNER JOIN [dbo].[vw_alert_rules] ar
        ON AlertWithPrev.AlertTypeId = ar.[Id]
ORDER BY 
    AlertWithPrev.VehicleId, AlertWithPrev.AlertTypeId, AlertWithPrev.CreatedDateTimeUtc;
GO




-- Need to figure out avg route in miles per vehicle. Until you know the route per vehicle, you have to use a constant. Use DaysDifference between alerts day diff = 1 and AVG([MilesBetweenAlerts]).  59.8445623214722 miles for a route per day.  Drive
-- Where are the service yards?  What days of the week does this truck operate?
ALTER VIEW dbo.vw_alerts_same_sequence
AS
SELECT TOP 999999999
a.*
,ar.[Average Vehicle Route Miles]
,(
    CASE 
        WHEN
            a.[PrevAlertTypeCreatedDateTimeUtc] IS NULL THEN 0
        WHEN
            a.[DaysDifference] > 5 AND ((a.[MilesBetweenAlertType] + ar.[Average Vehicle Route Miles] * -.5 < ar.[Average Vehicle Route Miles]) OR (a.[MilesBetweenAlertType] + ar.[Average Vehicle Route Miles] * .5 > ar.[Average Vehicle Route Miles])) THEN 0
        WHEN
            a.[DaysDifference] > 6 AND ar.[Average Vehicle Route Miles] IS NULL THEN 0
        
        ELSE 1
    END
    ) AS SameAlertSequence
from [dbo].[vw_alert] a
    LEFT JOIN [dbo].[vw_vehicle_average_route] ar
        ON ar.[VehicleId] = a.VehicleId
order by a.VehicleId, a.AlertType, a.CreatedDateTimeUtc