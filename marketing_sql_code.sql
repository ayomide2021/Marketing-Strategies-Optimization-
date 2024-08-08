/*
This query joins transactions, transactionsanditems, sessions, productattributes, product_costs and product_returns tables. 
The data from '2022-10-01' is disregarded and focus is only on 5 marketing channels.
The query also categorises the discount coupons based on the discount they offer.
*/

SELECT 
  t.date,
  --t.transaction_id,
  --ti.item_id,
  pa.item_name,
  pa.item_sub_category AS item_subcategory,
  pa.item_main_category AS item_category,
  pa.item_brand AS item_brand,
  s.traffic_source AS traffic_source,
  ti.item_quantity,
  ti.item_price AS item_price,
  -- Adds a distribution cost of 5.24 to every item
  ROUND((pc.cost_of_item + 5.24),2) AS item_cost,
  -- Revenue from an item using quantity and price (before applying discount)
  ROUND((ti.item_quantity * ti.item_price),2) AS Revenue,
  -- Cost of an item using quantity and cost
  ROUND((ti.item_quantity * (pc.cost_of_item + 5.24)),2) AS Cost,
  -- Gross profit for an item using quantity, price and cost
  ROUND((ti.item_quantity * (ti.item_price - (pc.cost_of_item + 5.24))),2) AS Profit,
  pr.return_status,
  -- Creates category of discount coupons based on the last 2 letters, 50% off for PRSMFRND coupons
  (CASE 
    WHEN t.transaction_coupon IS NULL THEN '00% OFF'
    WHEN t.transaction_coupon LIKE '%10' THEN '10% OFF'
    WHEN t.transaction_coupon LIKE '%15' THEN '15% OFF'
    WHEN t.transaction_coupon LIKE '%20' THEN '20% OFF'
    WHEN t.transaction_coupon LIKE '%25' THEN '25% OFF'
    WHEN t.transaction_coupon LIKE '%30' THEN '30% OFF'
    WHEN t.transaction_coupon LIKE '%35' THEN '35% OFF'
    WHEN t.transaction_coupon LIKE '%40' THEN '40% OFF'
    WHEN t.transaction_coupon LIKE '%45' THEN '45% OFF'
    WHEN t.transaction_coupon LIKE 'PRSMFRND%' OR t.transaction_coupon LIKE '%50'THEN '50% OFF'
    ELSE 'Other'
  END) AS coupon_type,
  -- Transaction revenue for an item taken from transactions table (probably after applying discount)
  t.transaction_revenue,
  ROUND((t.transaction_revenue - ti.item_quantity * (pc.cost_of_item + 5.24)),2) AS transaction_profit
FROM (SELECT DISTINCT * FROM warehouse.transactions) AS t
JOIN (SELECT DISTINCT * FROM warehouse.transactionsanditems) AS ti
ON t.transaction_id = ti.transaction_id
JOIN (SELECT DISTINCT * FROM warehouse.sessions) AS s
ON t.session_id = s.session_id AND t.date = s.date
JOIN (SELECT DISTINCT * FROM warehouse.productattributes) AS pa
ON ti.item_id = pa.item_id
JOIN (SELECT DISTINCT * FROM warehouse.product_costs) AS pc
ON ti.item_id = pc.item_id
LEFT JOIN (SELECT DISTINCT * FROM warehouse.product_returns) AS pr
ON t.transaction_id = pr.transaction_id AND ti.item_id = pr.item_id
WHERE t.date < '2022-10-01' AND s.traffic_source IN ('google', 'meta', 'rtbhouse', 'tiktok', 'criteo')
