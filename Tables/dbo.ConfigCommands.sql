CREATE TABLE [dbo].[ConfigCommands]
(
[Config] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Value] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Command] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Desc] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SortOrder] [tinyint] NULL
) ON [PRIMARY]
GO
