# sql_zepto_analysis_project_3
# 📊 Zepto Data Analysis

This SQL project explores the Zepto product dataset to perform data exploration, cleaning, and analysis using PostgreSQL.

![Banner](Red%20Bold%20Finance%20YouTube%20Thumbnail.png)

---

## 📁 Table Schema

```sql
DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
```

---

## 📌 Data Exploration

### 1️⃣ Count of Rows
```sql
SELECT COUNT(*) FROM zepto;
```

### 2️⃣ Sample Data
```sql
SELECT * FROM zepto LIMIT 10;
```

### 3️⃣ Check for NULLs
```sql
SELECT * FROM zepto 
WHERE name IS NULL 
   OR category IS NULL 
   OR mrp IS NULL 
   OR discountPercent IS NULL 
   OR availableQuantity IS NULL 
   OR discountedSellingPrice IS NULL 
   OR weightInGms IS NULL 
   OR outOfStock IS NULL 
   OR quantity IS NULL;
```

### 4️⃣ Unique Product Categories
```sql
SELECT DISTINCT category FROM zepto ORDER BY category;
```

### 5️⃣ Products In Stock vs Out of Stock
```sql
SELECT outOfStock, COUNT(sku_id) FROM zepto GROUP BY outOfStock;
```

### 6️⃣ Product Names Present Multiple Times
```sql
SELECT name, COUNT(sku_id) AS "number of skus"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;
```

---

## 🧹 Data Cleaning

### 7️⃣ Products with Price = 0
```sql
SELECT discountedSellingPrice, name FROM zepto
GROUP BY 1, 2
HAVING discountedSellingPrice = 0;
```

### 8️⃣ Delete MRP = 0
```sql
DELETE FROM zepto WHERE mrp = 0;
```

### 9️⃣ Convert Paise to Rupees
```sql
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;
```

---

## 📈 Business Questions

### Q1. Top 10 Best-Value Products by Discount
```sql
SELECT name, category, discountPercent FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

### Q2. Estimated Revenue by Category
```sql
SELECT category, SUM(discountedSellingPrice * availableQuantity) AS revenue
FROM zepto
GROUP BY 1
ORDER BY category ASC;
```

### Q3. High MRP but Out of Stock Products
```sql
SELECT DISTINCT name, mrp FROM zepto
WHERE outOfStock = 'true' AND mrp > 300
ORDER BY mrp DESC;
```

### Q4. MRP > 500 and Discount < 10%
```sql
SELECT DISTINCT name, mrp, discountPercent FROM zepto
WHERE mrp > '500' AND discountPercent < '10';
```

### Q5. Top 5 Categories by Avg Discounted Price
```sql
SELECT category, AVG(discountedSellingPrice) AS highestavgdiscount
FROM zepto
GROUP BY 1
ORDER BY highestavgdiscount DESC
LIMIT 5;
```

### Q6. Price Per Gram for Products > 100g
```sql
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice / weightInGms, 2) AS Price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY Price_per_gram;
```

### Q7. Group Products by Weight Category
```sql
SELECT DISTINCT name, weightInGms,
CASE 
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category
FROM zepto;
```

### Q8. Total Inventory Weight Per Category
```sql
SELECT DISTINCT category, SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY 1
ORDER BY total_weight;
```

### Q9. Top 10 Highest MRP Products
```sql
SELECT name, category, mrp FROM zepto
WHERE mrp > 1000
ORDER BY mrp DESC
LIMIT 10;
```

### Q10. Top 5 Categories by Total Discount Price
```sql
SELECT DISTINCT category, SUM(discountedSellingPrice) AS discount_price
FROM zepto
GROUP BY 1
ORDER BY discount_price DESC
LIMIT 5;
```

### Q11. Products That Need Restocking
```sql
SELECT category, name, availableQuantity FROM zepto
WHERE availableQuantity <= 1
ORDER BY category;
```

### Q12. Most Costly Products in Each Category
```sql
SELECT category, name, mrp FROM zepto
WHERE mrp > 1500;
```

### Q13. Product Count Per Category (Sorted)
```sql
SELECT DISTINCT category, COUNT(name) AS no_of_products
FROM zepto
GROUP BY 1
ORDER BY no_of_products DESC;
```

---

**Author:** Shanmukha Sai Bada  
📧 sb3869@nau.edu  
🔗 [LinkedIn](https://www.linkedin.com/in/shanmukha-sai-bada/)
