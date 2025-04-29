SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[ImportServerConfigs]
AS
/*
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│         Name: ImportDailyConnections
│ 
│  Description: performs a BCP import on files in the share on DBA01.
│				
│				
│
│
│
╞═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════	
│ Change History: (newest to oldest)
╞
│
├
│
│
│
│
│
│04/15/2025		BFS\adm.nick.ahrens			1.0.0				Created procedure
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│DATE:			AUTHOR:						VERSION:			DESCRIPTION:
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
*/

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @server sysname, @importFile VARCHAR(255), @cmd VARCHAR(2000), @impSuccess tinyint
DECLARE @domains TABLE (domain VARCHAR(64))
INSERT @domains
values ('.ds.buildwithbmc.com'),('.sys.ds.stocksupply.com'),('.probuild.com'),('.bmhc.com'),('.bfs.buildersfirstsource.com'),('.vnscorp.local')

DROP TABLE If EXISTS #servers

CREATE TABLE #servers (serverName sysname, importFile VARCHAR(255))

DROP TABLE IF EXISTS ##ServerConfigs 

CREATE TABLE ##ServerConfigs ([ServerName] [varchar](50),
	[Setting] [varchar](50) ,
	[Minimum] [varchar](50) ,
	[Maximum] [varchar](50) ,
	[Dynamic] [bit] ,
	[Advanced] [bit] ,
	[ConfigValue] [varchar](50),
	[RunValue] [varchar](50) )


INSERT #servers (servername, importFile)

SELECT DISTINCT server_name, REPLACE(REPLACE(server_name,'\','-'),ISNULL(domain,''),'')
FROM SQLInventory.dbo.registeredServers AS RS
LEFT JOIN @domains AS D 
ON rs.server_name LIKE '%'+domain+'%'
WHERE [path]<>'DatabaseEngineServerGroup/Azure'

DROP TABLE IF EXISTS #output
CREATE table #output (processID varchar(36), cmdout varchar(1024)) 

WHILE EXISTS(SELECT serverName FROM #servers) --SELECT * FROM #servers
BEGIN
	SELECT TOP (1) @server=servername, @importFile=importFile FROM #servers 

	SELECT @cmd='bcp ##ServerConfigs IN "S:\ServerFiles\ServerConfigs\'+@importFile+'" -c -S "BFS-SQLDBA01" -T'
	--print @Cmd
	--SELECT * FROM ##ServerConfigs

	EXEC @impSuccess=DBAdmin.dbo._cmdshellWrapperSP @cmd, @processID=@importFile, @successTxt='rows copied'
	--print @impSuccess
	--SELECT * FROM #output

	IF @impSuccess=0
	BEGIN 
		INSERT ServerConfigFileImports (ImportDate, serverName, importFile) VALUES (GETDATE(), @server, @importFile)

		DELETE DBaaS_Dev.dbo.ServerConfigAudit_Staging
		WHERE ServerName = @server

		INSERT DBaaS_Dev.dbo.ServerConfigAudit_Staging	([ServerName]
      ,[Setting]
      ,[Minimum]
      ,[Maximum]
      ,[Dynamic]
      ,[Advanced]
      ,[ConfigValue]
      ,[RunValue])
	
		SELECT [ServerName]
      ,[Setting]
      ,[Minimum]
      ,[Maximum]
      ,[Dynamic]
      ,[Advanced]
      ,[ConfigValue]
      ,[RunValue]
		FROM ##ServerConfigs 
		WHERE ServerName = @server

	

		SELECT @cmd='del "S:\ServerFiles\ServerConfigs\'+@importFile+'"'
		EXEC DBAdmin.dbo._cmdshellWrapperSP @cmd, @processID='Delete file'

		truncate table #output
	END
		
	DELETE S 
	FROM #servers AS S
	WHERE serverName=@server

END

GO
