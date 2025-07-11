USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_agg_vrms_componet_expenses_per_vehicle]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE VIEW [dbo].[vw_agg_vrms_componet_expenses_per_vehicle] AS
SELECT
  t.VMRS_Component_Description AS [VMRS Component],
  AVG(t.TOTAL) AS [Average Total]
FROM
  (
    SELECT
      [Equipment],
      [VMRS_Component_Description],
      SUM([Total]) AS TOTAL -- Summarized vehicle cost.
    FROM
      [fld_rs].[dbo].[dr-pepper-2023-vehicle-maintenance-cost]
    GROUP BY
      [Equipment],
      [VMRS_Component_Description]
  ) t
GROUP BY
  VMRS_Component_Description
GO
