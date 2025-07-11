USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_alert_type_severity_est_cost]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_alert_type_severity_est_cost]
AS
SELECT TOP 99999999
    a.[AlertTypeId],
    a.[AlertSeverityId],
    COUNT(*) AS [Alert Count],
    MAX(r.[RepairCostEstimateValue]) AS RepairCostEstimateValue
FROM 
    [fld_rs].[dbo].[Alert] a
LEFT JOIN 
    [dbo].[RepairCostEstimate] r 
    ON a.[RepairCostEstimateId] = r.[Id]
GROUP BY
    a.[AlertTypeId],
    a.[AlertSeverityId]
ORDER BY
    a.[AlertTypeId],
    a.[AlertSeverityId];
GO
