# Marketing-Strategies-Optimization

# Executive Summary

The analysis of the impact of discounts on customer behavior reveals that while these incentives drive revenue through repeat purchases, they also significantly affect profitability. Based on the findings, I recommend two potential solutions for moving forward:
1.	Opportunity 1
 •	Insight: 10% off and 15% off coupons appear to be more profitable out of all the coupon types, in terms of profit and number of coupon usage.
 •	Recommendations: As lower value coupons are desirable, we recommend scraping 10% coupons and keeping 15% coupons with £30 order value threshold
 •	Financial impact: Adding a threshold of £30 for coupon usage, 15% coupons could potentially bring in £15000, (10% coupons would only bring in an additional ~£3000). With removing 10% coupons completely we could recoup £43000.

2.	Opportunity 2
 •	Insights: Google is performing better than all other channels in terms of number of coupon usage, CLV, acquiring new customers, revenue and ROAS.
 •	Recommendations: Based on this, we recommend optimising our investments in Google to improve our profitability while maintaining customer engagement. Shift some budget to google channel.
 •	Financial impact: by using Keyword Optimization, the project net profit of £100K could be achieved.
By implementing either of these solutions, the company can better manage the trade-off between driving revenue through repeat purchases and maintaining profitability. The recommended adjustments aim to find a middle ground that sustains customer engagement without compromising the company's financial health.





# Tech Used

•	BigQuery (database)

•	SQL

•	Power BI

•	Google Sheets


# Process and Methodology
## Data Cleaning
•	Utilized SQL to remove duplicates 

•	Handled null values.

•	Ensured data consistency and accuracy.

•	Removed irrelevant data from the analysis. 

## Data Analysis  and Visualization
•	Exported cleaned  and aggregated data to Google Sheets for initial analysis.
•	Created powerful visuals and interactive dashboards in Power BI to visualize key metrics and trends.

![Project 9_page-0003](https://github.com/user-attachments/assets/54f212c8-fbc3-4fa2-8df9-fe0bab228e6c)

![Project 9_page-0004](https://github.com/user-attachments/assets/5b9c3e9d-8bbd-4df4-8d6d-531a3516ceed)

![Project 9_page-0005](https://github.com/user-attachments/assets/47e13d2e-2399-4dac-90b7-38b18f2b3261)

![Project 9_page-0006](https://github.com/user-attachments/assets/cc5721d2-3a3d-4912-b8e6-866b2de82877)

![Project 9_page-0007](https://github.com/user-attachments/assets/a52b75f7-f513-4356-8bcd-d1ec167e9c88)

![Project 9_page-0008](https://github.com/user-attachments/assets/8a74250a-d7de-497c-b8c0-6ac126ca6109)

![Project 9_page-0009](https://github.com/user-attachments/assets/35730be4-3bc3-4b37-8724-559aee9115de)



# Results and Insights

## Key Findings and Insights
•	Coupons are driving net profit growth. 

•	10% off and 15% off coupons are more profitable out of all the coupon types as they bring in the highest transaction revenue and net profit.

•	Google has sustained strong performance throughout, characterized by notable improvements in Return on Ad Spend (ROAS), number of customers, revenue and coupon usage. 

•	T-shirts reign in popularity through Google channel. 

# Recommendations and Impacts
## Opportunity 1
**Insight**: 10% off and 15% off coupons appear to be more profitable out of all the coupon types, in terms of profit and number of coupon usage.

**Recommendations**: As lower value coupons are desirable, we recommend scraping 10% coupons and keeping 15% coupons with £30 order value threshold

**Financial impact**:  Adding a threshold of £30 for coupon usage, 15% coupons could potentially bring in £15000, (10% coupons would only bring in an additional ~£3000). With removing 10% coupons completely we could recoup £43000. 

## Opportunity 2
**Insights**: Google is performing better than all other channels in terms of number of coupon usage, CLV, acquiring new customers, revenue and ROAS.

**Recommendations**: Based on this, we recommend optimising our investments in Google to improve our profitability while maintaining customer engagement. Shift some budget to google channel.  

**Financial impact**: by using Keyword Optimization, the net profit could increase by over £1M. 

# Conclusion 
This project demonstrated the significant impact of data-driven decisions on business performance. By using data analytics tools and techniques, I provided actionable insights, recommendations, and detailed the financial impacts of these recommendations, which were then presented to stakeholders.

# Technical Details 
## Sample SQL code snippets

SELECT  
  coupon_type,
  
  COUNT(coupon_type) AS n_coupons,
  
  SUM(CASE 
    WHEN coupon_type = '10% OFF' AND transaction_revenue <= 30.0 THEN 1
    
    WHEN coupon_type = '15% OFF' AND transaction_revenue <= 30.0 THEN 1
    
  END) AS n_coupons_30_cutoff,
  
  ROUND(SUM(CASE 
    WHEN coupon_type = '10% OFF' THEN transaction_revenue/(1-0.10)
    
    WHEN coupon_type = '15% OFF' THEN transaction_revenue/(1-0.15)
    
  END),2) AS original_revenue,
  
  ROUND(SUM(transaction_revenue),2) AS discounted_revenue,
  
  ROUND(SUM(CASE 
  
    WHEN coupon_type = '10% OFF' AND transaction_revenue <= 30.0 THEN transaction_revenue*0.10/(1-0.10)
    
    WHEN coupon_type = '15% OFF' AND transaction_revenue <= 30.0 THEN transaction_revenue*0.15/(1-0.15)
    
  END),2) AS additional_revenue_30_cutoff,
  
FROM prism-insights.red_team_mc1.transactions_table

WHERE coupon_type IN ('10% OFF','15% OFF')

GROUP BY 1

ORDER BY 1

## Sample Power BI Steps

### Net profit in Power BI

net_profit = IF(transactions_table[return_status] = "Refund", 

transactions_table[transaction_profit] - transactions_table[item_quantity]*transactions_table[item_price],

transactions_table[transaction_profit])

### Discount usage calculation in Power BI
discount_usuage = SWITCH(transactions_table[coupon_type], 

"00% OFF", transactions_table[Revenue]*0.00,

"10% OFF", transactions_table[Revenue]*0.10,

"15% OFF", transactions_table[Revenue]*0.15,

"20% OFF", transactions_table[Revenue]*0.20,

"25% OFF", transactions_table[Revenue]*0.25,

"30% OFF", transactions_table[Revenue]*0.30,

"35% OFF", transactions_table[Revenue]*0.35,

"40% OFF", transactions_table[Revenue]*0.40,

"45% OFF", transactions_table[Revenue]*0.45,

"50% OFF", transactions_table[Revenue]*0.50)

