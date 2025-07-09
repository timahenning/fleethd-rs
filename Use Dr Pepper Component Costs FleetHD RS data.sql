--AlertTypeDescription
--Vehicle Alert - Transmission Oil Temperature


select DISTINCT
at.[AlertTypeDescription]
,b.*
from
[dbo].[Alert] a
    inner Join dbo.AlertType at
        on at.Id = a.AlertTypeId

    LEFT JOIN 
(
-- Decode FleetHD Alerts
SELECT s.[VMRS Component]
      ,s.[Average Total] AS [Average Total Per Vehicle]
      ,v.[FleetHD_Alerts]
  FROM [fld_rs].[dbo].[vw_summarized_vrms_componet_expenses_per_vehicle]  s
      LEFT JOIN [dbo].[dr-pepper-2023-vmrs-codes-fleethd] v
        on s.[VMRS Component] = v.[VMRS_Component_Description]
) b
    on 'Vehicle Alert - ' + b.[FleetHD_Alerts] = at.AlertTypeDescription
WHERE 
    b.[VMRS Component] IS NOT NULL