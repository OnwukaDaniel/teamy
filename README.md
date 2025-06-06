# 🧠 Teamy – Remote Team Task Board (Flutter + Dart Frog)

**Teamy** is a lightweight Notion/Trello-inspired task board designed for remote teams to collaborate with minimal setup. It supports multiple workspaces, task columns, and full task management.

> **Note:** Due to illness and time constraints, Dart Frog integration was not fully completed. To meet the deadline, local storage was used for user authentication and workspace management instead.

---

## 🚀 Overview

A **full-stack app** built using:

- **Frontend:** Flutter (web + mobile)
- **Backend (planned):** Dart Frog (REST API)

> While the backend was initially planned using Dart Frog, the final submission uses local storage to simulate API persistence and ensure timely delivery.

---

## 🧩 Features

### ✅ Flutter Frontend
- **Authentication**
    - Email/password (mocked with `LocalStorage`)
- **Workspace Management**
    - Create and switch between multiple workspaces
- **Columns**
    - Default: `To Do`, `Doing`, `Done`
    - Add, rename, delete columns
- **Task Management**
    - Tasks have:
        - Descriptions
        - Deadlines
        - Tags
        - Comment threads

---

## ⚙️ (Planned) Dart Frog Backend

Though not in production, the app was designed with a **backend-first architecture**:

- REST API for:
    - Auth (sign up / sign in)
    - Workspaces (CRUD)
    - Columns (CRUD)
    - Tasks (CRUD)
    - Comments (CRUD)
- Repository + Service Layer pattern
- Modular routing (`routes/` directory)
- Middleware:
    - Logging
    - Authentication checks
- In-memory / SQLite DB for persistence

---

## 🛠️ Architecture & Principles

Teamy was built using modern software architecture practices:

### ✅ Clean Architecture
- **Presentation** → **Domain** → **Data** layers

### ✅ SOLID Principles
- Separation of responsibilities
- Interface-driven design

### ✅ Best Practices
- **DRY**, **KISS**, **YAGNI**
- Dependency injection
- Separation of concerns
- Repository pattern on both frontend and backend (abstracted)

### ✅ Testing Mindset
- Test-first approach for models and services

---

## 📁 Project Structure

```bash
lib/
├── data/              # Repositories and models
├── domain/            # Entities & interfaces
├── presentation/          # UI modules: auth, board, workspace
├── main.dart          # App entry point
