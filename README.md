# LIBRARY-MANAGMENT-SYSTEM
Library Management System
Project Description
This project implements a full-featured Library Management System, consisting of two main components:

Database Management System (Question 1): A MySQL database designed to manage books, authors, members, and loans, with proper relational constraints (primary keys, foreign keys, unique constraints, and checks).
CRUD API (Question 2): A Python FastAPI application providing Create, Read, Update, and Delete operations for managing books and authors, connected to the MySQL database.

The system supports tracking book inventory, member registrations, and loan transactions, with a focus on robust database design and API functionality.
How to Run/Setup the Project
Prerequisites

MySQL: Installed and running (e.g., MySQL Community Server).
Python 3.8+: For running the FastAPI application.
Git: To clone the repository.
pip: For installing Python dependencies.

Setup Instructions

Clone the Repository:
git clone <repository_url>
cd library-management-system


Database Setup:

Ensure MySQL is running.
Log in to MySQL:mysql -u root -p


Import the SQL file to create and populate the database:SOURCE database/library_management.sql;


Alternatively, run from the terminal:mysql -u root -p < database/library_management.sql




API Setup:

Navigate to the api directory:cd api


Install Python dependencies:pip install fastapi uvicorn mysql-connector-python


Update the MySQL credentials in api/library_api.py (update db_config with your host, user, password, and database).
Run the FastAPI server:python library_api.py


Access the API at http://localhost:8000/docs for interactive Swagger UI.



Running the Project

The database can be queried directly in MySQL to test the schema and sample data.
The API provides endpoints for managing authors and books:
Authors: POST/GET /authors/, GET/PUT/DELETE /authors/{author_id}
Books: POST/GET /books/, GET/PUT/DELETE /books/{book_id}



