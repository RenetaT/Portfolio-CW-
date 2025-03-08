# Portfolio-CW-
Database Principals Portfolio (Coursework)
# SQL Database Principles - Weekly Labs

## Overview
This project contains SQL scripts developed as part of the **Database Principles** module's weekly lab assignments. These scripts were assessed at the end of the module, achieving an outstanding result of **87.00 marks**.

Each lab covers different database concepts, including querying, table creation, relationships, and data manipulation. The SQL scripts are written for **PostgreSQL** and demonstrate essential database principles.

---

## Labs and Features

### **Lab 1: SQL Queries & Joins**
Focus: Querying data using **SELECT**, **JOINs**, and filtering with **WHERE** conditions.
- Find the artist who created an artwork titled *Rainbow*.
- Retrieve all artworks created by a specific artist (*Lolo*).
- List customers who have only purchased artworks priced at **£200 or less**, formatted with a currency symbol and sorted by price.

### **Lab 2: Database Schema & Data Insertion**
Focus: Creating tables, defining **primary keys**, **foreign keys**, and inserting records.
- Created a database for managing animal records, including:
  - **animal_type** table: Stores animal species information.
  - **menagerie** table: Tracks individual animals, their acquisition details, and conservation status.
- Queries:
  - Retrieve all **endangered** animals with their common name, scientific name, individual name, and acquisition date.

### **Lab 3: Movie Database & Relationships**
Focus: Implementing **relational database design** and many-to-many relationships.
- Created tables for managing a movie database:
  - **language**, **actor**, **category**, **film**, **film_actor**, and **film_category** tables.
- Inserted sample data, including:
  - Famous actors (*Robert De Niro, Marlon Brando, Denzel Washington, etc.*).
  - Various movie categories (*Action, Horror, Crime, Adventure*).
  - Films with language details and category associations.
- Established **foreign key constraints** and **composite primary keys**.

### **Lab 5: Advanced SQL Queries and Performance Analysis

In this lab, we focus on writing and optimizing SQL queries using JOIN operations, EXPLAIN ANALYZE for performance evaluation, and database-specific commands. The key objectives include:

Querying Movies by Category: Retrieve movie details based on category, using INNER JOIN to connect tables.
Performance Analysis with EXPLAIN ANALYZE: Compare execution plans for different queries to analyze efficiency.
Database Views Exploration: List the available views within the movie_rental database.
Filtering Movies by Category and Language: Write queries to filter movies by documentary category and Italian as the original language, using both category names and IDs.
Grouping and Aggregation: Count the number of movies per category per original language.


### **  Lab 6: ovie Rental Database
Overview
This lab focuses on performing various SQL operations in the movie_rental database. The tasks involve data updates, indexing, query optimization, and working with views and subqueries.

Tasks Covered
1. Updating Data
Connected to the movie_rental database.
Updated the phone number for an address with address_id = 100.
2. Query Execution & Analysis
Queried the database to verify the update.
Used EXPLAIN ANALYZE to analyze query performance.
3. Indexing for Optimization
Created an index on the phone column of the address table.
Used EXPLAIN ANALYZE again to compare performance before and after indexing.
Removed the created index after evaluation.
4. Creating Views
Created a view named customer_details to store formatted customer information, including names, contact details, and addresses.
5. Working with Subqueries
Retrieved all cities in the United Kingdom using a subquery.
Extended the query to include cities from both the United Kingdom and France, grouping them by country.
6. Challenge Task - Finding Customers Who Rented Action Movies
Used subqueries to list customers who have rented an action movie.
Retrieved their full name and email address, sorted alphabetically.
Key Learnings
Performing data updates and verification in SQL.
Understanding and using EXPLAIN ANALYZE to measure query performance.
Applying indexing to optimize search operations.
Creating and using views for structured data representation.
Writing complex queries with subqueries and JOIN operations.
---

## Installation & Usage
### **Requirements**
- PostgreSQL (Ensure it is installed and running)
- A PostgreSQL-compatible SQL client (e.g., **pgAdmin, DBeaver, or psql CLI**)

### **Setup Instructions**
1. **Connect to PostgreSQL:**
   ```sql
   \c your_database_name
   ```
2. **Run the SQL scripts in order:**
   - Execute **Lab 1** queries for retrieving data from an existing schema.
   - Run **Lab 2** scripts to create and populate the **animal database**.
   - Execute **Lab 3** scripts to create the **movie database**.
3. **Modify and test queries** as needed to explore the data.

---

## Notes & Considerations
- In **Lab 2**, there is a **typo in the column name**: `acquired` is mistakenly spelled as `aquired` in the schema.
- Ensure the correct **database connection** before executing scripts (use `\c database_name`).
- Queries follow best practices, such as **aliasing**, **concatenation for formatting**, and **ordering results** where relevant.

---

## Author & Acknowledgments
- This project was completed as part of the **Database Principles module** at the University of Portsmouth.
- Achieved **87.00 marks** for these lab assessments.

---

## License
This project is for **educational purposes**. Feel free to modify and extend the queries for learning and practice.

