# Olist-Ecommerce-SQL-DATABASE
End-to-end E-commerce SQL analytics project featuring database schema design, data cleaning, constraints, indexing, and advanced business intelligence queries. Includes revenue analysis, customer lifetime value, cohort retention, ranking functions, and performance optimization using PostgreSQL.

# Olist E-Commerce Analytical Database

**Author:** Katlego Mathebula
**Tech Stack:** PostgreSQL, SQL, Data Modeling, Business Intelligence
**Project Type:** End-to-End Data Engineering & Analytics



## Project Overview

This project is a complete end-to-end **relational database design and business intelligence analysis** built using the Olist e-commerce dataset.

It demonstrates:

-  Database schema design
-  Data integrity enforcement
-  Index optimization
-  Data validation & cleaning
-  Advanced SQL analytics
-  Business performance metrics
-  Window functions & cohort analysis

The goal was to transform raw e-commerce data from the Brazilian e-commerce platform Olist into a structured, optimized, and analytics-ready relational database.



## Business Problem

E-commerce companies generate large volumes of transactional data, but raw data alone does not provide insights.

The key business challenges addressed in this project include:

-  Understanding revenue performance
-  Identifying top customers
-  Measuring customer retention
-  Analyzing repeat purchase behavior
-  Tracking monthly revenue trends
-  Improving data quality and consistency
-  Optimizing database performance for analytics

This project simulates a real-world business intelligence environment where data must support strategic decision-making.



## Database Architecture

The database was designed using normalized relational principles.

### Tables Created:

-  `customers`
-  `sellers`
-  `products`
-  `orders`
- `order_items`
-  `payments`
-  `reviews`
-  `geolocation`
-  `product_category_translation`

## Key Features:

- Primary Keys
-  Foreign Key Relationships
-  Composite Keys
-  Referential Integrity
-  Constraints (NOT NULL, CHECK)
-  Proper Data Types

## Performance Optimization

To improve query performance, indexes were created on:

-  Customer IDs
-  Order dates
-  Product IDs
-  Seller IDs
-  Payment records
- Review records

This ensures faster joins and analytics queries on large datasets.


## Data Cleaning & Quality Control

Data quality was enforced using:

NOT NULL Constraints

 CHECK Constraints:

-  Review scores (1–5)
-  Positive prices
-  Positive payment values
-  Valid order statuses

 Handling Missing Values

-  Standardized null product dimensions
-  Ensured data consistency across tables



## Business Intelligence Metrics

This project includes real-world performance indicators:

### Revenue Analysis

- Total Revenue
-  Monthly Revenue Trend
-  Cumulative Revenue (Running Total)

### Sales Performance

- Total Orders
-  Average Order Value

###  Customer Analytics

-  Customer Lifetime Value (Top 10)
-  Repeat Purchase Rate
-  Customer Retention Cohort Analysis
-  Ranked Customers using `RANK()`


##  Advanced SQL Techniques Used

-  `JOIN` operations
-  Aggregate functions (`SUM`, `COUNT`, `AVG`)
- `GROUP BY`
-  `DATE_TRUNC`
-  Window functions:

- `RANK()`
-  `SUM() OVER()`
- Common Table Expressions (CTEs)
-  Cohort analysis logic
-  Filtering with `FILTER`
-  Subqueries



## Analytical Insights Enabled

This database supports:

-  Revenue forecasting
-  Customer segmentation
-  Retention modeling
-  Sales performance tracking
-  Business growth analysis
-  Strategic decision-making



## How to Run This Project

### a.  Create Database

```sql
CREATE DATABASE olist_ecommerce;
```

### b. Run Schema Script

Execute the table creation script in PostgreSQL.

### c. Import CSV Files

Use `COPY` to load datasets.

### d. Run Validation Queries

Verify row counts and constraints.
Execute Analytics Queries

Explore revenue, customers, and trends.


About the Author
*Katlego Mathebula*
Mathematical Sciences Graduate
