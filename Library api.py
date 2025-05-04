from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import mysql.connector
from mysql.connector import Error
from typing import List
from datetime import date

# Initialize FastAPI app
app = FastAPI()

# Database connection configuration
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'your_password',
    'database': 'library_management'
}

# Pydantic models for request/response validation
class Author(BaseModel):
    author_id: int | None = None
    first_name: str
    last_name: str
    birth_year: int | None = None

class Book(BaseModel):
    book_id: int | None = None
    title: str
    author_id: int
    publication_year: int | None = None
    isbn: str | None = None
    total_copies: int = 1
    available_copies: int = 1

# Helper function to connect to MySQL
def get_db_connection():
    try:
        conn = mysql.connector.connect(**db_config)
        return conn
    except Error as e:
        raise HTTPException(status_code=500, detail=f"Database connection failed: {e}")

# CRUD operations for Authors
@app.post("/authors/", response_model=Author)
def create_author(author: Author):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO authors (first_name, last_name, birth_year) VALUES (%s, %s, %s)",
            (author.first_name, author.last_name, author.birth_year)
        )
        conn.commit()
        author.author_id = cursor.lastrowid
        return author
    except Error as e:
        raise HTTPException(status_code=400, detail=f"Error creating author: {e}")
    finally:
        cursor.close()
        conn.close()

@app.get("/authors/", response_model=List[Author])
def read_authors():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM authors")
        authors = cursor.fetchall()
        return authors
    except Error as e:
        raise HTTPException(status_code=500, detail=f"Error reading authors: {e}")
    finally:
        cursor.close()
        conn.close()

@app.get("/authors/{author_id}", response_model=Author)
def read_author(author_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM authors WHERE author_id = %s", (author_id,))
        author = cursor.fetchone()
        if not author:
            raise HTTPException(status_code=404, detail="Author not found")
        return author
    except Error as e:
        raise HTTPException(status_code=500, detail=f"Error reading author: {e}")
    finally:
        cursor.close()
        conn.close()

@app.put("/authors/{author_id}", response_model=Author)
def update_author(author_id: int, author: Author):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "UPDATE authors SET first_name = %s, last_name = %s, birth_year = %s WHERE author_id = %s",
            (author.first_name, author.last_name, author.birth_year, author_id)
        )
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Author not found")
        conn.commit()
        author.author_id = author_id
        return author
    except Error as e:
        raise HTTPException(status_code=400, detail=f"Error updating author: {e}")
    finally:
        cursor.close()
        conn.close()

@app.delete("/authors/{author_id}")
def delete_author(author_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM authors WHERE author_id = %s", (author_id,))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Author not found")
        conn.commit()
        return {"message": "Author deleted"}
    except Error as e:
        raise HTTPException(status_code=400, detail=f"Error deleting author: {e}")
    finally:
        cursor.close()
        conn.close()

# CRUD operations for Books
@app.post("/books/", response_model=Book)
def create_book(book: Book):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO books (title, author_id, publication_year, isbn, total_copies, available_copies) "
            "VALUES (%s, %s, %s, %s, %s, %s)",
            (book.title, book.author_id, book.publication_year, book.isbn, book.total_copies, book.available_copies)
        )
        conn.commit()
        book.book_id = cursor.lastrowid
        return book
    except Error as e:
        raise HTTPException(status_code=400, detail=f"Error creating book: {e}")
    finally:
        cursor.close()
        conn.close()

@app.get("/books/", response_model=List[Book])
def read_books():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM books")
        books = cursor.fetchall()
        return books
    except Error as e:
        raise HTTPException(status_code=500, detail=f"Error reading books: {e}")
    finally:
        cursor.close()
        conn.close()

@app.get("/books/{book_id}", response_model=Book)
def read_book(book_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM books WHERE book_id = %s", (book_id,))
        book = cursor.fetchone()
        if not book:
            raise HTTPException(status_code=404, detail="Book not found")
        return book
    except Error as e:
        raise HTTPException(status_code=500, detail=f"Error reading book: {e}")
    finally:
        cursor.close()
        conn.close()

@app.put("/books/{book_id}", response_model=Book)
def update_book(book_id: int, book: Book):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "UPDATE books SET title = %s, author_id = %s, publication_year = %s, isbn = %s, "
            "total_copies = %s, available_copies = %s WHERE book_id = %s",
            (book.title, book.author_id, book.publication_year, book.isbn, 
             book.total_copies, book.available_copies, book_id)
        )
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Book not found")
        conn.commit()
        book.book_id = book_id
        return book
    except Error as e:
        raise HTTPException(status_code=400, detail=f"Error updating book: {e}")
    finally:
        cursor.close()
        conn.close()

@app.delete("/books/{book_id}")
def delete_book(book_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM books WHERE book_id = %s", (book_id,))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Book not found")
        conn.commit()
        return {"message": "Book deleted"}
    except Error as e:
        raise HTTPException(status_code=400, detail=f"Error deleting book: {e}")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
