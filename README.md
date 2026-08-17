# 📊 E-Learning Platform Purchase Analysis Using MySQL

## 📌 Project Overview

This project is part of the **Data Analytics – Module-End 3 Assignment**.

The project focuses on analyzing an E-Learning Platform's purchase data using **MySQL**. The database contains learner, course, and purchase information.

The analysis helps understand **learner spending, course popularity, category revenue, and purchasing behavior**.

## 🎯 Objectives

- Create a relational database using MySQL.
- Create Learners, Courses, and Purchases tables.
- Establish Primary Key and Foreign Key relationships.
- Insert and analyze sample data.
- Use INNER, LEFT, and RIGHT JOINs.
- Analyze learner spending and course purchases.
- Apply subqueries, CTE, CASE, and NULL handling.
- Create a SQL View for category performance.

## 🛠️ Tools & Technologies

- MySQL
- MySQL Workbench
- SQL

## 🗄️ Database Structure

### Learners

| Column | Description |
|---|---|
| `learner_id` | Primary Key |
| `full_name` | Learner Name |
| `country` | Country |

### Courses

| Column | Description |
|---|---|
| `course_id` | Primary Key |
| `course_name` | Course Name |
| `category` | Course Category |
| `unit_price` | Course Price |

### Purchases

| Column | Description |
|---|---|
| `purchase_id` | Primary Key |
| `learner_id` | Foreign Key |
| `course_id` | Foreign Key |
| `quantity` | Quantity Purchased |
| `purchase_date` | Purchase Date |

## 🔍 SQL Analysis

### Joins

Used:

- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`

Combined learner, course, and purchase data and calculated:

```text
Total Amount = Quantity × Unit Price
## 📈 Data Analysis

The purchase data was analyzed using SQL aggregation and filtering techniques to understand:

- Learner spending behavior
- Course popularity
- Category-wise revenue
- Number of unique learners
- Learners purchasing from multiple categories
- Courses with no purchase records

Key SQL concepts used:

- `SUM()`
- `COUNT()`
- `COUNT(DISTINCT)`
- `AVG()`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`

## 🔎 Advanced SQL Analysis

Advanced SQL techniques were used to compare learner spending and course prices.

The project includes:

- Subqueries
- Multi-row subqueries
- Correlated subqueries
- Common Table Expressions (CTE)
- `CASE` expressions
- `IFNULL()` and `COALESCE()`
- SQL Views

Learners were also classified into **High Value, Medium Value, and Low Value** based on their spending.

A reusable `category_performance_view` was created to summarize category revenue, purchase count, and average revenue per purchase.

## 📊 Key Outcomes

- Analyzed learner and course purchase behavior.
- Identified popular courses and high-performing categories.
- Compared learner spending with overall and country-level averages.
- Identified unpurchased courses.
- Applied advanced SQL techniques for business analysis.
- Created a reusable SQL View for category performance.

## 🧠 Skills Demonstrated

- MySQL Database Design
- SQL Joins
- Aggregation & Filtering
- Subqueries
- Correlated Subqueries
- CTE
- CASE Expressions
- NULL Handling
- SQL Views
- Revenue Analysis

## 📌 Conclusion

This project demonstrates the practical use of **MySQL for Data Analysis** by combining database design, SQL querying, aggregation, advanced SQL techniques, and views.

The analysis provides meaningful insights into **learner behavior, course performance, category revenue, and purchasing patterns**, supporting data-driven business decisions.

