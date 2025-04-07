IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'BFS\keith.refior')
CREATE LOGIN [BFS\keith.refior] FROM WINDOWS
GO
CREATE USER [BFS\keith.refior] FOR LOGIN [BFS\keith.refior]
GO
