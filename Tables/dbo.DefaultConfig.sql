CREATE TABLE [dbo].[DefaultConfig]
(
[DefaultConfig_GUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__DefaultCo__Defau__34C8D9D1] DEFAULT (newid()),
[ObjectType] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Setting] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SetVal] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdateDT] [datetime] NULL CONSTRAINT [DF__DefaultCo__Updat__2F10007B] DEFAULT (getdate()),
[UpdateUser] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__DefaultCo__Updat__300424B4] DEFAULT (suser_sname()),
[Automation] [bit] NULL CONSTRAINT [DF_DefaultConfig_Automation] DEFAULT ((0))
) ON [PRIMARY]
GO
