USE SWIGGY;

SELECT * FROM restaurants;

SELECT  COUNT(*) FROM restaurants;

SELECT COUNT(distinct city) FROM restaurants;

SELECT MAX(COST) FROM restaurants;

SELECT name FROM restaurants WHERE cost = 3000;

#sub QUREE

SELECT name FROM restaurants
WHERE cost = (SELECT MAX(COST) FROM restaurants);

-- 1. Which restaurant of abohar is visited by least number of people?



SELECT * FROM restaurants 
WHERE city = "abohar"
AND rating_count = (SELECT MIN(rating_count) FROM restaurants
WHERE city = "abohar");

-- 2. Which restaurant has generated maximum revenue all over india?


SELECT * FROM restaurants
WHERE cost*rating_count = (SELECT MAX(cost*rating_count) FROM restaurants);

-- 3. How many restaurants are having rating more than the average rating?


SELECT COUNT(*) AS Best_rating FROM restaurants
WHERE rating > (SELECT AVG (rating) FROM restaurants);

-- 4. Which restaurant of Delhi has generated most revenue?

SELECT * FROM restaurants
WHERE city = "Delhi" AND 
cost*rating_count = (SELECT MAX(cost*rating_count) FROM restaurants
WHERE city = "Delhi");

-- 5. Which restaurant chain has maximum number of restaurants?
SELECT name, COUNT(name) FROM restaurants
GROUP BY name
ORDER BY COUNT(name)
DESC LIMIT 1;


-- 6.How big is our market?

SELECT 
    COUNT(id) as total_restaurants,
    COUNT(DISTINCT city) as total_cities
FROM restaurants

-- Where is the competition?

SELECT city,
       COUNT(id) restaurants
FROM restaurants
Group by city
Order by restaurants DESC
limit 5;

-- Which city is pricier?
SELECT 
    city, 
    ROUND(AVG(cost), 0) as avg_cost
FROM restaurants
WHERE city IN ('Bangalore', 'Delhi', 'Mumbai')
GROUP BY city
ORDER BY avg_cost DESC;

-- Most popular cuisines?
SELECT 
    cuisine,
    SUM(rating_count) as total_votes
FROM restaurants
GROUP BY cuisine
ORDER BY total_votes DESC
LIMIT 3;

-- Quality vs. Quantity
SELECT 
    cuisine,
    ROUND(AVG(rating), 2) as avg_rating
FROM restaurants
WHERE cuisine IN ('North Indian', 'Chinese', 'Biryani')
GROUP BY cuisine
ORDER BY avg_rating DESC;

-- Finding the Gap (The Opportunity)
SELECT 
    city,
    COUNT(id) as supply,
    SUM(rating_count) as demand
FROM restaurants
WHERE cuisine = 'Biryani'
GROUP BY city
HAVING supply < 50 AND demand > 50000 -- High demand, Low supply
ORDER BY demand DESC
LIMIT 3;


-- Pricing Strategy

SELECT 
    CASE 
        WHEN cost < 300 THEN 'Budget'
        WHEN cost BETWEEN 300 AND 700 THEN 'Mid'
        ELSE 'Luxury' 
    END as segment,
    SUM(rating_count) as total_volume
FROM restaurants
WHERE cuisine = 'Biryani'
GROUP BY 1
ORDER BY total_volume DESC;





    




