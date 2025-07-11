USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_alerts_same_sequence]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_alerts_same_sequence]
AS
SELECT
    TOP 999999999 a.*,
    ar.[Average Vehicle Route Miles],
    (
        CASE

            -- If the previous alert type created date time is null, then it's considered a new alert sequence.
            WHEN a.[PrevAlertTypeCreatedDateTimeUtc] IS NULL THEN 0

            -- If days between alerts is greater than or equal to 5 and the miles between alert type is within 
            -- 50% of the average vehicle route miles, then it's considered a new alert sequence.
            WHEN a.[DaysDifference] >= 5
            AND (
                (
                    a.[MilesBetweenAlertType] + ar.[Average Vehicle Route Miles] * -.5 < ar.[Average Vehicle Route Miles]
                )
                OR (
                    a.[MilesBetweenAlertType] + ar.[Average Vehicle Route Miles] *.5 > ar.[Average Vehicle Route Miles]
                )
            ) THEN 0

            -- If the previous alert type created date time is null, and the days between alerts is greater 
            -- than or equal to 6, then it's considered a new alert sequence.
            WHEN a.[DaysDifference] >= 6
            AND ar.[Average Vehicle Route Miles] IS NULL THEN 0
            ELSE 1
        END
    ) AS SameAlertSequence
from
    [dbo].[vw_alert] a
    LEFT JOIN [dbo].[vw_vehicle_average_route] ar ON ar.[VehicleId] = a.VehicleId
order by
    a.VehicleId,
    a.AlertType,
    a.CreatedDateTimeUtc
GO
