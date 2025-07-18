USE [fld_rs]
GO
/****** Object:  View [dbo].[vw_agg_total_by_equipment_wo_component]    Script Date: 7/9/2025 6:17:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_agg_total_by_equipment_wo_component]
AS
SELECT
  TOP 999999999 t.[Component] AS [VRMS Component Code],
  t.Component_Description,
  AVG(t.[Total by Equipment WO Component]) AS [Average Total by Equipment WO Component],
  MAX(t.[Total by Equipment WO Component]) AS [Max Total by Equipment WO Component],
  MAX(t.[Total by Equipment WO Component]) - AVG(t.[Total by Equipment WO Component]) AS [Max Avg Cost Diff],
  CASE
    WHEN AVG(t.[Total by Equipment WO Component]) <> 0 THEN (
      MAX(t.[Total by Equipment WO Component]) - AVG(t.[Total by Equipment WO Component])
    ) / AVG(t.[Total by Equipment WO Component])
    ELSE 0
  END AS [Percentage Cost Increase]
FROM
  (
    SELECT
      [Equipment],
      [Component],
      [Work_Order],
      [Component_Description],
      SUM([Total_Work_Order_USD]) AS [Total by Equipment WO Component]
    FROM
      [fld_rs].[dbo].[dr-pepper-2023-work-orders]
    GROUP BY
      [Equipment],
      [Component],
      [Work_Order],
      [Component_Description]
  ) t
GROUP BY
  t.[Component],
  t.Component_Description
ORDER BY
  t.[Component_Description]
GO
