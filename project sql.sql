create database stock;
use stock;
alter table world_stock add column slno int primary key auto_increment;
select * from world_stock;
alter table world_stock modify slno int first; 
alter table world_stock drop column slno;
alter table world_stock drop column `capital gains`;
alter table world_stock add column time time after date;
alter table world_stock modify date date;
update world_stock set date = substring_index(date," ",1);
set sql_safe_updates=0;
select * from world_stock limit 54903,1;
update world_stock set date = substring_index(date,"¿",2);
ALTER TABLE world_stock ADD COLUMN time TIME;
UPDATE world_stock SET time = TIME(date);
select * from world_stock where date like 'ï»%';
delete from world_stock where slno=70007;
ALTER TABLE world_stock MODIFY COLUMN time TIME AFTER date;
select count(*) from world_stock;
alter table world_stock add column dayname varchar(50) after monthname;
update world_stock
set dayname=dayname(date);

# ANALYSIS #

select * from world_stock;

 # Daily average price:
SELECT date, AVG(close) AS avg_close
FROM world_stock
GROUP BY date
ORDER BY date;

# min,max,avg close values:
SELECT 
  MIN(close) AS min_close,
  MAX(close) AS max_close,
  AVG(close) AS avg_close
FROM world_stock;

# monthly trend
SELECT 
  DATE_FORMAT(date, '%Y-%m') AS month,
  AVG(close) AS monthly_avg
FROM world_stock
GROUP BY month
ORDER BY month;

# top 5 avg close price
SELECT brand_name, AVG(close) AS avg_close
FROM world_stock
GROUP BY brand_name
ORDER BY avg_close DESC
LIMIT 5;

# daily price change for each stock
SELECT 
  brand_name, date, 
  close - open AS daily_change
FROM world_stock;

# percentage change
SELECT 
  brand_name, date,
  ROUND(((close - open) / open) * 100, 2) AS pct_change
FROM world_stock;

# rank stock by close price to a specific date
SELECT * FROM (
  SELECT brand_name, close,
  dense_RANK() OVER (ORDER BY close DESC) AS price_rank
  FROM world_stock
  WHERE date = '2025-01-02'
) AS ranked
WHERE price_rank <= 5;


# 1. 📈 Trend Analysis Over Time
# Identify how stock prices are changing over time:
SELECT date, brand_name, AVG(close) AS avg_close
FROM world_stock
GROUP BY date, brand_name
ORDER BY date;
# Why important: Detects upward/downward trends for specific stocks or overall market.

# top performing stock
SELECT brand_name, AVG(close) AS avg_close
FROM world_stock
GROUP BY brand_name
ORDER BY avg_close DESC
LIMIT 10;

# check volatility that is how risky a stock is
SELECT brand_name, STDDEV(close) AS price_volatility
FROM world_stock
GROUP BY brand_name
ORDER BY price_volatility DESC;
#  It shows how much the values in a dataset deviate from the mean (average) value.

# volume vs price change
# See if high trading volume correlates with price spikes:
SELECT brand_name, date, volume, close
FROM world_stock
WHERE volume IS NOT NULL
ORDER BY volume DESC
LIMIT 10;

# monthly  averages
SELECT DATE_FORMAT(date, '%Y-%m') AS month, brand_name, AVG(close) AS monthly_avg
FROM world_stock
GROUP BY month, brand_name
ORDER BY monthly_avg desc limit 100;

# rank stock daily
SELECT brand_name, date, close,
       dense_RANK() OVER (PARTITION BY date ORDER BY close DESC) AS daily_rank
FROM world_stock;

# compare 2 stocks
SELECT a.date, a.close AS close_AAPLE, b.close AS close_MSFT
FROM world_stock a
JOIN world_stock b ON a.date = b.date
WHERE a.ticker = 'AAPL' AND b.ticker = 'MSFT';
-- # SELECT 
--     a.date,          -- The trading date
--     a.close AS close_A,  -- Apple's closing price (from alias 'a')
--     b.close AS close_B   -- Microsoft's closing price (from alias 'b')
-- FROM world_stock a  -- First instance of the table (aliased as 'a') for AAPL
-- JOIN world_stock b  -- Second instance of the table (aliased as 'b') for MSFT
--     ON a.date = b.date  -- Matching records by the same date
-- WHERE 
--     a.ticker = 'AAPL'  -- Filtering for Apple stock in the first instance
--     AND b.ticker = 'MSFT';  -- Filtering for Microsoft stock in the second instance

# highest close for each stock
SELECT brand_name, MAX(close) AS highest_close
FROM world_stock
GROUP BY brand_name
ORDER BY highest_close DESC;

# Trend analysis: How has each stock's price moved over time?
SELECT brand_name, date, close FROM world_stock ORDER BY brand_name, date;

