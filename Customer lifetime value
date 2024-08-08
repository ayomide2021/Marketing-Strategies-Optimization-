/*
SQL query to calculate customer lifetime value for different customer segment
*/

FROM
      purchase_info AS p
    JOIN
      max_purchase_differences AS d
    USING
      (user_crm_id)
  ),
  clv_info AS (
    SELECT
      u.user_crm_id,
      YrQtr,
      s.traffic_source,
      first_purchase_date,
      transaction_count,
      total_revenue,
      total_shipping,
      transaction_total,
      coupon_type,
      n_coupons,
      days_since_first_purchase,
      days_since_last_purchase,
      max_days_between_purchases,
      list_revenue,
      actual_revenue,
      cost,
      return_revenue,
      (days_since_first_purchase - days_since_last_purchase) + 1 AS lifespan_days,
      CASE
        WHEN u.days_since_first_purchase <= 90 THEN 'New'
        WHEN u.days_since_last_purchase > 365 THEN 'Lapsed'
        WHEN u.transaction_count = 1 AND u.days_since_last_purchase BETWEEN 91 AND 365 THEN 'Single purchase'
        WHEN u.transaction_count > 1 AND u.max_days_between_purchases <= 365 THEN 'Repeat'
        WHEN u.max_days_between_purchases > 365 AND u.max_days_between_purchases <= 730 THEN 'Reactivated'
        WHEN u.max_days_between_purchases > 730 THEN 'Lost'
      END AS customer_group
    FROM
      user_cte AS u
  LEFT JOIN (SELECT DISTINCT * FROM warehouse.sessions) AS s
  ON u.first_purchase_date = s.date AND u.user_crm_id = COALESCE (s.user_crm_id, s.user_cookie_id)
  WHERE traffic_source IN ('google', 'meta', 'rtbhouse', 'tiktok', 'criteo') 
  ),
  cohort_summary AS (
    SELECT
      YrQtr,
      traffic_source,
      customer_group,
      coupon_type,
      SUM(lifespan_days) AS lifespan_days,
      AVG(lifespan_days) / 365 AS customer_lifespan, -- this is recalculated in power bi
      SUM(total_revenue) AS total_revenue,
      SUM(transaction_count) AS total_transactions,
      SUM(transaction_total) AS transaction_total,
      SUM(total_shipping) AS total_shipping,
      SUM(n_coupons) AS n_coupons,
      COUNT(DISTINCT user_crm_id) AS total_customers,
      SUM(list_revenue) AS list_revenue,
      SUM(actual_revenue) AS actual_revenue,
      SUM(cost) AS cost,
      SUM(return_revenue) AS return_revenue
    FROM
      clv_info
    GROUP BY
      YrQtr, traffic_source, customer_group, coupon_type
  )
SELECT *,
(total_revenue / total_customers) * (total_transactions / total_customers) * customer_lifespan AS customer_lifetime_value, -- this is recalculated in Power BI
actual_revenue-cost AS profit_before_return,
actual_revenue-cost-return_revenue AS actual_profit,
(actual_revenue-cost-return_revenue)/actual_revenue AS profit_margin 
FROM
cohort_summary 
ORDER BY YrQtr,
CASE
    WHEN customer_group = 'New' THEN 1
    WHEN customer_group = 'Single Purchase' THEN 2
    WHEN customer_group = 'Returning' THEN 3
    WHEN customer_group = 'Reactivated' THEN 4
    ELSE 5
  END;
