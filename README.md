# Clinic Booking System — MySQL Database

## ✅ Objective

To design and implement a fully functional relational database system for managing clinic bookings using MySQL, showcasing normalization, relationships, and constraints.

---

## 🏥 Use Case: Clinic Booking System

This system supports:
- Patient registration
- Doctor assignments and departments
- Scheduling and tracking appointments
- Prescribing medications
- Tracking services offered by different doctors

---

## 🧱 Database Structure

| Table             | Description                                       |
|------------------|---------------------------------------------------|
| `departments`     | Stores clinic departments (e.g., Pediatrics)      |
| `doctors`         | Stores doctor info and links them to departments |
| `patients`        | Patient personal details                          |
| `appointments`    | Links patients to doctors with visit details     |
| `services`        | Medical services offered (e.g., X-Ray)           |
| `doctor_services` | M-M relationship between doctors and services    |
| `medications`     | Available medicines                              |
| `prescriptions`   | Medicines prescribed during appointments         |

---

## 🔗 Relationships

- **One-to-Many**: 
  - Departments → Doctors  
  - Patients → Appointments  
  - Doctors → Appointments  

- **Many-to-Many**:
  - Doctors ↔ Services (`doctor_services`)

- **One-to-One**:
  - Appointments → Prescriptions (1 prescription per appointment)

---

## 🔐 Constraints Used

- `PRIMARY KEY` on all main tables  
- `FOREIGN KEY` to ensure referential integrity  
- `UNIQUE` constraints on emails, department/service names  
- `NOT NULL` on essential fields

---

## 📦 Deliverables

- `clinic_booking_system.sql` – SQL file with all `CREATE TABLE` statements
- `README.md` – This documentation file
