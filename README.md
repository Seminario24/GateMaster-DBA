# User Management and Security System

This repository contains the SQL scripts and instructions for implementing a user management and security system. The system includes users, roles, permissions, modules, and their relationships.

## Table of Contents

1. [Introduction](#introduction)
2. [Database Schema](#database-schema)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Schema Overview](#schema-overview)
6. [Contributing](#contributing)
7. [License](#license)

## Introduction

This project aims to create a comprehensive database schema for managing users, roles, permissions, and modules in a security-focused system. It includes the necessary tables and relationships to handle user authentication and authorization.

## Database Schema

The database schema includes the following tables:
- tbl_Roles
- tbl_Modulo
- tbl_Permisos
- tbl_Perfil
- tbl_Users
- tbl_Sessions

## Installation

### Prerequisites

- SQL Server installed on your local machine or a remote server.
- SQL Server Management Studio (SSMS) or any other SQL client tool.

### Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/yourrepository.git
   cd yourrepository

**Open SQL Server Management Studio (SSMS)**

Open a new query window and run the following script to create the database:

1. **Create the Database**

    ```sql
    CREATE DATABASE UserManagementDB;
    USE UserManagementDB;

Now you can run the whole content of the file 'ER_V1.sql' in the ER_V1.0 folder