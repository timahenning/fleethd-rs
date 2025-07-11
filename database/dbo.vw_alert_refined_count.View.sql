USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_alert_refined_count]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_alert_refined_count]
AS
WITH VehicleAlertCount AS (

  SELECT
    VehicleId
    ,AlertTypeId
    ,COUNT(*) AS AlertTotalCount
  FROM [fld_rs].[dbo].[vw_vehicle_duration_between_new_alerts]
  GROUP BY VehicleId, AlertTypeId
)
SELECT TOP 99999999
    VehicleId
    ,AlertTypeId
    ,SUM(AlertTotalCount) AS AlertTotalCount
FROM VehicleAlertCount
GROUP BY VehicleId,AlertTypeId
ORDER BY VehicleId,AlertTypeId
GO
