CREATE TABLE [dbo].[ServerConfigAudit_Staging]
(
[ServerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Setting] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Minimum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Maximum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dynamic] [bit] NULL,
[Advanced] [bit] NULL,
[ConfigValue] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RunValue] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
