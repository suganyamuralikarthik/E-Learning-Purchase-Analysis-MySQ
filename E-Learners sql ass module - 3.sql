/*CREATE DATABASE*/
CREATE DATABASE if not exists elearning_db;
USE elearning_db;

/*CREATE LEARNERS TABLE*/
CREATE TABLE learners (
learner_id INT PRIMARY KEY,
full_name VARCHAR(100),
country VARCHAR(100) NOT NULL
);

/*CREATE COURSES TABLE*/
CREATE TABLE courses(
course_id INT PRIMARY KEY, 
course_name VARCHAR(100) NOT NULL,
category VARCHAR(50) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL
);

/*CREATE PURCHASES TABLE*/
CREATE TABLE purchases (
purchase_id INT PRIMARY KEY,
learner_id INT NOT NULL, 
course_id INT NOT NULL,
quantity INT NOT NULL,
purchase_date DATE NOT NULL,
FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

/*INSERT LEARNERS*/
INSERT INTO learners(learner_id,full_name,country)
VALUES 
(1,'Divya','India'),
(2,'ramya','USA'),
(3,'Gopi','USA'),
(4,'Suganya','Malaysia'),
(5,'muthu','Indai')
;

/*INSERT COURSES*/
INSERT INTO courses (course_id,course_name,category,unit_price)
VALUES
(1,'Data analyst','Beginner',45000.00),
(2,'SAP','Intermediate',35000.00),
(3,'Data analyst','advanced',60000.00),
(4,'delevoping','intermediate',50000.00),
(5,'fullstack','beginner',55000.00);

/*INSERT LEARNERS*/
INSERT INTO purchases (purchase_id,learner_id,course_id,quantity,purchase_date)
VALUES
(101,1,1,2,'2026-09-07'),
(102,2,2,3,'2026-07-23'),
(103,3,3,2,'2026-04-21'),
(104,4,4,1,'2026-05-12'),
(105,5,5,1,'2026-12-09');

INSERT INTO purchases (purchase_id,learner_id,course_id,quantity,purchase_date)
VALUES
(106,1,3,2,'2026-09-06'),
(107,2,4,2,'2026-01-12');

/*INNER JOIN*/   
SELECT l.full_name AS  Learner_name,
c.course_name AS Course_name ,
c.category AS Category,
p.quantity AS Quantity,
ROUND (c.unit_price * p.quantity,2) AS Total_amount,
p.purchase_date AS Purchase
FROM learners l 
INNER JOIN purchases P
ON l.learner_id = p.learner_id
inner join courses c 
ON c.course_id = p.course_id
ORDER BY Total_amount DESC;

/*LEFT JOIN*/
SELECT l.full_name AS  Learner_name,
c.course_name AS Course_name ,
c.category AS Category,
p.quantity AS Quantity,
ROUND (c.unit_price * p.quantity,2) AS Total_amount,
p.purchase_date AS Purchase
FROM learners l 
LEFT JOIN purchases p 
ON l.learner_id = p.learner_id
LEFT JOIN courses c 
ON c.course_id = p.course_id
ORDER BY Total_amount DESC;

/*RIGHT JOIN*/
SELECT l.full_name AS  Learner_name,
c.course_name AS Course_name ,
c.category AS Category,
p.quantity AS Quantity,
ROUND (c.unit_price * p.quantity,2) AS Total_amount,
p.purchase_date AS Purchase
FROM learners l 
RIGHT JOIN purchases p 
ON l.learner_id = p.learner_id
RIGHT JOIN courses c 
ON c.course_id = p.course_id
ORDER BY Total_amount DESC;

/*Core Analytical Queries*/
/*Q1:Display each learner’s total spending with their country*/
SELECT l.full_name AS learner_name,
l.country AS country,
ROUND(SUM(c.unit_price * p.quantity),2) AS Total_spend
FROM learners l
JOIN purchases p 
ON l.learner_id = p.learner_id
JOIN courses c 
ON c.course_id = p.course_id
GROUP BY l.learner_id,
l.full_name,
l.country
ORDER BY Total_spend DESC;

/*Q2:Find the top 3 most purchased courses by quantity*/
SELECT c.course_name AS course_name,
sum(p.quantity) AS total_quantity
FROM courses c
JOIN purchases p 
ON c.course_id = p.course_id
GROUP BY c.course_id,c.course_name
ORDER BY total_quantity DESC
LIMIT 3;

/*Q3:Show each category’s:Total revenue,Number of unique learners*/
SELECT c.category AS category,
ROUND(SUM(c.unit_price * p.quantity),2) AS Total_revenue,
COUNT(DISTINCT(p.learner_id)) AS Unique_learners
FROM courses c
JOIN purchases p
ON c.course_id = p.course_id
GROUP BY c.category
ORDER BY Unique_learners DESC;

/*Q4:List learners who purchased from more than one category*/
SELECT l.full_name AS learners_name,
COUNT(DISTINCT(c.category)) AS categary_count
FROM learners l 
JOIN purchases p 
ON l.learner_id = p.learner_id
JOIN courses c
ON p.course_id = c.course_id
GROUP BY l.learner_id,
l.full_name
HAVING categary_count > 1;

/*Q5. Identify courses never purchased*/
SELECT c.course_id,c.course_name,c.unit_price
FROM courses c 
LEFT JOIN purchases p 
ON c.course_id = p.course_id
WHERE purchase_id IS NULL;

/*Subqueries & Correlated Subqueries*/
/*Q6. Find learners whose total spending is above the average learner spending*/
SELECT l.full_name AS learners,
SUM(c.unit_price * p.quantity) AS Total_spending
FROM learners l 
LEFT JOIN purchases p 
ON l.learner_id =p.learner_id
LEFT JOIN courses c 
ON c.course_id = p.course_id
GROUP BY l.learner_id,l.full_name
HAVING Total_spending > 
( SELECT AVG(Spending)
FROM 
 (
SELECT  p.learner_id,
SUM(c.unit_price * p.quantity) AS Spending
FROM purchases p
left join courses c
on c.course_id = p.course_id
GROUP BY p.learner_id ) AS Learners_spending
);

/*Q7. Display courses whose price is higher than any course in the ‘Beginner’ category*/
SELECT c.course_id,
c.course_name,
c.unit_price
FROM courses c 
WHERE unit_price > ANY
( SELECT c.unit_price 
from courses
where category = 'beginner'
);

/*Q8.Find learners who spent more than the average spending in their country*/
SELECT l.full_name AS Learners,
l.country AS country,
SUM(c.unit_price * p.quantity) as total_spending
FROM learners l 
LEFT JOIN purchases p 
ON l.learner_id = p.learner_id
left join courses c 
on c.course_id = p.course_id
group by l.learner_id,
l.full_name,
l.country
HAVING total_spending >
(
SELECT AVG (country_total.SPENDING)
FROM
( SELECT l.full_name,
l.learner_id,
l.country,
SUM(c.unit_price * p.quantity) AS SPENDING
from learners l
LEFT JOIN purchases p
on l.learner_id = p.learner_id
left join courses c
on c.course_id = p.course_id
where country
GROUP BY l.learner_id,
l.country ) AS country_total
);

/*CTE, CASE, View, and NULL Handling*/
/*Q9.Use a CTE to calculate total spending per learner,then Display learners with spending above 10,000*/
with learner_spending AS 
( 
SELECT l.learner_id,
l.full_name,
SUM(c.unit_price * p.quantity) AS total_spending
FROM learners l 
LEFT JOIN purchases p 
ON l.learner_id = p.learner_id
LEFT JOIN courses c 
ON c.course_id = p.course_id
GROUP BY l.learner_id,l.full_name 
)
SELECT *
FROM learner_spending
WHERE total_spending > 10000;

/*Q10. CASE Expression 
Classify learners based on spending:Above 15,000 → “High Value”,8,000–15,000 → “Medium Value”, Below 8,000 → “Low Value”*/
SELECT l.full_name as learners_name,
SUM(c.unit_price * p.quantity) AS total_spending,
CASE
WHEN SUM(c.unit_price * p.quantity)> 15000
THEN 'High Value'
WHEN SUM(c.unit_price * p.quantity) between 8000 and 15000
THEN 'Medium Value'
ELSE 'Low Value'
END AS Spending
FROM learners l 
LEFT JOIN purchases p 
ON l.learner_id = p.learner_id
LEFT JOIN courses c 
ON c.course_id = p.course_id
GROUP BY l.learner_id,l.full_name;

/*Q11.NULL Handling 
Display all courses and replace NULL purchase counts with 0 using: IFNULL() or 
COALESCE()*/
SELECT
c.course_id,
c.course_name,
COALESCE(SUM(p.quantity), 0) AS purchase_count
FROM courses c
LEFT JOIN purchases p
ON c.course_id = p.course_id
GROUP BY
c.course_id,
c.course_name;

/*Q12 . View,Create a view: category_performance_view,Showing, 
Category,Total revenue,Number of purchases ,Average revenue per purchase*/
CREATE VIEW category_performance_view AS
SELECT
c.category,
SUM(c.unit_price * p.quantity) AS total_revenue,
COUNT(p.purchase_id) AS number_of_purchases,
SUM(c.unit_price * p.quantity) / COUNT(p.purchase_id)
AS average_revenue_per_purchase
FROM courses c
LEFT JOIN purchases p
ON c.course_id = p.course_id
GROUP BY c.category;

SELECT *
FROM category_performance_view;











