{{ config(schema='transaction') }}

WITH 

  sales AS (SELECT * FROM `gz_raw_data.raw_gz_sales`)

  ,product AS (SELECT * FROM `gz_raw_data.raw_gz_product`)

SELECT
  s.date_date
  ### Key ###
  ,s.orders_id
  ,s.pdt_id AS products_id
  ###########
	-- qty --
	,s.quantity AS qty
  -- revenue --
  ,s.revenue AS turnover
  -- cost --
  ,CAST(p.purchSE_PRICE AS FLOAT64) AS purchase_price
	,ROUND(s.quantity*CAST(p.purchSE_PRICE AS FLOAT64),2) AS purchase_cost
	-- margin --
	,Round(s.revenue - s.quantity*CAST(p.purchSE_PRICE AS FLOAT64),2) AS product_margin
    ,{{ margin_percent('s.revenue', 's.quantity*CAST(p.purchSE_PRICE AS FLOAT64)') }} AS margin_percent
    ,Round({{margin('s.revenue','ROUND(s.quantity*CAST(p.purchSE_PRICE AS FLOAT64),2),2)')}} AS margin
FROM sales s
INNER JOIN product p ON s.pdt_id = p.products_id

