CREATE TABLE [dbo].[ServerConfigAudit_Prod]
(
[ServerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Setting] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Minimum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Maximum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dynamic] [bit] NULL,
[Advanced] [bit] NULL,
[ConfigValue] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RunValue] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdateDT] [datetime] NULL CONSTRAINT [DF__ServerCon__Updat__778AC167] DEFAULT (getdate()),
[UpdateUser] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__ServerCon__Updat__787EE5A0] DEFAULT (suser_sname())
) ON [PRIMARY]
GO
