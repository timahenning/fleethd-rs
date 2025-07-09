USE 
[fld_rs]
GO

SELECT TOP 10
       Component_Description
      ,SUM([Total_Work_Order_USD]) AS [Total_Work_Order_USD]
  FROM [fld_rs].[dbo].[dr-pepper-2023-work-orders]
  WHERE
    Component_Description IS NOT NULL
    GROUP BY Component_Description
    ORDER BY SUM([Total_Work_Order_USD]) DESC


-- Single most expensive work orders
SELECT TOP 40
       Component_Description
       ,Work_Order
      ,SUM([Total_Work_Order_USD]) AS [Total_Work_Order_USD]
  FROM [fld_rs].[dbo].[dr-pepper-2023-work-orders]
  WHERE
    
    -- Single most expensive repair. Excluding non-alerting fixes
    Component_Description IS NOT NULL AND Component_Description NOT IN('Body', 'Frame Assembly  Components', 
    'Paint - Finish, Vehicle', 'Hood', 'FRAME - DOOR','FRAME - ROLL-UP DOOR', 'Panel - Cab Or Front Door, Outer')
    GROUP BY Component_Description,Work_Order
    ORDER BY SUM([Total_Work_Order_USD]) DESC


-- Occurence rate of most accumulative component costs.
select TOP 30
    t2.Component_Description
    ,COUNT(t2.Component_Description) AS Occurence
     , (SELECT COUNT(Work_Order) FROM [dbo].[dr-pepper-2023-work-orders]) AS [Total Work Orders]
    ,SUM(t2.[Total_Work_Order_USD]) AS [Total_Work_Order_USD]
FROM [dbo].[dr-pepper-2023-work-orders] t2
WHERE
   t2.Component_Description IN 
        (
        -- Most expensive agg repairs by component
        SELECT TOP 1000
               Component_Description
          FROM [dbo].[dr-pepper-2023-work-orders]
          WHERE
            Component_Description IS NOT NULL AND Component_Description NOT IN('Body', 'Frame Assembly  Components')
            GROUP BY Component_Description--,Work_Order
            ORDER BY SUM([Total_Work_Order_USD]) DESC
        )
GROUP BY
    t2.Component_Description
    --HAVING COUNT(t2.Component_Description) > 3
ORDER BY COUNT(t2.Component_Description) DESC

--select count(*), SUM([Total_Work_Order_USD])  from .[dbo].[dr-pepper-2023-work-orders] where Component_Description = 'Fuel System'