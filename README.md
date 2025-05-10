# LIBRARY-MANAGEMENT-SYSTEM

## 📚 Project Description

This project is a comprehensive **Library Management System** developed for the **Power Learn Project Week 8 Assignment**. It is a database-only implementation that uses **MySQL** to manage:

- Books  
- Authors  
- Members  
- Loans  

The system is designed with a focus on:

- ✅ Strong relational integrity  
- ✅ Primary and foreign key constraints  
- ✅ Unique and check constraints  
- ✅ Real-world Kenyan dataset (names, books, and members)  

---

## 🛠️ Technologies Used

- **MySQL** (Database Engine)
- **SQL** (Structured Query Language)
- **Git** (Version Control)

---

## 📦 Features

- Add and manage book records  
- Register and update members  
- Record loan transactions  
- Track book availability and returns  
- Enforces data integrity with relational constraints  
- Rich sample data featuring Kenyan names and literature  

---

## 🚀 Getting Started

### ✅ Prerequisites

- MySQL Server (e.g., MySQL Community Server 8.0+)
- Git

---

### 📥 Setup Instructions

#### 1. Clone the Repository

```bash
git clone <repository_url>
cd library-management-system
```

#### 2. Start MySQL and Log In

```bash
mysql -u root -p
```

#### 3. Create and Populate the Database

Option 1: From inside MySQL shell

```sql
SOURCE database/library_management.sql;
```

Option 2: From terminal

```bash
mysql -u root -p < database/library_management.sql
```

---

## 🗃️ Database Structure

The system contains the following core tables:

- `authors` – stores author information
- `books` – stores book details and availability
- `members` – stores library member records
- `loans` – tracks loans and return dates

Each table includes constraints to ensure:

- Referential integrity (foreign keys)
- Uniqueness (e.g., ISBNs, emails)
- Validity checks (e.g., positive quantities)

---

## 🧩 Entity-Relationship Diagram (ERD)

An ERD is provided in the `erd/` folder to visualize:

- Table relationships  
- Primary and foreign keys  
- 1-to-many and many-to-many connections  

---

## 🇰🇪 Kenyan Context

This system is tailored to a Kenyan setting with:

- Local names (e.g., Wanjiku Muthoni, Kamau Wanyama)  
- Kenyan literature titles  
- Realistic scenarios and loan records  

---

## 📁 Project Structure

```
library-management-system/
├── database/
│   └── library_management.sql
├── erd/
│   └── erd-diagram.png
├── README.md
```

---

## 📝 License

This project is for educational purposes under the **Power Learn Project**. Free to use and modify with credit.

---

## 🙌 Acknowledgements

- Power Learn Project Team  
- MySQL Documentation  
- Fellow learners and mentors

