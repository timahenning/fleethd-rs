USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_vehicle_duration_between_new_alerts]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Determine the duation and distance between a new alert sequence.

CREATE VIEW [dbo].[vw_vehicle_duration_between_new_alerts]
AS
  -- 1. Filter to zeros rows
  -- 2. Sort by Vehicle, AlerType, Date
  -- 3. Use window function to compare previous date time and duration.

  -- Vehicle, AlertType, Date, PrevDate, DurationHoursBetweenAlerts, Count of SameSequence = 1, Count of Severity
WITH VehicleAlertDuration AS (
  SELECT
       a.[VehicleId]
      ,a.[CreatedDateTimeUtc]
      ,a.[AlertTypeId]
      ,a.[AlertSeverityId]
      ,[AlertOdomotor]
      ,LEAD(AlertOdomotor) OVER (PARTITION BY a.VehicleId, a.AlertTypeId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertTypeOdometer
      ,LEAD(a.CreatedDateTimeUtc) OVER (PARTITION BY a.VehicleId, a.AlertTypeId ORDER BY a.CreatedDateTimeUtc DESC) AS PrevAlertTypeCreatedDateTimeUtc 
  FROM [dbo].[vw_alerts_same_sequence] a
  -- New alert
  WHERE a.[SameAlertSequence] = 0
)

-- Calculations between rows
SELECT TOP 999999999
    v.*
    ,(SELECT COUNT(*) FROM [dbo].[vw_alerts_same_sequence] t WHERE t.VehicleId = v.VehicleId AND t.AlertTypeId = v.AlertTypeId AND t.AlertSeverityId = v.AlertSeverityId AND t.AlertReset = 1) AS AlertResetCount
    ,COALESCE((v.[AlertOdomotor] - v.[PrevAlertTypeOdometer])/1609.344,0) AS MilesBetweenAlertType
    ,COALESCE(DATEDIFF(DAY, PrevAlertTypeCreatedDateTimeUtc, CreatedDateTimeUtc),0) AS SameAlertSequenceDays
    ,COALESCE(DATEDIFF(HOUR, PrevAlertTypeCreatedDateTimeUtc, CreatedDateTimeUtc),0) AS SameAlertSequenceHour
FROM VehicleAlertDuration v ORDER BY v.VehicleId, v.AlertTypeId, v.CreatedDateTimeUtc
GO
