/* Count of transactions by Discount coupon types for each digital marketing channele and medium on quarterly basis*/

SELECT
  DATE_TRUNC(DATE(t.date), QUARTER) AS quarter,
  s.traffic_source,
  (CASE 
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
  COUNT(transaction_coupon) AS n_coupons
FROM (SELECT DISTINCT * FROM warehouse.transactions) AS t
JOIN (SELECT DISTINCT * FROM warehouse.sessions) AS s
ON t.date = s.date AND t.session_id = s.session_id
WHERE t.date < '2022-10-01' AND t.transaction_coupon IS NOT NULL AND  traffic_source IN ('google', 'meta', 'rtbhouse', 'tiktok', 'criteo') --AND traffic_medium IN ('cpc', 'cpm', 'influencer')
GROUP BY 1,2,3
ORDER BY 1,2,3
