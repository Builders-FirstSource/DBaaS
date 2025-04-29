CREATE TABLE [dbo].[ServerConfigAudit_Historical]
(
[ServerConfigAudit_Historical] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ServerConfigAudit_Historical_ServerConfigAudit_Historical] DEFAULT (newid()),
[ServerName] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Setting] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DefaultValue] [sql_variant] NULL,
[RunValue] [sql_variant] NULL,
[Comment] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdateDT] [datetime] NULL CONSTRAINT [DF__ServerCon__Updat__09A971A2] DEFAULT (getdate()),
[UpdateUser] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__ServerCon__Updat__0A9D95DB] DEFAULT (suser_sname())
) ON [PRIMARY]
GO
