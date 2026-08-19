use retail_sales;

-- 1. Total sales, profit, orders overview
SELECT 
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM cleaned_superstore;

-- 2. Monthly sales trend
SELECT Order_Month, ROUND(SUM(Sales),2) AS monthly_sales
FROM cleaned_superstore
GROUP BY Order_Month
ORDER BY Order_Month;

-- 3. Top 10 products by sales
SELECT Product_Name, ROUND(SUM(Sales),2) AS total_sales
FROM cleaned_superstore
GROUP BY Product_Name
ORDER BY total_sales DESC
LIMIT 10;

-- 4. Region-wise profit
SELECT Region, ROUND(SUM(Sales),2) AS sales, ROUND(SUM(Profit),2) AS profit
FROM cleaned_superstore
GROUP BY Region
ORDER BY profit DESC;

-- 5. Year-over-year growth using window function
SELECT Order_Year, 
    ROUND(SUM(Sales),2) AS yearly_sales,
    LAG(ROUND(SUM(Sales),2)) OVER (ORDER BY Order_Year) AS prev_year_sales,
    ROUND((SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY Order_Year)) / LAG(SUM(Sales)) OVER (ORDER BY Order_Year) * 100, 2) AS yoy_growth_pct
FROM cleaned_superstore
GROUP BY Order_Year;

-- 6. Category-wise performance with discount impact
SELECT Category, Sub_Category,
    ROUND(SUM(Sales),2) AS sales,
    ROUND(AVG(Discount),2) AS avg_discount,
    ROUND(SUM(Profit),2) AS profit
FROM cleaned_superstore
GROUP BY Category, Sub_Category
ORDER BY profit ASC
LIMIT 10;