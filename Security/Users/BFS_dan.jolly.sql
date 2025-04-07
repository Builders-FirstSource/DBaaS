IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'BFS\dan.jolly')
CREATE LOGIN [BFS\dan.jolly] FROM WINDOWS
GO
CREATE USER [BFS\dan.jolly] FOR LOGIN [BFS\dan.jolly]
GO
