CREATE TABLE [dbo].[DatabaseConfig]
(
[DBConfig_GUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__DatabaseC__DBCon__398D8EEE] DEFAULT (newid()),
[Database_GUID] [uniqueidentifier] NOT NULL,
[Setting] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SetVal] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UpdateDT] [datetime] NOT NULL CONSTRAINT [DF__DatabaseC__Updat__3A81B327] DEFAULT (getdate()),
[UpdateUser] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__DatabaseC__Updat__3B75D760] DEFAULT (suser_sname())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DatabaseConfig] ADD CONSTRAINT [FK_DatabaseConfig_Databases] FOREIGN KEY ([Database_GUID]) REFERENCES [dbo].[Databases] ([Database_GUID])
GO
