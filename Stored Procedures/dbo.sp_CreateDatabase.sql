SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│           Name: sp_CreateDatabase
│ 
│          Description: Generates Statements to create a database with the stored configurations
│
│          Parameters:
│				@DBUID the unique identifier for the database to create
│
│          Author:	Jennifer Burris 
│          Date:	3/17/2025
╞═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════	
│          Change History:
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│DATE:		AUTHOR:			VERSION:		DESCRIPTION:
|3/28/2025	Jennifer Burris	1.1				Now gets the SET commands from ConfigCommands table
|											Save the Create Database script to a file
|											Gets the file location from Dbaas_Parameters
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
*/

CREATE PROCEDURE [dbo].[sp_CreateDatabase]
	@DBUID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @UID uniqueidentifier = @DBUID

--DECLARE @UID uniqueidentifier = 'F2AE39DE-66E9-4A51-A308-6F05DCD03953'

-- Step 1: Get Configurations
DECLARE @FileLocation VARCHAR(128)
SELECT @FileLocation = Value
FROM DBaas_Parameters
WHERE Parameter = 'CreateDB_FileLocation'

DROP TABLE IF EXISTS #Configurations 
CREATE TABLE #Configurations (Setting VARCHAR(128), SetVal VARCHAR(128))
INSERT INTO #Configurations(Setting, SetVal)
EXEC sp_GetConfigurations @GUID = @UID, @ObjectType = NULL

DECLARE @DatabaseName NVARCHAR(128)
DECLARE @ServerName NVARCHAR(128)
DECLARE @Collation NVARCHAR(128)
DECLARE @EnableSnapshotIsolation BIT
DECLARE @RecoveryModel NVARCHAR(10)

--Set Configurations
SELECT @DatabaseName = SetVal
FROM #Configurations WHERE Setting = 'ObjectName'
SELECT @ServerName = SetVal
FROM #Configurations WHERE Setting = 'ServerName'

SELECT @Collation = SetVal
FROM #Configurations WHERE Setting = 'collation_name'
--CREATE Table for Commands
DROP TABLE IF EXISTS #CMD
CREATE TABLE #CMD(CMD VARCHAR(MAX))
-- Step 2: Create the database with collation and recovery model
DECLARE @Sql NVARCHAR(MAX);
SET @Sql = 
N'CREATE DATABASE [' + @DatabaseName + N']
COLLATE ' + @Collation + N'; ';

--Get Configuration Commands
DROP TABLE IF EXISTS #ConfigCMD
CREATE TABLE #configCMD (CommandNum INT NOT NULL IDENTITY,Command VARCHAR(MAX), 
							SortOrder TINYINT)

INSERT INTO #ConfigCMD(Command, SortOrder)
SELECT DISTINCT Command, SortOrder
FROM #Configurations C
JOIN ConfigCommands CC
	ON c.Setting = cc.config
	AND c.[SetVal] = cc.[value]
WHERE CC.Command IS NOT NULL
ORDER BY CC.SortOrder

DROP TABLE IF EXISTS ##CMDOUT
CREATE TABLE ##CMDOUT(Command VARCHAR(MAX))
INSERT INTO ##CMDOUT(Command)
SELECT @Sql
INSERT INTO ##CMDOUT(Command)
SELECT 'ALTER DATABASE ['+@DatabaseName+'] ' + Command
FROM #ConfigCMD ORDER BY SortOrder

DECLARE @FileName VARCHAR(128)
SELECT @FileName = @FileLocation +@ServerName+'_'+@DatabaseName+'.sql'

DECLARE @BCP VARCHAR(128) = 'bcp "SELECT Command FROM ##CMDOUT" queryout "'+@FileName+'" -c -T'
SELECT @BCP
EXEC xp_cmdshell @BCP

DROP TABLE ##CMDOUT
END
GO
