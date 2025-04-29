CREATE TABLE [dbo].[ServerConfigFileImports]
(
[ImportDate] [datetime] NULL,
[serverName] [sys].[sysname] NOT NULL,
[importFile] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
