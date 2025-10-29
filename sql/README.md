# LaunchMart Loyalty Analytics
## Business Scenario:
LaunchMart is a growing African e-commerce company that recently launched a loyalty program to increase customer retention. Customers earn points when they place orders and extra bonus points during promotions. The Data Team has been asked to analyze customer behavior, revenue performance, and loyalty engagement.

As a data engineer at LaunchMart, my manager has asked me to explore the company's customer, orders, and loyalty program data to help the marketing and operations teams make informed decisions.

This dataset includes customers, products, orders, order items, and loyalty points earned tables.

## Setup
To create the database tables, I have been provided with the database DDL statements in the 01_schema.sql file.

After creating the table, I used the seed data provided in the 02_see_data.sql file to insert sample data into the tables. See the 03_launchMart_erd.png file for the ERD to understand the relationship between the tables.

For a POC and quick delivery which is majorly to gather insight on customer loyalty, I used a cloud native open-source database, Supabase to house the data used for analysis and for the exploratory analysis.
