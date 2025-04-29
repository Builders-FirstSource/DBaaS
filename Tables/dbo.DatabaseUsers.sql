CREATE TABLE [dbo].[DatabaseUsers]
(
[Database_GUID] [uniqueidentifier] NOT NULL,
[UserName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ADType] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatabaseRole] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_DatabaseUsers_CreateDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
