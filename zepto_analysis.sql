Drop Table if exists zepto;

create table zepto(
sku_id SERIAL Primary key,
Category varchar (120),
name varchar(150) not null,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

-- data exploration 

-- count of rows 
select count(*) from zepto;


-- sample data 
select * from zepto limit 10;

--null values 
select * from zepto 
where name is null 
or
category is null 
or 
mrp is null 
or 
discountPercent is null 
or
availableQuantity is null
or
discountedSellingPrice is null 
or 
weightInGms is null
or
outOfStock is null
or
quantity is null;

--diffrent product Categories 
select distinct category 
from zepto 
order by category;

-- products in stcock vs out of stock 
select outOfStock, count(sku_id)
from zepto
group by OutOfStock;

-- product names present multiple times 
select name, count(sku_id) as "number of skus"
from zepto
group by name
having count (sku_id) > 1
order by count(sku_id) desc;

-- data cleaning 

-- product with price = 0
select discountedsellingprice, name from zepto
group by 1,2
having discountedsellingprice = 0;

delete from zepto
where mrp = 0;

--covert paise to rupees
update zepto
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

select mrp, discountedSellingPrice from zepto

-- Q1. Find the top 10 best-value products based on the discount percentage

select name, category, discountpercent from zepto
order by discountpercent desc
limit 10;

--Q2 Calculate estimated revenue for each category

select category, sum(discountedsellingprice *
availableQuantity) as revenue
from zepto 
group by 1
order by category asc

--Q3 what are the products with high Mrp but Out of Stock 

select  distinct name, mrp
from zepto
where outofstock = 'true' and mrp >300
order by mrp desc;

-- Q04 find all Products where mrp is greater than 500 and discount is less than 10%

select distinct name, mrp, discountPercent from zepto
where mrp > '500' and discountPercent < '10'

--Q5 identify the top 5 catergories offerning the highest average discount perctange 

select category, avg(
discountedsellingprice) as highestavgdiscount from zepto
group by 1
order by highestavgdiscount desc
limit 5;

-- Q6 find the price per gram for products above 100g and sort by best value 

select distinct name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/WeightInGms,2) as Price_per_gram
from zepto
where weightInGms >= 100
Order by Price_per_gram

--Q7 Group the products into categerios like Low, Medium,bulk

select distinct name, weightInGms,
case when  weightInGms < 1000 then 'Low'
 	when  weightInGms < 5000 then 'Medium'
	 Else 'Bulk'
	 End As weight_category
from zepto

--Q8 what is the total inventory weight Per Category 

select distinct category, Sum(weightingms 
* availableQuantity)as total_weight
 from zepto
 Group by 1
 order by total_weight;

--Q9 top 10 products with highest mrp according to the category

select name, category, mrp from zepto
 where mrp > 1000 
 order by mrp desc
 limit 10;

 --Q10 Get the top 5 catergory offering more discounted price 

 select distinct category, sum(discountedsellingprice) as discount_price from zepto 
 group by 1
 order by discount_price desc
 limit 5;

--Q11 Get the information of products need to be restocked 

 select category, name, availablequantity from zepto
 where availablequantity <=1
 order by category 

--Q12 get the most costliest product from each category 

select Category,name,mrp  
from zepto
where mrp > 1500

--Q13 Get me the number products from each category and having highest products 
select  distinct category,  count(name) as no_of_products   
from zepto
group by 1
ORDER BY no_of_products desc


