USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_vehicle]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_vehicle]
AS
SELECT
    v.[Id],
    v.[TenantId],
    v.[Vin],
    v.[VehicleName],
    v.[VehicleMakeId],
    v.[VehicleModelId],
    v.[ModelYear],
    v.[EngineModel],
    v.[EngineManufacturer],
    v.[CurrentOdometer],
    v.[CurrentOdometer] / 1609.344 AS [Current Odometer In Miles]
    --,
    --    WHEN v.CurrentOdometer < a.[AlertOdomotor] THEN a.[AlertOdomotor] / 1609.344
    --    ELSE v.CurrentOdometer / 1609.344
    --END AS [Odometer Correction In Miles]
    ,
    v.[CurrentLatitude],
    v.[CurrentLongitude],
    v.[VehicleLocationId]
FROM 
    [fld_rs].[dbo].[Vehicle] v
--LEFT JOIN 
--    [dbo].[vw_alerts_last_per_vehicle_alert_type] a
--    ON v.Id = a.VehicleId;

GO
