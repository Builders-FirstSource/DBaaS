CREATE TABLE [dbo].[ServerConfig]
(
[ServerConfig_GUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__ServerCon__Serve__35BCFE0A] DEFAULT (newid()),
[ServerName] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Setting] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SetVal] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdateDT] [datetime] NULL CONSTRAINT [DF__ServerCon__Updat__31EC6D26] DEFAULT (getdate()),
[UpdateUser] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__ServerCon__Updat__32E0915F] DEFAULT (suser_sname())
) ON [PRIMARY]
GO