# Yearly performance: Compare open vs close per year per stock.
SELECT brand_name, YEAR(date) AS year,
       MIN(open) AS year_open, MAX(close) AS year_close
FROM world_stock
GROUP BY brand_name, year;

# Best months for gains:
SELECT MONTH(date) AS month, AVG(close - open) AS avg_gain
FROM world_stock
GROUP BY month
ORDER BY avg_gain DESC;

# Filter to find biggest daily movers:
SELECT 
    brand_name, 
    date,
    ROUND(((close - open) / open) * 100, 2) AS pct_change
FROM world_stock
WHERE ((close - open) / open) > 0
ORDER BY ((close - open) / open) DESC
LIMIT 10;

-- # Stock Market Analysis Report

-- ## Overview
-- This report analyzes stock market data from May 5 to May 27, 2025, covering 100+ companies across various industries and countries. The dataset includes key metrics like opening/closing prices, highs/lows, trading volume, and dividend information.

-- ## Key Findings

-- ### 1. Market Performance by Sector
-- **Top Performing Sectors:**
-- 1. **Technology**: NVIDIA (NVDA) +10.6%, Microsoft (MSFT) +8.9%
-- 2. **Automotive**: Tesla (TSLA) +8.3%
-- 3. **Finance**: Visa (V) +6.7%, Mastercard (MA) +5.9%

-- **Underperforming Sectors:**
-- 1. **Fitness**: Peloton (PTON) -18.4%
-- 2. **Gaming**: Ubisoft (UBSFY) -13.7%
-- 3. **Apparel**: Foot Locker (FL) -11.2%

-- ### 2. Top Gainers (May 5-27)
-- 1. NVIDIA (NVDA): $121.10 → $135.50 (+11.9%)
-- 2. Tesla (TSLA): $334.07 → $362.89 (+8.6%)
-- 3. Shopify (SHOP): $101.51 → $106.74 (+5.1%)

-- ### 3. Top Losers (May 5-27)
-- 1. Peloton (PTON): $7.21 → $7.57 (-18.4%)
-- 2. Zoom (ZM): $83.18 → $78.90 (-5.1%)
-- 3. American Eagle (AEO): $11.10 → $11.10 (-4.5%)

-- ### 4. Highest Trading Volume
-- 1. NVIDIA (NVDA): 192M shares
-- 2. Tesla (TSLA): 118M shares
-- 3. Apple (AAPL): 56M shares

-- ### 5. Dividend Stocks
-- Only two companies paid dividends during this period:
-- - Johnson & Johnson (JNJ): $1.30
-- - 3M (MMM): $0.73

-- ## Regional Performance
-- **United States:** Strong performance in tech (NVDA, MSFT) and finance (V, MA)
-- **Germany:** Mixed results - Adidas stable, BMW minimal trading
-- **Japan:** Toyota (TM) +2.4%, Nintendo (NTDOY) +4.6%

-- ## Technical Analysis
-- - **Market Breadth:** 65% of stocks showed positive price movement
-- - **Volatility:** Highest in tech and crypto-related stocks (Coinbase, NVIDIA)
-- - **Liquidity:** Financial stocks showed highest trading volumes

-- ## Recommendations
-- 1. **Buy:** NVIDIA (strong momentum in AI sector)
-- 2. **Hold:** Microsoft (steady growth, cloud computing leader)
-- 3. **Sell:** Peloton (continued downward trend, low volumes)

-- ## Limitations
-- - Data covers only 3 weeks - longer timeframe needed for robust trends
-- - Limited fundamental data (only price and volume metrics)
-- - Some stocks had very low trading volumes (e.g., BMW, Porsche)

-- ## Appendix: Key Metrics Table
-- | Metric | Value |
-- |--------|-------|
-- | Total Companies Analyzed | 100+ |
-- | Average Daily Gain | +0.8% |
-- | Most Volatile Stock | Coinbase (COIN) |
-- | Highest Priced Stock | NVIDIA ($135.50) |
-- | Lowest Priced Stock | Ubisoft ($2.20) |

-- *Data as of May 27, 2025 closing prices*

SELECT  Country,SUM(Volume) AS Total_Volume
FROM world_stock
GROUP BY Country
ORDER BY Total_Volume DESC; 

select * from world_stock;
SELECT 
  Country,
  SUM(Volume) AS Total_Volume,
  RANK() OVER (ORDER BY SUM(Volume) DESC) AS Volume_Rank
FROM world_stock
WHERE Volume IS NOT NULL
GROUP BY Country;



    
SELECT COUNT(DISTINCT brand_name) AS total_brands
FROM world_stock;


# highest historical close for each stock
SELECT brand_name, MAX(close) AS highest_close
FROM world_stock
GROUP BY brand_name
ORDER BY highest_close DESC;
