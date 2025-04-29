SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│           Name: sp_Create_Get_DBGUID
│ 
│          Description: looks for the database and servername in dbo.databases
|						if not found then it creates the record
|						returns the Database_GUID
│
│          Parameters:
│				@DatabaseName
|				@ServerName - Default BFS-SQLDBA01
│
│          Author:	Jennifer Burris 
│          Date:	3/31/2025
|
|  EXEC sp_Create_Get_DBGUID @DBName = 'DBaaS_Test'
╞═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════	
│          Change History:
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│DATE:		AUTHOR:			VERSION:		DESCRIPTION:
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
*/

CREATE PROCEDURE [dbo].[sp_Create_Get_DBGUID]
	@DBName VARCHAR(120), @ServerName VARCHAR(128) = 'BFS-SQLDBA01'
AS
BEGIN

	SET NOCOUNT ON;
	IF @DBName IS NULL
	BEGIN
		 RAISERROR('A Database Name cannot be NULL', 16, 1)
		 RETURN;
	END

	DECLARE @DBGUID UNIQUEIDENTIFIER

	IF NOT EXISTS (
					SELECT Database_GUID
					FROM DBaaS_Database 
					WHERE DatabaseName = @DBName
					AND ServerName = @ServerName)
		BEGIN
			INSERT INTO DBaaS_Database(DatabaseName, ServerName)
			VALUES (@DBName, @ServerName)
		END

	SELECT @DBGUID = Database_GUID
	FROM DBaaS_Database 
	WHERE DatabaseName = @DBName
	AND ServerName = @ServerName

	SELECT @DBGUID AS Database_GUID

END
GO
