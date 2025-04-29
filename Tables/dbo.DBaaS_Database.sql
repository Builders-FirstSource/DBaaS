CREATE TABLE [dbo].[DBaaS_Database]
(
[Database_GUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Databases_DatabaseGUID] DEFAULT (newid()),
[DatabaseName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ServerName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DBaaS_Database] ADD CONSTRAINT [PK_Databases] PRIMARY KEY CLUSTERED ([Database_GUID]) ON [PRIMARY]
GO
