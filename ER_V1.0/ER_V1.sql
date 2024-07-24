CREATE TABLE [tbl_Roles] (
  [Rol_ID] integer PRIMARY KEY IDENTITY(1, 1),
  [Descripcion] varchar(50),
  [created_by] varchar(50),
  [created_at] datetime,
  [modified_by] varchar(50),
  [modified_at] datetime DEFAULT 'getdate()'
)
GO

CREATE TABLE [tbl_Modulo] (
  [Modulo_ID] uniqueidentifier PRIMARY KEY DEFAULT 'newid()',
  [Nombre] varchar(75),
  [Descripcion] varchar(100),
  [created_by] varchar(50),
  [created_at] datetime,
  [modified_by] varchar(50),
  [modified_at] datetime DEFAULT 'getdate()'
)
GO

CREATE TABLE [tbl_Permisos] (
  [Permiso_ID] integer PRIMARY KEY IDENTITY(1, 1),
  [Descripcion] varchar(50),
  [over_modulo] uniqueidentifier,
  [created_by] varchar(50),
  [created_at] datetime,
  [modified_by] varchar(50),
  [modified_at] datetime DEFAULT 'getdate()'
)
GO

CREATE TABLE [tbl_Perfil] (
  [Perfil_ID] uniqueidentifier PRIMARY KEY DEFAULT 'newid()',
  [Rol_ID] integer,
  [Permiso_ID] integer,
  [created_by] varchar(50),
  [created_at] datetime,
  [modified_by] varchar(50),
  [modified_at] datetime DEFAULT 'getdate()'
)
GO

CREATE TABLE [tbl_Users] (
  [User_id] uniqueidentifier PRIMARY KEY,
  [username] varchar(100),
  [email] varchar(100) UNIQUE,
  [password] varchar(100),
  [Perfil_ID] integer,
  [created_by] varchar(50),
  [created_at] datetime,
  [modified_by] varchar(50),
  [modified_at] datetime DEFAULT 'getdate()'
)
GO

CREATE TABLE [tbl_Sessions] (
  [Session_id] integer PRIMARY KEY IDENTITY(1, 1),
  [User_id] uniqueidentifier,
  [Session_at] datetime DEFAULT 'getdate()',
  [Session_from] varchar(100),
  [Session_duration] timestamp
)
GO

ALTER TABLE [tbl_Modulo] ADD FOREIGN KEY ([Modulo_ID]) REFERENCES [tbl_Permisos] ([over_modulo])
GO

ALTER TABLE [tbl_Perfil] ADD FOREIGN KEY ([Rol_ID]) REFERENCES [tbl_Roles] ([Rol_ID])
GO

ALTER TABLE [tbl_Perfil] ADD FOREIGN KEY ([Permiso_ID]) REFERENCES [tbl_Permisos] ([Permiso_ID])
GO

ALTER TABLE [tbl_Users] ADD FOREIGN KEY ([Perfil_ID]) REFERENCES [tbl_Perfil] ([Perfil_ID])
GO

ALTER TABLE [tbl_Sessions] ADD FOREIGN KEY ([User_id]) REFERENCES [tbl_Users] ([User_id])
GO
