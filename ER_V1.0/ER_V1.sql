/*
  Estos scripts fueron generados desde SQL Server versión:

      Microsoft SQL Server 2019 (RTM) - 15.0.2000.5 (X64)   
      Sep 24 2019 13:48:23   
      Copyright (C) 2019 Microsoft Corporation  
      Developer Edition (64-bit) on Windows 10 Home 10.0 <X64> (Build 22631: ) 
      (Hypervisor) 
*/

--> Creación de la base de datos
CREATE DATABASE [gate-master]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'gate-master', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\gate-master.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'gate-master_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\gate-master_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [gate-master] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [gate-master] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [gate-master] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [gate-master] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [gate-master] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [gate-master] SET ARITHABORT OFF 
GO
ALTER DATABASE [gate-master] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [gate-master] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [gate-master] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [gate-master] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [gate-master] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [gate-master] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [gate-master] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [gate-master] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [gate-master] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [gate-master] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [gate-master] SET  DISABLE_BROKER 
GO
ALTER DATABASE [gate-master] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [gate-master] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [gate-master] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [gate-master] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [gate-master] SET  READ_WRITE 
GO
ALTER DATABASE [gate-master] SET RECOVERY FULL 
GO
ALTER DATABASE [gate-master] SET  MULTI_USER 
GO
ALTER DATABASE [gate-master] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [gate-master] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [gate-master] SET DELAYED_DURABILITY = DISABLED 
GO
USE [gate-master]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [gate-master]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [gate-master] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

--> Creación de tablas y relaciones
;USE gate-master

CREATE TABLE [tbl_App] (
  [app_id] BIGINT PRIMARY KEY,
  [app_name] VARCHAR(30),
  [app_description] VARCHAR(50),
  [app_version] VARCHAR(15),
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Module] (
  [module_id] BIGINT PRIMARY KEY,
  [app_id] BIGINT,
  [name] BIGINT,
  [active] BOOLEAN,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_User_history] (
  [history_number] INT PRIMARY KEY IDENTITY(1, 1),
  [user_id] uniqueidentifier,
  [allow] BOOLEAN,
  [username] VARCHAR(20),
  [first_name] VARCHAR(20),
  [last_name] VARCHAR(20),
  [password] VARCHAR(250),
  [email] VARCHAR(60),
  [active] BOOLEAN,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Audit_User] (
  [histoy_id] INT PRIMARY KEY IDENTITY(1, 1),
  [user_id] uniqueidentifier,
  [effective_date] DATE,
  [module_affected] BIGINT,
  [resourse_affected] BIGINT,
  [change_code] INT,
  [change_description] VARCHAR(100)
)
GO

CREATE TABLE [tbl_User] (
  [user_id] uniqueidentifier PRIMARY KEY DEFAULT 'newid()',
  [allow] BOOLEAN,
  [username] VARCHAR(20),
  [first_name] VARCHAR(20),
  [last_name] VARCHAR(20),
  [password] VARCHAR(250),
  [email] VARCHAR(60) UNIQUE,
  [active] BOOLEAN,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Role] (
  [role_id] BIGINT PRIMARY KEY,
  [name] VARCHAR(20) UNIQUE,
  [active] BOOLEAN,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Permission] (
  [permission_id] BIGINT PRIMARY KEY,
  [type] VARCHAR(10),
  [name] VARCHAR(20) UNIQUE,
  [active] BOOLEAN,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Resource] (
  [resource_id] BIGINT PRIMARY KEY,
  [name] VARCHAR(30),
  [active] BOOLEAN,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_User_App] (
  [user_app_id] BIGINT PRIMARY KEY,
  [user_id] uniqueidentifier,
  [app_id] BIGINT,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_User_Role] (
  [user_role_id] BIGINT PRIMARY KEY,
  [user_id] uniqueidentifier,
  [role_id] BIGINT,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Role_Role] (
  [role_role_id] BIGINT PRIMARY KEY,
  [parent_role_id] BIGINT,
  [child_role_id] BIGINT,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Role_Permission] (
  [role_permission_id] BIGINT PRIMARY KEY,
  [role_id] BIGINT,
  [permission_id] BIGINT,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Permission_Resource] (
  [permission_resource_id] BIGINT PRIMARY KEY,
  [permission_id] BIGINT,
  [resource_id] BIGINT,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Module_Resource] (
  [department_resource_id] BIGINT PRIMARY KEY,
  [department_id] BIGINT,
  [resource_id] BIGINT,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

CREATE TABLE [tbl_Sessions] (
  [Session_id] integer PRIMARY KEY IDENTITY(1, 1),
  [User_id] uniqueidentifier,
  [Session_at] datetime DEFAULT 'getdate()',
  [Session_from] varchar(100),
  [Session_duration] timestamp,
  [created_by] VARCHAR(20),
  [created_on] DATE,
  [updated_by] VARCHAR(20),
  [updated_on] DATE
)
GO

ALTER TABLE [tbl_Module] ADD FOREIGN KEY ([app_id]) REFERENCES [tbl_App] ([app_id])
GO

ALTER TABLE [tbl_User_history] ADD FOREIGN KEY ([user_id]) REFERENCES [tbl_User] ([user_id])
GO

ALTER TABLE [tbl_Audit_User] ADD FOREIGN KEY ([user_id]) REFERENCES [tbl_User] ([user_id])
GO

ALTER TABLE [tbl_User_App] ADD FOREIGN KEY ([user_id]) REFERENCES [tbl_User] ([user_id])
GO

ALTER TABLE [tbl_User_App] ADD FOREIGN KEY ([app_id]) REFERENCES [tbl_App] ([app_id])
GO

ALTER TABLE [tbl_User_Role] ADD FOREIGN KEY ([user_id]) REFERENCES [tbl_User] ([user_id])
GO

ALTER TABLE [tbl_User_Role] ADD FOREIGN KEY ([role_id]) REFERENCES [tbl_Role] ([role_id])
GO

ALTER TABLE [tbl_Role_Role] ADD FOREIGN KEY ([parent_role_id]) REFERENCES [tbl_Role] ([role_id])
GO

ALTER TABLE [tbl_Role_Role] ADD FOREIGN KEY ([child_role_id]) REFERENCES [tbl_Role] ([role_id])
GO

ALTER TABLE [tbl_Role_Permission] ADD FOREIGN KEY ([role_id]) REFERENCES [tbl_Role] ([role_id])
GO

ALTER TABLE [tbl_Role_Permission] ADD FOREIGN KEY ([permission_id]) REFERENCES [tbl_Permission] ([permission_id])
GO

ALTER TABLE [tbl_Permission_Resource] ADD FOREIGN KEY ([permission_id]) REFERENCES [tbl_Permission] ([permission_id])
GO

ALTER TABLE [tbl_Permission_Resource] ADD FOREIGN KEY ([resource_id]) REFERENCES [tbl_Resource] ([resource_id])
GO

ALTER TABLE [tbl_Module_Resource] ADD FOREIGN KEY ([department_id]) REFERENCES [tbl_Module] ([module_id])
GO

ALTER TABLE [tbl_Module_Resource] ADD FOREIGN KEY ([resource_id]) REFERENCES [tbl_Resource] ([resource_id])
GO

ALTER TABLE [tbl_Sessions] ADD FOREIGN KEY ([User_id]) REFERENCES [tbl_User] ([user_id])
GO


--> Creación de vista centralizadora de permisos para cada usuario.
;CREATE VIEW vw_UserPermissions AS
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
    u.active = 1 AND p.active = 1 AND r.active = 1 AND m.active = 1 AND rle.active = 1