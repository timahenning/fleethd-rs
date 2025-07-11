USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_vehicle_average_route]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_vehicle_average_route]
AS

WITH VehiclesWithAlertDayIsOne AS (
    SELECT
        VehicleId
        , ([MilesBetweenAlertType]/(CASE WHEN [DaysDifference] IS NULL OR [DaysDifference] = 0 THEN 1 ELSE [DaysDifference] END)) AS [Average Vehicle Route Miles]
        ,[MilesBetweenAlertType]
        ,[DaysDifference] 
    FROM 
        [dbo].[vw_alert]
    -- Take out the weekend values.
    WHERE ([DaysDifference] = 1 OR [DaysDifference] > 3) AND [MilesBetweenAlerts] > 0
)
SELECT
     VehicleId
    ,AVG([Average Vehicle Route Miles]) AS [Average Vehicle Route Miles]
FROM 
    VehiclesWithAlertDayIsOne
GROUP BY 
    VehicleId

GO
