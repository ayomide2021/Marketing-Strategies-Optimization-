# Marketing-Strategies-Optimization

# Overview
In this project, a large e-commerce dataset was analysed to uncover valuable insights into Marketing strategies optimization  with focus on marketing channels.  Utilizing SQL, Google Sheets, and Power BI, I processed and visualized over 500 million rows of data stored in Google BigQuery.  

# Problem Statement
There has been a significant increase in coupon usage among customers recently. We are spending a lot of marketing budget on coupons which attract customers to our brand. However, this marketing strategy is impacting our profit negatively and is not sustainable. Considering this, we need to improve coupon usage and explore alternative strategies to address this challenge. 
The question is what should we do? How can we optimise our marketing budget to provide increased customer value while improving profitability?

# Data Description
Dataset Size: Over 500 million rows of data pipelines
Source: Google BigQuery
Key Attributes: customer id, transaction id, Purchase date, transaction revenue, customer demographics, item quantity, item price, cost of goods sold (COGS), marketing channels. 

# Process and Methodology
## Data Cleaning
•	Utilized SQL to remove duplicates 

•	Handled null values.

•	Ensured data consistency and accuracy.

•	Removed irrelevant data from the analysis. 

## Data Analysis  and Visualization
•	Exported cleaned  and aggregated data to Google Sheets for initial analysis.
•	Created powerful visuals and interactive dashboards in Power BI to visualize key metrics and trends.

![Week _9_Red_Team_ Project presentation_template (3)_page-0003](https://github.com/ayomide2021/Marketing-Strategies-Optimization-/assets/83126882/679e25bf-9f4a-4636-971a-4a9ea729191a)

![Week _9_Red_Team_ Project presentation_template (3)_page-0004](https://github.com/ayomide2021/Marketing-Strategies-Optimization-/assets/83126882/d4df1b3b-b07c-40a8-8c57-229809294efe)
![Week _9_Red_Team_ Project presentation_template (3)_page-0005](https://github.com/ayomide2021/Marketing-Strategies-Optimization-/assets/83126882/08c818e2-4dbf-4ad4-b9e4-c70a8fa9998d)
![Week _9_Red_Team_ Project presentation_template (3)_page-0006](https://github.com/ayomide2021/Marketing-Strategies-Optimization-/assets/83126882/520169fe-4d4e-4d65-82d8-8513b60645b3)
![Week _9_Red_Team_ Project presentation_template (3)_page-0007](https://github.com/ayomide2021/Marketing-Strategies-Optimization-/assets/83126882/a4c0850f-8781-4752-a5d8-917ce0d947bd)
![Week _9_Red_Team_ Project presentation_template (3)_page-0008](https://github.com/ayomide2021/Marketing-Strategies-Optimization-/assets/83126882/875039ca-2022-474e-af98-57f21241f0f4)
![Week _9_Red_Team_ Project presentation_template (3)_page-0009](https://github.com/ayomide2021/Marketing-Strategies-Optimization-/assets/83126882/8361082d-7ce8-465e-9f0a-5e51bedbafc3)






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

