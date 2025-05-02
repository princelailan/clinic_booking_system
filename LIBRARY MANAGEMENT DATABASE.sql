-- Library Management System Database
-- This script creates a MySQL database for managing a library, including tables for authors, books, members, and loans.
-- It includes constraints (PK, FK, NOT NULL, UNIQUE, CHECK) and a comprehensive sample dataset with Kenyan names.

-- Creating the database
CREATE DATABASE library_management;
USE library_management;

-- Table for authors: Stores author information
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year INT,
    UNIQUE (first_name, last_name, birth_year) -- Ensures no duplicate authors
);

-- Table for books: Stores book details, linked to authors
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    publication_year INT,
    isbn VARCHAR(13) UNIQUE, -- Unique ISBN for each book
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    CONSTRAINT chk_copies CHECK (available_copies <= total_copies), -- Ensures available copies don't exceed total
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE RESTRICT -- Links to authors table
);

-- Table for members: Stores library member information
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, -- Unique email for each member
    join_date DATE NOT NULL,
    phone VARCHAR(15)
);

-- Table for loans: Manages book loans (many-to-many relationship between books and members)
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE RESTRICT, -- Links to books table
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE RESTRICT -- Links to members table
);

-- Inserting sample data into authors with Kenyan names
INSERT INTO authors (first_name, last_name, birth_year) VALUES
('Wanjiku。でも、なぜか日本語の文字が紛れ込んでいますね！', 'Muthoni', 1970),
('Kipchoge', 'Ngeno', 1965),
('Akinyi', 'Ochieng', 1980),
('Musa', 'Wekesa', 1975),
('Fatuma', 'Njeri', 1968),
('Kibet', 'Langat', 1985),
('Wambui', 'Kamau', 1972),
('Okoth', 'Odhiambo', 1978),
('Chebet', 'Rono', 1982),
('Juma', 'Mwangi', 1960);

-- Inserting sample data into books
INSERT INTO books (title, author_id, publication_year, isbn, total_copies, available_copies) VALUES
('The River and the Source', 1, 1994, '9789966882059', 5, 3),
('Dust', 2, 2014, '9789966155337', 3, 2),
('Coming to Birth', 3, 1987, '9789966460080', 4, 4),
('Petals of Blood', 4, 1977, '9780143039174', 6, 5),
('Weep Not, Child', 4, 1964, '9780143026242', 4, 2),
('A Grain of Wheat', 4, 1967, '9780143026761', 5, 4),
('The Promised Land', 5, 2019, '9789966650085', 3, 1),
('Bila Kasheshe', 6, 2006, '9789966700803', 4, 3),
('Kidagaa Kimemwozea', 6, 2010, '9789966496935', 5, 5),
('Across the Bridge', 7, 1979, '9789966463456', 3, 2),
('Nairobi Noir', 8, 2020, '9781617757549', 4, 3),
('The Perfect Nine', 8, 2020, '9781529111651', 3, 2),
('The Havoc of Choice', 9, 2020, '9789966650337', 4, 4),
('Matigari', 10, 1987, '9780435905460', 5, 3),
('Devil on the Cross', 10, 1980, '9780435908447', 4, 2);

-- Inserting sample data into members with Kenyan names
INSERT INTO members (first_name, last_name, email, join_date, phone) VALUES
('Kamau', 'Wanyama', 'kamau.wanyama@example.com', '2025-01-15', '254-700-123456'),
('Njeri', 'Maina', 'njeri.maina@example.com', '2025-01-20', '254-711-654321'),
('Otieno', 'Kiptoo', 'otieno.kiptoo@example.com', '2025-02-01', '254-722-987654'),
('Achieng', 'Onyango', 'achieng.onyango@example.com', '2025-02-05', '254-733-112233'),
('Kiprono', 'Mutai', 'kiprono.mutai@example.com', '2025-02-10', '254-744-445566'),
('Wairimu', 'Gichuki', 'wairimu.gichuki@example.com', '2025-02-15', '254-755-778899'),
('Muthoni', 'Kariuki', 'muthoni.kariuki@example.com', '2025-02-20', '254-766-990011'),
('Ochieng', 'Njoroge', 'ochieng.njoroge@example.com', '2025-02-25', '254-777-223344'),
('Jelagat', 'Koech', 'jelagat.koech@example.com', '2025-03-01', '254-788-556677'),
('Hassan', 'Mwendwa', 'hassan.mwendwa@example.com', '2025-03-05', '254-799-889900'),
('Zainab', 'Auma', 'zainab.auma@example.com', '2025-03-10', '254-710-112233'),
('Kipkurui', 'Sang', 'kipkurui.sang@example.com', '2025-03-15', '254-721-445566');

-- Inserting sample data into loans
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(1, 1, '2025-02-15', '2025-03-01', NULL),
(2, 2, '2025-02-20', '2025-03-06', '2025-02-25'),
(3, 3, '2025-02-25', '2025-03-11', NULL),
(4, 4, '2025-02-28', '2025-03-14', '2025-03-10'),
(5, 5, '2025-03-01', '2025-03-15', NULL),
(6, 6, '2025-03-02', '2025-03-16', '2025-03-12'),
(7, 7, '2025-03-03', '2025-03-17', NULL),
(8, 8, '2025-03-04', '2025-03-18', NULL),
(9, 9, '2025-03-05', '2025-03-19', '2025-03-15'),
(10, 10, '2025-03-06', '2025-03-20', NULL),
(11, 11, '2025-03-07', '2025-03-21', NULL),
(12, 12, '2025-03-08', '2025-03-22', '2025-03-18'),
(1, 2, '2025-03-09', '2025-03-23', NULL),
(3, 4, '2025-03-10', '2025-03-24', NULL),
(5, 6, '2025-03-11', '2025-03-25', '2025-03-20'),
(7, 8, '2025-03-12', '2025-03-26', NULL),
(9, 10, '2025-03-13', '2025-03-27', NULL),
(11, 12, '2025-03-14', '2025-03-28', '2025-03-22'),
(13, 1, '2025-03-15', '2025-03-29', NULL),
(15, 3, '2025-03-16', '2025-03-30', NULL);
