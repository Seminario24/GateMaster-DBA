-- Creación de la base de datos
CREATE DATABASE "gate-master"
    WITH 
    OWNER = your_username,  -- Reemplaza 'your_username' con el nombre del propietario
    ENCODING = 'UTF8',
    LC_COLLATE = 'en_US.UTF-8',
    LC_CTYPE = 'en_US.UTF-8',
    TABLESPACE = pg_default,
    CONNECTION LIMIT = -1;


-- Conectarse a la base de datos "gate-master"
\c "gate-master"

-- Extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";  -- Para generar UUIDs

-- Creación de tablas

CREATE TABLE tbl_App (
    app_id BIGINT PRIMARY KEY,
    app_name VARCHAR(30),
    app_description VARCHAR(50),
    app_version VARCHAR(15),
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE
);

CREATE TABLE tbl_Module (
    module_id BIGINT PRIMARY KEY,
    app_id BIGINT,
    name VARCHAR(30),
    active BOOLEAN,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_tbl_module_app
        FOREIGN KEY(app_id) 
            REFERENCES tbl_App(app_id)
);

CREATE TABLE tbl_User_history (
    history_number SERIAL PRIMARY KEY,
    user_id UUID,
    allow BOOLEAN,
    username VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    password VARCHAR(250),
    email VARCHAR(60),
    active BOOLEAN,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_user_history_user
        FOREIGN KEY(user_id) 
            REFERENCES tbl_User(user_id)
);

CREATE TABLE tbl_Audit_User (
    histoy_id SERIAL PRIMARY KEY,
    user_id UUID,
    effective_date DATE,
    module_affected BIGINT,
    resourse_affected BIGINT,
    change_code INT,
    change_description VARCHAR(100),
    CONSTRAINT fk_audit_user_user
        FOREIGN KEY(user_id) 
            REFERENCES tbl_User(user_id)
);

CREATE TABLE tbl_User (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    allow BOOLEAN,
    username VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    password VARCHAR(250),
    email VARCHAR(60) UNIQUE,
    active BOOLEAN,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE
);

CREATE TABLE tbl_Role (
    role_id BIGINT PRIMARY KEY,
    name VARCHAR(20) UNIQUE,
    active BOOLEAN,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE
);

CREATE TABLE tbl_Permission (
    permission_id BIGINT PRIMARY KEY,
    type VARCHAR(10),
    name VARCHAR(20) UNIQUE,
    active BOOLEAN,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE
);

CREATE TABLE tbl_Resource (
    resource_id BIGINT PRIMARY KEY,
    name VARCHAR(30),
    active BOOLEAN,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE
);

CREATE TABLE tbl_User_App (
    user_app_id BIGINT PRIMARY KEY,
    user_id UUID,
    app_id BIGINT,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_user_app_user
        FOREIGN KEY(user_id) 
            REFERENCES tbl_User(user_id),
    CONSTRAINT fk_user_app_app
        FOREIGN KEY(app_id) 
            REFERENCES tbl_App(app_id)
);

CREATE TABLE tbl_User_Role (
    user_role_id BIGINT PRIMARY KEY,
    user_id UUID,
    role_id BIGINT,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_user_role_user
        FOREIGN KEY(user_id) 
            REFERENCES tbl_User(user_id),
    CONSTRAINT fk_user_role_role
        FOREIGN KEY(role_id) 
            REFERENCES tbl_Role(role_id)
);

CREATE TABLE tbl_Role_Role (
    role_role_id BIGINT PRIMARY KEY,
    parent_role_id BIGINT,
    child_role_id BIGINT,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_role_role_parent
        FOREIGN KEY(parent_role_id) 
            REFERENCES tbl_Role(role_id),
    CONSTRAINT fk_role_role_child
        FOREIGN KEY(child_role_id) 
            REFERENCES tbl_Role(role_id)
);

CREATE TABLE tbl_Role_Permission (
    role_permission_id BIGINT PRIMARY KEY,
    role_id BIGINT,
    permission_id BIGINT,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_role_permission_role
        FOREIGN KEY(role_id) 
            REFERENCES tbl_Role(role_id),
    CONSTRAINT fk_role_permission_permission
        FOREIGN KEY(permission_id) 
            REFERENCES tbl_Permission(permission_id)
);

CREATE TABLE tbl_Permission_Resource (
    permission_resource_id BIGINT PRIMARY KEY,
    permission_id BIGINT,
    resource_id BIGINT,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_permission_resource_permission
        FOREIGN KEY(permission_id) 
            REFERENCES tbl_Permission(permission_id),
    CONSTRAINT fk_permission_resource_resource
        FOREIGN KEY(resource_id) 
            REFERENCES tbl_Resource(resource_id)
);

CREATE TABLE tbl_Module_Resource (
    department_resource_id BIGINT PRIMARY KEY,
    department_id BIGINT,
    resource_id BIGINT,
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_module_resource_module
        FOREIGN KEY(department_id) 
            REFERENCES tbl_Module(module_id),
    CONSTRAINT fk_module_resource_resource
        FOREIGN KEY(resource_id) 
            REFERENCES tbl_Resource(resource_id)
);

CREATE TABLE tbl_Sessions (
    Session_id SERIAL PRIMARY KEY,
    User_id UUID,
    Session_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Session_from VARCHAR(100),
    Session_duration INTERVAL,  -- Ajustado para representar duración
    created_by VARCHAR(20),
    created_on DATE,
    updated_by VARCHAR(20),
    updated_on DATE,
    CONSTRAINT fk_sessions_user
        FOREIGN KEY(User_id) 
            REFERENCES tbl_User(user_id)
);

-- Creación de la vista centralizadora de permisos para cada usuario
CREATE OR REPLACE VIEW vw_UserPermissions AS
SELECT 
    u.user_id,
    u.username,
    u.first_name,
    u.last_name,
    a.app_name,
    m.name AS module_name,
    r.name AS resource_name,
    p.name AS permission_name,
    p.type AS permission_type,
    rle.name AS role_name
FROM 
    tbl_User u
    INNER JOIN tbl_User_App ua ON u.user_id = ua.user_id
    INNER JOIN tbl_App a ON ua.app_id = a.app_id
    INNER JOIN tbl_Module m ON a.app_id = m.app_id
    INNER JOIN tbl_Module_Resource mr ON m.module_id = mr.department_id
    INNER JOIN tbl_Resource r ON mr.resource_id = r.resource_id
    INNER JOIN tbl_Permission_Resource pr ON r.resource_id = pr.resource_id
    INNER JOIN tbl_Permission p ON pr.permission_id = p.permission_id
    INNER JOIN tbl_Role_Permission rp ON p.permission_id = rp.permission_id
    INNER JOIN tbl_Role rle ON rp.role_id = rle.role_id
    INNER JOIN tbl_User_Role ur ON rle.role_id = ur.role_id AND ur.user_id = u.user_id
WHERE 
    u.active = TRUE 
    AND p.active = TRUE 
    AND r.active = TRUE 
    AND m.active = TRUE 
    AND rle.active = TRUE;
