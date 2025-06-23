
# 📊 World Stock Market SQL Analysis

This project presents a comprehensive SQL-based analysis of global stock market data, covering stock price trends, volatility, daily changes, and performance metrics across various countries and sectors.

## 📁 Dataset Information

- **Database**: `stock`
- **Table**: `world_stock`
- **Fields**: Date, Open, Close, High, Low, Volume, Brand Name, Ticker, Country, etc.
- **Preprocessing**: Added/modified columns like `date`, `time`, `dayname`; cleaned malformed entries; removed irrelevant fields like `capital gains`.

---

## 🔧 Data Cleaning & Transformation

- Removed unnecessary columns (e.g., `capital gains`)
- Extracted `date` and `time` from combined fields
- Reformatted column types
- Added helper columns like `dayname` for weekday-level analysis

---

## 📈 Key SQL Analyses

### 1. **Descriptive Statistics**
- Daily Average Close Price
- Min, Max, and Average Close Values

### 2. **Trend Analysis**
- Monthly Close Trends
- Price Change & % Change Calculations
- Yearly Open vs Close

### 3. **Stock Performance**
- Top 5 Stocks by Average Close Price
- Highest Historical Close per Stock
- Best Months for Gains

### 4. **Volatility & Risk**
- Standard Deviation of Prices per Stock
- Ranking by Daily Close Price

### 5. **Volume Analysis**
- Top 10 Days by Volume
- Volume vs Price Movements
- Country-wise Total Volume and Rankings

### 6. **Stock Comparisons**
- AAPL vs MSFT Daily Closes
- Sector-level Comparisons
- Regional Performance Insights

---

## 📊 Sample Queries

```sql
-- Top 5 stocks with highest average close
SELECT brand_name, AVG(close) AS avg_close
FROM world_stock
GROUP BY brand_name
ORDER BY avg_close DESC
LIMIT 5;

-- Daily percent change
SELECT brand_name, date,
ROUND(((close - open) / open) * 100, 2) AS pct_change
FROM world_stock;
```

---

## 🧠 Insights

- **Top Gainers**: NVIDIA, Tesla, Shopify
- **Top Losers**: Peloton, Zoom, Foot Locker
- **Volatility Leaders**: Coinbase, NVIDIA
- **Most Traded**: NVIDIA, Tesla, Apple
- **Best Performing Sector**: Technology
- **Underperformers**: Fitness, Apparel

---

## 🌍 Country-Wise Volume Analysis

```sql
SELECT 
  Country, 
  SUM(Volume) AS Total_Volume,
  RANK() OVER (ORDER BY SUM(Volume) DESC) AS Volume_Rank
FROM world_stock
WHERE Volume IS NOT NULL
GROUP BY Country;
```

---

## 📌 Recommendations

| Action | Stock      | Reason                             |
|--------|------------|------------------------------------|
| Buy    | NVIDIA     | Strong AI growth momentum          |
| Hold   | Microsoft  | Consistent performance, cloud edge |
| Sell   | Peloton    | Declining trend and low volume     |

---

## ⚠️ Limitations

- Short timeframe (3 weeks of data)
- Missing fundamentals (e.g., EPS, P/E)
- Some stocks with limited trading data

---

## 📚 Appendix

| Metric                  | Value       |
|-------------------------|-------------|
| Total Companies         | 100+        |
| Avg Daily Gain          | +0.8%       |
| Most Volatile           | Coinbase    |
| Highest Priced Stock    | NVIDIA      |
| Lowest Priced Stock     | Ubisoft     |

---

Feel free to suggest improvements or extend this project with additional features such as Python/Power BI visualizations or ML-based trend forecasting.
