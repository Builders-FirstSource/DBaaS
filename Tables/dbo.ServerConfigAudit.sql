CREATE TABLE [dbo].[ServerConfigAudit]
(
[ServerConfigAudit_GUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__ServerCon__Serve__5070F446] DEFAULT (newid()),
[ServerName] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Setting] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Minimum] [sql_variant] NULL,
[Maximum] [sql_variant] NULL,
[Dynamic] [bit] NULL,
[Advanced] [bit] NULL,
[ConfigValue] [sql_variant] NULL,
[RunValue] [sql_variant] NULL,
[UpdateDT] [datetime] NULL CONSTRAINT [DF__ServerCon__Updat__5165187F] DEFAULT (getdate()),
[UpdateUser] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__ServerCon__Updat__52593CB8] DEFAULT (suser_sname())
) ON [PRIMARY]
GO
